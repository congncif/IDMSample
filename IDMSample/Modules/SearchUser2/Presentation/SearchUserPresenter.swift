//
//  SearchUserPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMFoundation

class SearchUserPresenter: SearchUserPresenterProtocol {
    weak var dataLoadingMonitor: LoadingMonitorProtocol?

    let state: SearchUserViewState

    public init(state: SearchUserViewState = SearchUserViewState()) {
        self.state = state
    }
}
