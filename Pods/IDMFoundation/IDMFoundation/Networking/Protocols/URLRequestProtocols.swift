//
//  URLRequestProtocols.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/30/19.
//

import Foundation

public protocol URLRequestAdapting {
    func customRequest(_ request: URLRequest) throws -> URLRequest
}

public protocol URLRequestBuildable: RequestBuildable {
    func urlRequestAdapters(_ parameters: RequestParameterType?) -> [URLRequestAdapting]
}

extension URLRequestBuildable {
    public func buildAdaptiveURLRequest(with parameters: RequestParameterType?) throws -> URLRequest {
        var newRequest = try buildURLRequest(with: parameters)

        // Adapt URLRequest with config timeout, cachePolicy, etc...
        let adapters = urlRequestAdapters(parameters)
        try adapters.forEach {
            newRequest = try $0.customRequest(newRequest)
        }

        return newRequest
    }
}

public protocol SimpleURLRequestBuildable: URLRequestBuildable {
    var urlRequestAdapters: [URLRequestAdapting] { get }
}

extension SimpleURLRequestBuildable {
    public func urlRequestAdapters(_ parameters: RequestParameterType?) -> [URLRequestAdapting] {
        return urlRequestAdapters
    }
}
