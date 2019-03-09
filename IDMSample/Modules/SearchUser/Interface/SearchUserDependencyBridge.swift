//
//  SearchUserDependencyBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import ViewStateCore

class SearchUserDependencyBridge: NSObject {
    var presenter: SearchUserPresenterProtocol!
    var integrator: SearchUserAbstractIntegrator!
}

protocol SearchUserControllerBridgeProtocol: SearchUserControllerProtocol {
    var bridge: SearchUserDependencyBridge! { get }
}

extension SearchUserControllerBridgeProtocol {
    var presenter: SearchUserPresenterProtocol! { return bridge.presenter }
    var integrator: SearchUserAbstractIntegrator! { return bridge.integrator }
}
