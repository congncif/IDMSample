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

    @IBOutlet weak var viewBridge: AnyObject? {
        didSet {
            if let view = viewBridge as? MainViewProtocol {
                presenter.register(view: view)
            }
        }
    }
}

protocol MainControllerBridgeProtocol: MainControllerProtocol {
    var bridge: MainDependencyBridge! { get }
}

extension MainControllerBridgeProtocol {
    var presenter: MainPresenterProtocol! { return bridge.presenter }
}
