//
//  NetworkExtensions.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//

import Alamofire
import Foundation
import SiFUtilities

// #2

public protocol AlamofireSessionManagable: NetworkSessionManagable {
    var sessionManager: SessionManager { get }
}

extension AlamofireSessionManagable {
    public var session: URLSession {
        return sessionManager.session
    }

    public var delegate: URLSessionDelegate? {
        return sessionManager.delegate
    }

    public var delegateQueue: OperationQueue? {
        return sessionManager.session.delegateQueue
    }
}

// #3

public protocol AlamofireNetworkRequestRoutable: NetworkRequestRoutable {
    var httpMethod: HTTPMethod { get }
}

extension AlamofireNetworkRequestRoutable {
    public var method: String {
        return httpMethod.rawValue
    }
}

public struct NetworkRoute: AlamofireNetworkRequestRoutable {
    public var endpoint: EndpointProtocol
    public var httpMethod: HTTPMethod
    public var headers: [String: String]?

    public init(endpoint: EndpointProtocol, method: HTTPMethod, headers: [String: String]? = nil) {
        self.endpoint = endpoint
        httpMethod = method
        self.headers = headers
    }
}

// #4

public protocol AlamofireRequestBuildable: SimpleURLRequestBuildable {
    func parameterEncoder(_ parameters: ParameterType?) -> ParameterEncoding
}

extension AlamofireRequestBuildable where ParameterType: ParameterProtocol {
    public func buildEncodedRequest(with parameters: ParameterType?) throws -> URLRequest {
        var newRequest = try buildAdaptiveURLRequest(with: parameters)

        let encoder = parameterEncoder(parameters)
        newRequest = try encoder.encode(newRequest, with: parameters?.payload)

        return newRequest
    }
}

public protocol SimpleAlamofireRequestBuildable: AlamofireRequestBuildable {
    var parameterEncoder: ParameterEncoding { get }
}

extension SimpleAlamofireRequestBuildable {
    public func parameterEncoder(_ parameters: ParameterType?) -> ParameterEncoding {
        return parameterEncoder
    }
}

public protocol AlamofireDataRequestProtocol: RouteRequestBuildable, SimpleFlexibleRequestable,
    SimpleAlamofireRequestBuildable, AlamofireSessionManagable {}

public protocol AlamofireRequestProtocol: RouteRequestBuildable, SimpleFlexibleRequestable,
    SimpleURLRequestBuildable, AlamofireSessionManagable {}
