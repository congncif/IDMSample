//
//  MainDependencyBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import ViewStateCore

class MainDependencyBridge: NSObject {
    var presenter: MainPresenterProtocol!
}

protocol MainControllerBridgeProtocol: MainControllerProtocol {
    var bridge: MainDependencyBridge! { get }
}

extension MainControllerBridgeProtocol {
    var presenter: MainPresenterProtocol! { return bridge.presenter }
}
