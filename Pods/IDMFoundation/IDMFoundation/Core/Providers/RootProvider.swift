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

open class RootProvider<ParameterType, DataType>: NSObject, DataProviderProtocol {
    @discardableResult
    open func request(parameters _: ParameterType?, completion _: @escaping (Bool, DataType?, Error?) -> Void) -> CancelHandler? {
        fatalError("Please override \(#function) to get data")
    }
}

open class RootAnyProvider<ParameterType>: RootProvider<ParameterType, Any> {
    @discardableResult
    open override func request(parameters _: ParameterType?, completion _: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        fatalError("Please override \(#function) to get data")
    }
}

open class BaseProviderWrapper<ProviderType: DataProviderProtocol>: RootAnyProvider<ProviderType.ParameterType> where ProviderType.DataType == Any {
    public var provider: ProviderType?
    
    public init(provider: ProviderType?) {
        self.provider = provider
    }
    
    open override func request(parameters: ProviderType.ParameterType?, completion: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        return provider?.request(parameters: parameters, completion: completion)
    }
}

extension DataProviderProtocol where DataType == Any {
    public var wrapper: BaseProviderWrapper<Self> {
        return BaseProviderWrapper(provider: self)
    }
}

/* A wrap provider enables to create a sequence integration */
open class IntegrationProvider<D: DataProviderProtocol, M: ModelProtocol, R, I: Integrator<D, M, R>>: RootProvider<D.ParameterType, R> {
    public var service: I
    public init(_ service: I) {
        self.service = service
    }
    
    open override func request(parameters: D.ParameterType?, completion: @escaping (Bool, R?, Error?) -> Void) -> CancelHandler? {
        service.prepareCall(parameters: parameters).onSuccess { result in
            completion(true, result, nil)
        }.onError { error in
            completion(false, nil, error)
        }.call()
        
        return nil
    }
}

extension Integrator {
    /// Create provider from a service to begin a sequence integration
    public var wrapProvider: IntegrationProvider<IntegrateProvider, IntegrateModel, IntegrateResult, Integrator<IntegrateProvider, IntegrateModel, IntegrateResult>> {
        return IntegrationProvider(self)
    }
}
