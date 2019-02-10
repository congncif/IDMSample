//
//  ResponseModelProtocol+Validate.swift
//  IDMFoundation
//
//  Created by FOLY on 11/18/18.
//

import Foundation
import IDMCore

extension ModelProtocol where Self: ResponseModelProtocol {
    public var invalidDataError: Error? {
        return ResponseModelConfiguration.shared.validator?(self)
    }
}
