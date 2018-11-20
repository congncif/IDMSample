//
import Alamofire
//  MultipartFormData+Parameter.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 8/29/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//

import Foundation

extension MultipartFormData {
    open func append(urlItem: URLUploadItemProtocol) {
        if let fileName = urlItem.fileName, let mime = urlItem.mimeType {
            self.append(urlItem.uploadUrl, withName: urlItem.uploadName, fileName: fileName, mimeType: mime)
        } else {
            self.append(urlItem.uploadUrl, withName: urlItem.uploadName)
        }
    }
    
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
    
    open func append(urlParameter: UploadURLsParameter) {
        for item in urlParameter.uploadItems {
            self.append(urlItem: item)
        }
        self.append(query: urlParameter.query)
    }
}

extension MultipartFormData {
    open func append(urlItem: UploadFileParameterProtocol) {
        switch urlItem.type {
        case .data(let data):
            if let mime = urlItem.mimeType {
                if let fileName = urlItem.fileName {
                    self.append(data, withName: urlItem.name, fileName: fileName, mimeType: mime)
                } else {
                    self.append(data, withName: urlItem.name, mimeType: mime)
                }
            } else {
                self.append(data, withName: urlItem.name)
            }
        case .fileUrl(let url):
            if let mime = urlItem.mimeType, let fileName = urlItem.fileName {
                self.append(url, withName: urlItem.name, fileName: fileName, mimeType: mime)
                
            } else {
                self.append(url, withName: urlItem.name)
            }
        }
    }
    
    open func append(urlParameter: UploadFilesParameter) {
        for item in urlParameter.uploadItems {
            self.append(urlItem: item)
        }
        self.append(query: urlParameter.query)
    }
}
