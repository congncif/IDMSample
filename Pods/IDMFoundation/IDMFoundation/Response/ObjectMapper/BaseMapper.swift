//
//  BaseMapper.swift
//  
//
//  Created by NGUYEN CHI CONG on 11/24/16.
//  Copyright © 2016 [iF] Solution. All rights reserved.
//

import Foundation
import ObjectMapper

public struct MappableError: LocalizedError {
    public static let modelCannotInitialize = MappableError(message: NSLocalizedString("Model cannot initialize", comment: ""))
    
    public var message: String
    public var failureReason: String?
    
    public init(message: String, reason: String? = nil) {
        self.message = message
        self.failureReason = reason
    }
    
    public var errorDescription: String? {
        return message
    }
}

extension BaseMappable {
    public init(fromData data: Any?) throws {
        guard let data = data else {
            throw MappableError.modelCannotInitialize
        }
        if let JSONString = data as? String {
            if let obj: Self = Mapper(context: nil).map(JSONString: JSONString) {
                self = obj
            } else {
                throw MappableError.modelCannotInitialize
            }
        } else if let JSON = data as? [String: Any] {
            if let obj: Self = Mapper(context: nil).map(JSON: JSON) {
                self = obj
            } else {
                throw MappableError.modelCannotInitialize
            }
        } else {
            throw MappableError.modelCannotInitialize
        }
    }
}
