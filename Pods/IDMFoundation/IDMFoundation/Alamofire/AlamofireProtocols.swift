//
//  NetworkExtensions.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//

import Alamofire
import Foundation
import SiFUtilities

// MARK: - #1 SessionManager / Networking

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

// MARK: - #2 Routable

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

// MARK: - #3 URL Request

public protocol AlamofireRequestBuildable: SimpleURLRequestBuildable {
    func parameterEncoder(_ parameters: RequestParameterType?) -> ParameterEncoding
}

extension AlamofireRequestBuildable where RequestParameterType: ParameterProtocol {
    public func buildEncodedRequest(with parameters: RequestParameterType?) throws -> URLRequest {
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
    public func parameterEncoder(_ parameters: RequestParameterType?) -> ParameterEncoding {
        return parameterEncoder
    }
}

// MARK: - #4 Base Protocols

public protocol AlamofireDataRequestProtocol: NetworkRequestable, SimpleAlamofireRequestBuildable, AlamofireSessionManagable {}

public protocol AlamofireRequestProtocol: NetworkRequestable, SimpleURLRequestBuildable, AlamofireSessionManagable {}
