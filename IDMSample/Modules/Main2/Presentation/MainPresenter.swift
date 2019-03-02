//
//  MainPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMFoundation

class MainPresenter: MainPresenterProtocol {
    let state: MainViewState

    public init(state: MainViewState = MainViewState()) {
        self.state = state
    }
}
