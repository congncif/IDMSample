//
//  SearchUserPresenter.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class SearchUserPresenter: NSObject, SearchUserPresenterProtocol {
    let state: SearchUserViewState

    override init() {
        state = SearchUserViewState()
        super.init()
    }
}
