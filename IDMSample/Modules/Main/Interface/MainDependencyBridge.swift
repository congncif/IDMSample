//
//  MainDependencyBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

/// Use DependencyBridge to inject abstract `presenter` and `integrator`.
/// They are Swift types so cannot declare as Objective C types.
/// Use this if you want to use UIStoryboard as Builder. Then connect Bridge to ViewController via Storyboard.
/// In MainViewController, replace MainControllerProtocol by MainControllerBridgeProtocol.

class MainDependencyBridge: NSObject {
    var router: MainRouterProtocol?
    var presenter: MainPresenterProtocol!
}

protocol MainControllerBridgeProtocol: MainControllerProtocol {
    var bridge: MainDependencyBridge! { get }
}

extension MainControllerBridgeProtocol {
    var presenter: MainPresenterProtocol! {
        return bridge.presenter
    }
    
    var router: MainRouterProtocol? { return bridge.router }
}
