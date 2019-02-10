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
    public typealias RequestApdapterType = BaseRequestAdapter<Request>
    public typealias RequestType = Request
    
    public var route: NetworkRequestRoutable
    public var parameterEncoder: ParameterEncoding
    public var urlRequestAdapters: [URLRequestAdapting]
    public var requestAdapter: RequestApdapterType?
    public var sessionManager: SessionManager
    
    public init(route: NetworkRequestRoutable,
                parameterEncoder: ParameterEncoding = URLEncoding.default,
                urlRequestAdapters: [URLRequestAdapting] = [],
                requestAdapter: RequestApdapterType? = nil,
                sessionManager: SessionManager = .background) {
        self.route = route
        self.parameterEncoder = parameterEncoder
        self.urlRequestAdapters = urlRequestAdapters
        self.requestAdapter = requestAdapter
        self.sessionManager = sessionManager
    }
    
    open override func request(parameters: Parameter?,
                               completion: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        var cancelHandler: CancelHandler?
        do {
            let dataRequest = try buildAdaptiveRequest(with: parameters)
            processRequest(dataRequest, completion: completion)
            cancelHandler = { [weak self] in self?.cancelRequest(dataRequest) }
        } catch let exception {
            completion(false, nil, exception)
        }
        return cancelHandler
    }
    
    // Abstract methods, must override in subclass
    open func buildRequest(with parameters: Parameter?) throws -> Request {
        fatalError("Abstract methods, must override in subclass")
    }
    
    open func cancelRequest(_ request: Request) {
        fatalError("Abstract methods, must override in subclass")
    }
    
    open func processRequest(_ request: Request, completion: @escaping (Bool, Any?, Error?) -> Void) {
        fatalError("Abstract methods, must override in subclass")
    }
}
