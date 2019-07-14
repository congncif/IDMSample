//
//  NetworkExtensions.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/5/19.
//

import Foundation
import IDMCore
import SiFUtilities

extension URLBuildable {
    public func build(from endpoint: EndpointProtocol) throws -> URL {
        return try endpoint.path().toURL()
    }
}

extension RouteRequestBuildable {
    public func url(_ parameters: RequestParameterType?) throws -> URL {
        if let param = parameters as? URLBuildable {
            return try param.build(from: route.endpoint)
        }
        return try route.endpoint.path().toURL()
    }
}

extension DataProviderProtocol where Self: FlexibleRequestable, ParameterType == Self.RequestParameterType, DataType == Any {
    public func request(parameters: ParameterType?,
                        completionResult: @escaping (SimpleResult<Any?>) -> Void) -> CancelHandler? {
        return performRequest(with: parameters, completion: completionResult)
    }

    public func performRequest(with parameters: ParameterType?,
                               completion: @escaping (SimpleResult<Any?>) -> Void) -> CancelHandler? {
        var cancelHandler: CancelHandler?
        do {
            let dataRequest = try buildFinalRequest(with: parameters)
            processRequest(dataRequest, completion: completion)
            cancelHandler = { self.cancelRequest(dataRequest) }
        } catch let exception {
            completion(.failure(exception))
        }
        return cancelHandler
    }
}
