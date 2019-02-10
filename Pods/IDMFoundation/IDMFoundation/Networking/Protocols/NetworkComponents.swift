//
//  NetworkComponents.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/30/19.
//

import Foundation
import SiFUtilities

public protocol NetworkSessionManagable {
    var session: URLSession { get }
    var delegate: URLSessionDelegate? { get }
    var delegateQueue: OperationQueue? { get }
}

public protocol NetworkRequestRoutable {
    var headers: [String: String]? { get }
    var method: String { get }
    var endpoint: EndpointProtocol { get }
}

// Configurations

public protocol NetworkRequestConfigurable {
    var timeoutInterval: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

public struct NetworkRequestDefaultConfiguration: NetworkRequestConfigurable {
    public var timeoutInterval: TimeInterval
    public var cachePolicy: URLRequest.CachePolicy
}

extension NetworkRequestDefaultConfiguration {
    public init() {
        self.init(timeoutInterval: 60, cachePolicy: .useProtocolCachePolicy)
    }
}
