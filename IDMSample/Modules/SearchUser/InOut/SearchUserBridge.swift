//
//  SearchUserBridge.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class SearchUserBridge: SearchUserDependencyBridge {
    override init() {
        super.init()
        presenter = SearchUserPresenter()
        integrator = SearchUserIntegratorFactory.getIntegrator()
    }
}
