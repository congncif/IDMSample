//
//  MainViewState.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
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

extension MainPresenterProtocol {
    func selectUser(_ user: SearchUserModel) {
        state.selectionState.selectedUser = user
    }
    
    func setQuery(_ query: String?) {
        state.queryState.query = query
    }
}
