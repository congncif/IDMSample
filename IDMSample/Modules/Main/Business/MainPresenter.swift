//
//  MainPresenter.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class MainPresenter: NSObject, MainPresenterProtocol {
    let state: MainViewState

    override init() {
        let newState = MainViewState()
        state = newState
    }
}
