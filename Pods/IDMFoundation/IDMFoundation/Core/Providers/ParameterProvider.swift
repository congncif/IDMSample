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

open class ForwardProvider<P>: ConvertProvider<P, P> {
    open override func convert(parameter: P?) throws -> P? {
        return parameter
    }
}

open class BridgeResponseProvider<R: ModelProtocol>: ConvertProvider<Any, R> where R.DataType == Any {
    open override func convert(parameter: Any?) throws -> R? {
        do {
            let data: R? = try R(fromData: parameter)
            return data
        } catch let ex {
            throw ex
        }
    }
}
