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

public typealias DataRequestAdapter = NetworkRequestAdapter<DataRequest>

extension NetworkResponseHandler where BaseRequest == DataRequest {
    public static let `default` = NetworkResponseHandler<DataRequest>(handler: { request, completion in
        request.responseJSON { response in
            let isSuccess = response.result.isSuccess
            if isSuccess {
                log(url: response.response?.url, mark: "🌸", data: response.value)
            } else {
                log(url: response.response?.url, mark: "🥀", data: response.error)
            }
            completion(isSuccess, response.value, response.error)
        }
    })
}

open class BaseDataProvider<Parameter>: NetworkDataProvider<DataRequest, Parameter>, AlamofireDataRequestProtocol where Parameter: ParameterProtocol {
    public override init(route: NetworkRequestRoutable,
                         parameterEncoder: ParameterEncoding = URLEncoding.default,
                         urlRequestAdapters: [URLRequestAdapting] = [],
                         requestAdapter: RequestApdapterType? = nil,
                         responseHandler: ResponseHandlerType = NetworkResponseHandler<DataRequest>.default,
                         sessionManager: SessionManager = .background) {
        super.init(route: route, parameterEncoder: parameterEncoder, urlRequestAdapters: urlRequestAdapters, requestAdapter: requestAdapter, responseHandler: responseHandler, sessionManager: sessionManager)
    }

    open override func buildRequest(with parameters: Parameter?) throws -> DataRequest {
        var newRequest = try buildEncodedRequest(with: parameters)
        let dataRequest = sessionManager.request(newRequest)
        log(url: newRequest.url, mark: "📦", data: parameters?.payload)
        return dataRequest
    }

    open override func cancelRequest(_ request: DataRequest) {
        request.cancel()
    }
}
