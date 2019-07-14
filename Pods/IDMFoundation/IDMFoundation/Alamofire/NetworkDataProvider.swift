//
//  BaseProvider.swift
//  IDMFoundation
//
//  Created by FOLY on 7/21/18.
//

import Alamofire
import IDMCore
import SiFUtilities
import UIKit

open class NetworkDataProvider<Request, Parameter>: AnyResultDataProvider<Parameter>, AlamofireRequestProtocol {
    public typealias RequestType = Request
    public typealias RequestApdapterType = NetworkRequestAdapter<RequestType>
    public typealias ResponseHandlerType = NetworkResponseHandler<RequestType>

    public var route: NetworkRequestRoutable
    public var parameterEncoder: ParameterEncoding
    public var urlRequestAdapters: [URLRequestAdapting]
    public var requestAdapter: RequestApdapterType?
    public var sessionManager: SessionManager
    public var responseHandler: ResponseHandlerType

    init(route: NetworkRequestRoutable,
         parameterEncoder: ParameterEncoding = URLEncoding.default,
         urlRequestAdapters: [URLRequestAdapting] = [],
         requestAdapter: RequestApdapterType? = nil,
         responseHandler: ResponseHandlerType,
         sessionManager: SessionManager = .background) {
        self.route = route
        self.parameterEncoder = parameterEncoder
        self.urlRequestAdapters = urlRequestAdapters
        self.requestAdapter = requestAdapter
        self.responseHandler = responseHandler
        self.sessionManager = sessionManager
    }

    open override func request(parameters: Parameter?, completionResult: @escaping (ResultType) -> Void) -> CancelHandler? {
        return performRequest(with: parameters, completion: completionResult)
    }

    // Abstract methods, must override in subclass
    open func buildRequest(with parameters: Parameter?) throws -> Request {
        fatalError("Abstract methods, must override in subclass")
    }

    open func cancelRequest(_ request: Request) {
        fatalError("Abstract methods, must override in subclass")
    }
}
