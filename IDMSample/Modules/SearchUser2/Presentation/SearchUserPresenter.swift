//
//  SearchUserPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMFoundation
import ViewStateCore

// Properties of ViewState should be protected from outside.

class SearchUserViewState: ViewState {
    @objc fileprivate(set) dynamic var query: String?
    @objc fileprivate(set) dynamic var users: [SearchUserModel] = []
}

class SearchUserPresenter: SearchUserPresenterProtocol {
    weak var dataLoadingMonitor: LoadingMonitorProtocol?

    fileprivate let state: SearchUserViewState

    init(state: SearchUserViewState = SearchUserViewState()) {
        self.state = state
    }
    
    func register(view: SearchUserViewProtocol) {
        state.register(subscriber: view)
    }
    
    func currentQuery() -> String {
        return state.query.unwrapped()
    }
    
    func user(at index: Int) -> SearchUserModel {
        return state.users[index]
    }
}

extension SearchUserPresenter {
    func start(with query: String) {
        state.query = query
    }

    func setUsers(_ users: [SearchUserModel]) {
        state.users = users
    }
}
