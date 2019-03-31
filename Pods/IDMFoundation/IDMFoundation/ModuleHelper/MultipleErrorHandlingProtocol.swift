//
//  MultipleErrorHandlingProtocol.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 3/27/19.
//

import Foundation
import IDMCore

public protocol MultipleErrorHandlingProtocol {
    var errorHandlingProxy: ErrorHandlingProxy { get set }
}

extension MultipleErrorHandlingProtocol {
    public mutating func add(errorHandler: ErrorHandlingProtocol,
                           priority: ErrorHandlingProxy.HandlingPriority = .default,
                           where condition: ((Error?) -> Bool)? = nil) {
        errorHandlingProxy.addHandler(errorHandler, priority: priority, where: condition)
    }
    
    public mutating func add<ErrorType>(dedicatedErrorHandler handler: DedicatedErrorHandler<ErrorType>,
                                      priority: ErrorHandlingProxy.HandlingPriority = .default,
                                      where condition: ((ErrorType) -> Bool)? = nil) {
        errorHandlingProxy.addDedicatedHandler(handler, priority: priority, where: condition)
    }
}
