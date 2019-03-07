//
//  MainPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMFoundation
import ViewStateCore

// Properties of ViewState should be protected from outside.

class MainViewState: ViewState {
    class QueryState: ViewState {
        @objc fileprivate(set) dynamic var query: String?
    }

    class SelectionState: ViewState {
        @objc fileprivate(set) dynamic var selectedUser: SearchUserModel?
    }

    @objc fileprivate(set) dynamic var queryState = QueryState()
    @objc fileprivate(set) dynamic var selectionState = SelectionState()
}

class MainPresenter: MainPresenterProtocol {
    fileprivate let state: MainViewState

    init(state: MainViewState = MainViewState()) {
        self.state = state
    }

    func register(view: MainViewProtocol) {
        state.register(subscriber: view)
    }

    func currentQuery() -> String {
        return state.queryState.query.unwrapped()
    }
}

extension MainPresenter {
    func selectUser(_ user: SearchUserModel) {
        state.selectionState.selectedUser = user
    }

    func setQuery(_ query: String?) {
        state.queryState.query = query
    }
}
