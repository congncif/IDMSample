//
//  SearchUserPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ViewStateCore

// Properties of ViewState should be protected from outside.

@objcMembers
final class SearchUserViewState: ViewState {
    fileprivate(set) dynamic var query: String?
    fileprivate(set) dynamic var users: [SearchUserModel] = []
}

final class SearchUserPresenter: SearchUserPresenterProtocol, StatefulPresenterProtocol, MultipleErrorHandlingProtocol {
    let state: SearchUserViewState
    var errorHandlingProxy: ErrorHandlingProxy

    init(state: SearchUserViewState = SearchUserViewState()) {
        self.state = state
        errorHandlingProxy = ErrorHandlingProxy()
    }

    var actionDelegate: SearchUserViewActionDelegate?
    var dataLoadingHandler: LoadingProtocol!
}

extension SearchUserPresenter {
    func currentQuery() -> String {
        return state.query.unwrapped()
    }
    
    func user(at index: Int) -> SearchUserModel {
        return state.users[index]
    }
    
    func start(with query: String) {
        state.query = query
    }
    
    func setUsers(_ users: [SearchUserModel]) {
        state.users = users
    }
}
