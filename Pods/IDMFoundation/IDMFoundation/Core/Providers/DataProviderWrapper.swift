//
//  WrappedDataProvider.swift
//  IDMFoundation
//
//  Created by FOLY on 12/27/18.
//

import Foundation
import IDMCore

open class DataProviderWrapper<ProviderType: DataProviderProtocol>: AnyResultDataProvider<ProviderType.ParameterType> where ProviderType.DataType == Any {


    public var provider: ProviderType?

    public init(provider: ProviderType?) {
        self.provider = provider
    }

    open override func request(parameters: ParameterType?, completionResult: @escaping (Result<Any?, Error>) -> Void) -> CancelHandler? {
        return provider?.request(parameters: parameters, completionResult: completionResult)
    }
}

// Use to connect a custom validator provider with an api provider
extension DataProviderProtocol where DataType == Any {
    public var wrapper: DataProviderWrapper<Self> {
        return DataProviderWrapper(provider: self)
    }
}
