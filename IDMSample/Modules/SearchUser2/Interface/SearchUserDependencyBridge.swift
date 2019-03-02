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

    @IBOutlet weak var viewBridge: AnyObject? {
        didSet {
            if let subscriber = viewBridge as? ViewStateSubscriber {
                presenter.state.register(subscriber: subscriber)
            }
        }
    }
}

protocol SearchUserControllerBridgeProtocol: SearchUserControllerProtocol {
    var bridge: SearchUserDependencyBridge! { get }
}

extension SearchUserControllerBridgeProtocol {
    var presenter: SearchUserPresenterProtocol! { return bridge.presenter }
    var integrator: SearchUserAbstractIntegrator! { return bridge.integrator }
}