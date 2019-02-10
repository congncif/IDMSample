//
//  MainViewState.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 2/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import ViewStateCore

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

extension MainViewState {
    var currentQuery: String {
        return queryState.query ?? ""
    }
}

extension MainPresenterProtocol {
    func selectUser(_ user: SearchUserModel) {
        state.selectionState.selectedUser = user
    }
    
    func setQuery(_ query: String?) {
        state.queryState.query = query
    }
}
