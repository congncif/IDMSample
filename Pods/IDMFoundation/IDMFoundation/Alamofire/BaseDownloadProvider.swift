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

public enum DownloadResponseSerializerType {
    case `default`
    case data
    case string
    case json
}

public protocol DownloadResponseDataStandard {
    /// The URL request sent to the server.
    var request: URLRequest? { get }
    
    /// The server's response to the URL request.
    var response: HTTPURLResponse? { get }
    
    /// The temporary destination URL of the data returned from the server.
    var temporaryURL: URL? { get }
    
    /// The final destination URL of the data returned from the server if it was moved.
    var destinationURL: URL? { get }
    
    /// The resume data generated if the request was cancelled.
    var resumeData: Data? { get }
    
    /// The error encountered while executing or validating the request.
    var error: Error? { get }
}

extension DefaultDownloadResponse: DownloadResponseDataStandard {
}

open class BaseDownloadProvider<ParameterType: DownloadParameterProtocol>: BaseDataProvider<ParameterType> {
    open override var customSessionManager: SessionManager {
        let id = "download." + String.random()
        let configuration = URLSessionConfiguration.background(withIdentifier: id)
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let session = SessionManager(configuration: configuration)
        return session
    }
    
    open var trackingProgressEnabled: Bool {
        return true
    }
    
    open override func request(parameters: ParameterType?,
                               completion: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        if let err = validate(parameters: parameters) {
            completion(false, nil, err)
            return nil
        }
        
        if let data = testResponseData(parameters: parameters) {
            completion(data.0, data.1, data.2)
            return nil
        }
        
        let path = requestPath(parameters: parameters)
        let method = httpMethod(parameters: parameters)
        let header = headers(parameters: parameters)
        let encoding = parameterEncoding(parameters: parameters)
        
        if logEnabled(parameters: parameters) {
            ProviderConfiguration.shared.logger.logRequest(title: "Download", path: requestPath(parameters: parameters), parameters: parameters?.parameters)
        }
        
        let request = sessionManager.download(path, method: method, parameters: parameters?.parameters, encoding: encoding, headers: header) { (_, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            if let desUrl = parameters?.destinationUrl(suggestedFilename: response.suggestedFilename) {
                return (desUrl, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename ?? String.random())
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        
        customRequest(request)
        
        request.downloadProgress { [weak self] progress in
            if self?.trackingProgressEnabled == true {
                completion(true, progress, nil)
            }
        }
        
        switch responseSerializerType(parameters: parameters) {
        case .string:
            request.responseString { [weak self] response in
                guard let this = self else {
                    completion(false, nil, nil)
                    return
                }
                
                let value = response.value
                let error = response.error
                
                if this.logEnabled(parameters: parameters) {
                    ProviderConfiguration.shared.logger.logDownloadResponse(response)
                    
                    print("🌷 Response: \(String(describing: value))")
                    if let err = error {
                        print("🥀 Error: " + String(describing: err))
                    }
                }
                completion(error == nil, value, error)
            }
        case .data:
            request.responseData { [weak self] response in
                guard let this = self else {
                    completion(false, nil, nil)
                    return
                }
                
                let value = response.value
                let error = response.error
                
                if this.logEnabled(parameters: parameters) {
                    ProviderConfiguration.shared.logger.logDownloadResponse(response)
                }
                completion(error == nil, value, error)
            }
        case .json:
            request.responseJSON { [weak self] response in
                guard let this = self else {
                    completion(false, nil, nil)
                    return
                }
                
                let value = response.value
                let error = response.error
                
                if this.logEnabled(parameters: parameters) {
                    ProviderConfiguration.shared.logger.logDownloadResponse(response)
                }
                completion(error == nil, value, error)
            }
        default:
            request.response { [weak self] response in
                guard let this = self else {
                    completion(false, nil, nil)
                    return
                }
                
                let error = response.error
                
                if this.logEnabled(parameters: parameters) {
                    ProviderConfiguration.shared.logger.logDownloadResponse(response)
                }
                completion(error == nil, response, error)
            }
        }
        
        return {
            request.cancel()
        }
    }
    
    open override func httpMethod(parameters: ParameterType?) -> HTTPMethod {
        return .get
    }
    
    open func responseSerializerType(parameters: ParameterType?) -> DownloadResponseSerializerType {
        return .default
    }
    
    open override func requestPath(parameters: ParameterType?) -> String {
        if let path = parameters?.downloadPath {
            return path
        }
        fatalError("Must set download path")
    }
}
