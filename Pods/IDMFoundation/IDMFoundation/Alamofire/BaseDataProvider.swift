//
//  BaseDataProvider.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 1/23/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//
import Alamofire
import IDMCore
import SiFUtilities
import UIKit

public typealias DataRequestAdapter = BaseRequestAdapter<DataRequest>

open class BaseDataProvider<Parameter>: NetworkDataProvider<DataRequest, Parameter>, SimpleAlamofireRequestBuildable where Parameter: ParameterProtocol {
    open override func buildRequest(with parameters: Parameter?) throws -> DataRequest {
        var newRequest = try buildEncodedRequest(with: parameters)
        
        let dataRequest = sessionManager.request(newRequest)
        
        log(url: newRequest.url, mark: "📦", data: parameters?.payload)
        
        return dataRequest
    }
    
    open override func cancelRequest(_ request: DataRequest) {
        request.cancel()
    }
    
    open override func processRequest(_ request: DataRequest, completion: @escaping (Bool, Any?, Error?) -> Void) {
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
