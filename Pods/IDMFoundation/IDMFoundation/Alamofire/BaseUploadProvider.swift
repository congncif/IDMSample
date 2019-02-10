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

public typealias UploadRequestAdapter = BaseRequestAdapter<UploadRequest>

open class BaseUploadProvider<Parameter>: NetworkDataProvider<UploadRequest, Parameter>
    where Parameter: UploadFilesParameterProtocol, Parameter: URLBuildable {
    
    public var encoding: (MultipartFormData, Parameter?) -> Void
    
    public init(route: NetworkRequestRoutable,
                parameterEncoder: ParameterEncoding = URLEncoding.default,
                urlRequestAdapters: [URLRequestAdapting] = [],
                encoding: @escaping (MultipartFormData, Parameter?) -> Void = {
                    guard let param = $1 else { return }
                    $0.append(fileParameter: param)
                },
                requestAdapter: RequestApdapterType? = nil,
                sessionManager: SessionManager = .background) {
        self.encoding = encoding
        super.init(route: route,
                   parameterEncoder: parameterEncoder,
                   urlRequestAdapters: urlRequestAdapters,
                   requestAdapter: requestAdapter,
                   sessionManager: sessionManager)
    }
    
    open override func buildRequest(with parameters: Parameter?) throws -> UploadRequest {
        var request: UploadRequest?
        var error: Error?
        let group = DispatchGroup()
        group.enter()
        
        do {
            let newRequest = try buildURLRequest(with: parameters)
            log(url: newRequest.url, mark: "📦", data: parameters)
            sessionManager.upload(multipartFormData: { [weak self] in self?.encoding($0, parameters) },
                                  with: newRequest) { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    request = upload
                    group.leave()
                case .failure(let encodingError):
                    error = encodingError
                    group.leave()
                }
            }
        } catch let exception {
            error = exception
            group.leave()
        }
        
        group.wait()
        
        guard let _request = request else {
            throw error ?? CommonError(message: "Unknown")
        }
        return _request
    }
    
    open override func cancelRequest(_ request: UploadRequest) {
        request.cancel()
    }
    
    open override func processRequest(_ request: UploadRequest, completion: @escaping (Bool, Any?, Error?) -> Void) {
        request.uploadProgress { progress in
            completion(true, progress, nil)
        }
        
        request.responseJSON { response in
            let isSuccess = response.result.isSuccess
            if isSuccess {
                log(url: response.response?.url, mark: "🌸", data: response.value)
            } else {
                log(url: response.response?.url, mark: "🥀", data: response.error)
            }
            completion(isSuccess, response.value, response.error)
        }
    }
}
