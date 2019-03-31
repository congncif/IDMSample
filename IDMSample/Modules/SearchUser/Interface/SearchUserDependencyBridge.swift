//
//  SearchUserDependencyBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import ViewStateCore

protocol SearchUserDependencyBridge {
    var presenter: SearchUserPresenterProtocol! { get }
    var integrator: SearchUserAbstractIntegrator! { get }
}

protocol SearchUserControllerBridgeProtocol: SearchUserControllerProtocol {
    var dependencyBridge: SearchUserDependencyBridge! { get }
}

extension SearchUserControllerBridgeProtocol {
    var presenter: SearchUserPresenterProtocol! { return dependencyBridge.presenter }
    var integrator: SearchUserAbstractIntegrator! { return dependencyBridge.integrator }
}
