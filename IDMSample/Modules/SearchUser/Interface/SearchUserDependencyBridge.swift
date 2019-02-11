//
//  SearchUserDependencyBridge.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

/// Use DependencyBridge to inject abstract `presenter` and `integrator`. They are Swift types so cannot declare as Objective C types.
/// Use this if you want to use UIStoryboard as Builder. Then connect Bridge to ViewController via Storyboard.
/// In SearchUserViewController, replace SearchUserControllerProtocol by SearchUserControllerBridgeProtocol.

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
