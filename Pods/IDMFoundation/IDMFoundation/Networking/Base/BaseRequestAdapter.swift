//
//  RequestAdapter.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/31/19.
//

import Foundation

open class BaseRequestAdapter<Request>: RequestAdapting {
    public typealias RequestType = Request

    public var handler: ((Request) throws -> Request)?

    public init(handler: ((Request) throws -> Request)? = nil) {
        self.handler = handler
    }

    open func adapt(request: Request) throws -> Request {
        var newRequest = request
        if let handler = self.handler {
            newRequest = try handler(request)
        }
        return newRequest
    }
}
