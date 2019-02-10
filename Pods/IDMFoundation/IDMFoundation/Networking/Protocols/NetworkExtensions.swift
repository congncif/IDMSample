//
//  NetworkExtensions.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/5/19.
//

import Foundation
import SiFUtilities

extension URLBuildable {
    public func build(from endpoint: EndpointProtocol) throws -> URL {
        return try endpoint.path().toURL()
    }
}

extension RouteRequestBuildable where ParameterType: URLBuildable {
    public func url(_ parameters: ParameterType?) throws -> URL {
        if let param = parameters {
            return try param.build(from: route.endpoint)
        }
        return try route.endpoint.path().toURL()
    }
}
