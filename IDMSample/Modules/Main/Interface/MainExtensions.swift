//
//  MainExtensions.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 2/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

// Extensions

extension MainControllerProtocol {
    var state: MainViewState {
        return presenter.state
    }
}
