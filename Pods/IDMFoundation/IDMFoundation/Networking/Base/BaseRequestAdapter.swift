//
//  RequestAdapter.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/31/19.
//

import Foundation

public struct NetworkRequestAdapter<BaseRequest>: RequestAdapting {
    public typealias RequestType = BaseRequest

    public var handler: ((RequestType) throws -> RequestType)?

    public init(handler: ((RequestType) throws -> RequestType)? = nil) {
        self.handler = handler
    }

    public func adapt(request: RequestType) throws -> RequestType {
        var newRequest = request
        if let handler = self.handler {
            newRequest = try handler(request)
        }
        return newRequest
    }
}

public struct NetworkResponseHandler<BaseRequest>: ResponseHandling {
    public typealias RequestType = BaseRequest

    public var handler: (RequestType, @escaping AnyResultCompletionHandler) -> Void

    public init(handler: @escaping (RequestType, @escaping AnyResultCompletionHandler) -> Void) {
        self.handler = handler
    }

    public func processRequest(_ request: RequestType, completion: @escaping AnyResultCompletionHandler) {
        handler(request, completion)
    }
}
