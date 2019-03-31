//
//  MainDependencyBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import ViewStateCore

protocol MainDependencyBridge {
    var presenter: MainPresenterProtocol! { get }
}

protocol MainControllerBridgeProtocol: MainControllerProtocol {
    var dependencyBridge: MainDependencyBridge! { get }
}

extension MainControllerBridgeProtocol {
    var presenter: MainPresenterProtocol! { return dependencyBridge.presenter }
}
