//
//  MultipartFormData+Parameter.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 8/29/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//
import Alamofire
import Foundation

extension MultipartFormData {
    open func append(query: StringKeyValueProtocol?) {
        guard let q = query else {
            return
        }
        for (key, value) in q.queryParameters {
            if let data = value.data(using: String.Encoding.utf8) {
                self.append(data, withName: key)
            }
        }
    }
    
    open func append(fileItem: UploadFileParameterProtocol) {
        switch fileItem.type {
        case .data(let data):
            if let mime = fileItem.mimeType {
                if let fileName = fileItem.fileName {
                    self.append(data, withName: fileItem.name, fileName: fileName, mimeType: mime)
                } else {
                    self.append(data, withName: fileItem.name, mimeType: mime)
                }
            } else {
                self.append(data, withName: fileItem.name)
            }
        case .fileUrl(let url):
            if let mime = fileItem.mimeType, let fileName = fileItem.fileName {
                self.append(url, withName: fileItem.name, fileName: fileName, mimeType: mime)
                
            } else {
                self.append(url, withName: fileItem.name)
            }
        }
    }
    
    open func append(fileParameter: UploadFilesParameterProtocol) {
        for item in fileParameter.uploadItems {
            self.append(fileItem: item)
        }
        self.append(query: fileParameter.query)
    }
}
