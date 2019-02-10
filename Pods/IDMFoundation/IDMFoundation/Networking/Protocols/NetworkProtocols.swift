//
//  Protocols.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/30/19.
//

import Foundation
import SiFUtilities

public protocol RequestAdapting {
    associatedtype RequestType

    func adapt(request: RequestType) throws -> RequestType
}

public protocol Requestable {
    associatedtype ParameterType
    associatedtype RequestType

    func buildRequest(with parameters: ParameterType?) throws -> RequestType
}

// #1

public protocol RequestBuildable: Requestable {
    func url(_ parameters: ParameterType?) throws -> URL
    func method(_ parameters: ParameterType?) -> String
    func headers(_ parameters: ParameterType?) -> [String: String]?
}

extension RequestBuildable {
    public func buildURLRequest(with parameters: ParameterType?) throws -> URLRequest {
        let requestUrl = try url(parameters)
        var newRequest = URLRequest(url: requestUrl)
        newRequest.httpMethod = method(parameters)
        if let headerFields = headers(parameters) {
            for (headerField, headerValue) in headerFields {
                newRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        return newRequest
    }
}

public protocol RouteRequestBuildable: RequestBuildable {
    var route: NetworkRequestRoutable { get }
}

extension RouteRequestBuildable {
    public func method(_ parameters: ParameterType?) -> String {
        return route.method
    }

    public func headers(_ parameters: ParameterType?) -> [String: String]? {
        return route.headers
    }

    public func url(_ parameters: ParameterType?) throws -> URL {
        return try route.endpoint.path().toURL()
    }
}

// #2

public protocol FlexibleRequestable: Requestable {
    associatedtype RequestApdapterType: RequestAdapting where RequestApdapterType.RequestType == RequestType

    func requestAdapter(_ parameters: ParameterType?) -> RequestApdapterType?
}

extension FlexibleRequestable {
    public func buildAdaptiveRequest(with parameters: ParameterType?) throws -> RequestType {
        var newRequest = try buildRequest(with: parameters)

        if let adapter = requestAdapter(parameters) {
            newRequest = try adapter.adapt(request: newRequest)
        }

        return newRequest
    }
}

public protocol SimpleFlexibleRequestable: FlexibleRequestable {
    var requestAdapter: RequestApdapterType? { get }
}

extension SimpleFlexibleRequestable {
    public func requestAdapter(_ parameters: ParameterType?) -> RequestApdapterType? {
        return requestAdapter
    }
}
