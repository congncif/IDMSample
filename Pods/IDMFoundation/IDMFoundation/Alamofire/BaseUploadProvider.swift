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

open class BaseUploadProvider<ParameterType>: BaseTaskProvider<ParameterType> {
    private var uploader: Request?
    open lazy var sessionManager: SessionManager = {
        customSessionManager
    }()
    
    open var customSessionManager: SessionManager {
        let id = "uploader." + String.random()
        let configuration = URLSessionConfiguration.background(withIdentifier: id)
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let session = SessionManager(configuration: configuration)
        return session
    }
    
    open override func request(parameters: ParameterType?,
                               completion: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        guard let parameters = parameters else {
            #if DEBUG
                log("Upload provider don't accept no-parameters")
            #endif
            completion(false, nil, nil)
            return nil
        }
        
        if let err = validate(parameters: parameters) {
            completion(false, nil, err)
            return nil
        }
        
        if let data = testResponseData(parameters: parameters) {
            completion(data.0, data.1, data.2)
            return nil
        }
        
        if trackingProgressEnabled {
            if let _ = uploader {
                #if DEBUG
                    log("Tracking Progress is Enabled. You should begin only one upload request at the same time. Or consider to set Tracking Progress to disabled.")
                #endif
                completion(false, nil, nil)
                return nil
            }
        }
        
        let path = requestPath(parameters: parameters)
        let method = httpMethod(parameters: parameters)
        let header = headers(parameters: parameters)
        
        if logEnabled(parameters: parameters) {
            var param: [String: Any]?
            if let paramX = parameters as? ParameterProtocol {
                param = paramX.parameters
            }
            ProviderConfiguration.shared.logger.logRequest(title: "Upload", path: requestPath(parameters: parameters), parameters: param)
        }
        
        saveTemporary(parameters: parameters)
        
        sessionManager.upload(multipartFormData: { [weak self] multipart in
            self?.buildFormData(multipart: multipart, with: parameters)
        }, to: path, method: method, headers: header) { [weak self] encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                self?.customRequest(upload)
                
                upload.uploadProgress { [weak self] progress in
                    if self?.trackingProgressEnabled == true {
                        completion(true, progress, nil)
                    }
                }
                
                upload.responseJSON { [weak self] response in
                    guard let this = self else {
                        completion(false, nil, nil)
                        return
                    }
                    
                    self?.cleanUp(parameters: parameters)
                    let result = this.preprocessResponse(response)
                    if this.logEnabled(parameters: parameters) {
                        ProviderConfiguration.shared.logger.logDataResponse(response)
                    }
                    completion(result.success, result.value, result.error)
                    self?.uploader = nil
                }
                
                self?.uploader = upload
                
            case .failure(let encodingError):
                print(encodingError)
                completion(false, nil, encodingError)
                
                self?.uploader = nil
            }
        }
        
        return { [weak self] in
            self?.uploader?.cancel()
            self?.uploader = nil
        }
    }
    
    deinit {
        uploader?.cancel()
        uploader = nil
    }
}
