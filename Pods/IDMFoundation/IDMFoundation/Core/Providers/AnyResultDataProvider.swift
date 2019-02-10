//
//  BaseProvider.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 8/29/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//

import Foundation
import IDMCore

public typealias ProviderResponseAny = (Bool, Any?, Error?)

// An abstract class for generic declaring
open class AnyResultDataProvider<ParameterType>: AbstractDataProvider<ParameterType, Any> {
    @discardableResult
    open override func request(parameters _: ParameterType?, completion _: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        assertionFailure("Please override \(#function) to get data")
        return nil
    }
}

@available(*, deprecated, message: "Use AnyResultDataProvider class instead")
public typealias RootAnyProvider = AnyResultDataProvider
