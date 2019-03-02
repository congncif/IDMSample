//
//  SearchUserBridge.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMFoundation

class SearchUserBridge: SearchUserDependencyBridge {
    @IBOutlet weak var dataLoadingMonitorBridge: AnyObject? {
        didSet {
            presenter.dataLoadingMonitor = dataLoadingMonitorBridge as? LoadingMonitorProtocol
        }
    }

    override init() {
        super.init()
        presenter = SearchUserPresenter()
        integrator = SearchUserIntegratorFactory.getIntegrator()
    }
}
