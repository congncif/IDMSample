//
//  ParametersProvider.swift
//
//
//  Created by NGUYEN CHI CONG on 8/18/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import SiFUtilities

public typealias BridgeResponseProvider<R: ModelProtocol> = BridgeDataProvider<Any, R> where R.DataType == Any

// -------------------------------------------------------------------------

@available(*, deprecated, message: "Use ConvertDataProvider class instead")
open class ConvertProvider<P1, P2>: NSObject, DataProviderProtocol {
    open func request(parameters: P1?,
                      completion: @escaping (Bool, P2?, Error?) -> Void) -> CancelHandler? {
        do {
            let outParameter = try convert(parameter: parameters)
            completion(true, outParameter, nil)
        } catch let ex {
            completion(false, nil, ex)
        }
        return nil
    }

    open func convert(parameter: P1?) throws -> P2? {
        throw CommonError(title: "IDM Provider Error",
                          message: "The convertion function \(#function) is not implemented")
    }
}

@available(*, deprecated, message: "Use ForwardDataProvider class instead")
open class ForwardProvider<P>: ConvertProvider<P, P> {
    open override func convert(parameter: P?) throws -> P? {
        return parameter
    }
}

// -------------------------------------------------------------------------

@available(*, deprecated, message: "Use AnyResultDataProvider class instead")
public typealias RootAnyProvider = AnyResultDataProvider
