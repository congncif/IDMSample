//
//  MainPresenter.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ViewStateCore

// Properties of ViewState should be protected from outside.

@objcMembers
final class MainViewState: ViewState {
    @objcMembers
    class QueryState: ViewState {
        fileprivate(set) dynamic var query: String?
    }
    @objcMembers
    class SelectionState: ViewState {
        fileprivate(set) dynamic var selectedUser: SearchUserModel?
    }
    
    fileprivate(set) dynamic var queryState = QueryState()
    fileprivate(set) dynamic var selectionState = SelectionState()
}

final class MainPresenter: MainPresenterProtocol, StatefulPresenterProtocol, MultipleErrorHandlingProtocol {
    let state: MainViewState
    var errorHandlingProxy: ErrorHandlingProxy

    init(state: MainViewState = MainViewState()) {
        self.state = state
        errorHandlingProxy = ErrorHandlingProxy()
    }

    var actionDelegate: MainViewActionDelegate?
    var dataLoadingHandler: LoadingProtocol!
}

extension MainPresenter {
    func selectUser(_ user: SearchUserModel) {
        state.selectionState.selectedUser = user
    }
    
    func setQuery(_ query: String?) {
        state.queryState.query = query
    }
    
    func currentQuery() -> String {
        return state.queryState.query.unwrapped()
    }
}
