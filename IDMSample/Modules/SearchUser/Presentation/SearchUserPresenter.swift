//
//  SearchUserPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ViewStateCore

// Properties of ViewState should be protected from outside.

class SearchUserViewState: ViewState {
    @objc fileprivate(set) dynamic var query: String?
    @objc fileprivate(set) dynamic var users: [SearchUserModel] = []
}

class SearchUserPresenter: SearchUserPresenterProtocol {
    var loadingHandler: LoadingProtocol!

    fileprivate let state: SearchUserViewState
    fileprivate var errorHandlingProxy: ErrorHandlingProxy

    init(state: SearchUserViewState = SearchUserViewState()) {
        self.state = state
        errorHandlingProxy = ErrorHandlingProxy()
    }
    
    var errorHandler: ErrorHandlingProtocol {
        return errorHandlingProxy
    }
    
    func register(errorHandler: ErrorHandlingProtocol,
                  where condition: ((Error?) -> Bool)? = nil) {
        errorHandlingProxy.addHandler(errorHandler, where: condition)
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
