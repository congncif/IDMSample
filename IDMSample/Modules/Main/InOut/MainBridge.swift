//
//  MainBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

class MainBridge: MainDependencyBridge {
    override init() {
    	super.init()
        presenter = MainPresenter()
    }
}
