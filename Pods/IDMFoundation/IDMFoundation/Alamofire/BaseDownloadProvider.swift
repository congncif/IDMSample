//
//  BaseURLUploadProvider.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 8/29/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//

import Alamofire
import Foundation
import IDMCore
import SiFUtilities

public typealias DownloadRequestAdapter = BaseRequestAdapter<DownloadRequest>

open class BaseDownloadProvider<Parameter>: NetworkDataProvider<DownloadRequest, Parameter>, SimpleAlamofireRequestBuildable where Parameter: DownloadParameterProtocol {
    open override func buildRequest(with parameters: Parameter?) throws -> DownloadRequest {
        var newRequest = try buildEncodedRequest(with: parameters)
        
        let dataRequest = sessionManager.download(newRequest) { (_, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            if let desUrl = parameters?.destinationUrl(suggestedFilename: response.suggestedFilename) {
                return (desUrl, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename ?? String.random())
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        log(url: newRequest.url, mark: "📦", data: parameters?.payload)
        
        return dataRequest
    }
    
    open override func cancelRequest(_ request: DownloadRequest) {
        request.cancel()
    }
    
    open override func processRequest(_ request: DownloadRequest, completion: @escaping (Bool, Any?, Error?) -> Void) {
        request.downloadProgress { progress in
            completion(true, progress, nil)
        }
        
        request.response { response in
            let error = response.error
            
            let isSuccess = error == nil
            if isSuccess {
                log(url: response.response?.url, mark: "🌸", data: response.destinationURL?.absoluteString)
            } else {
                log(url: response.response?.url, mark: "🥀", data: response.error)
            }
            
            completion(isSuccess, response, error)
        }
    }
}
