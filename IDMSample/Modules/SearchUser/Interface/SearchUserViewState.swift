//
//  SearchUserViewState.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 2/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import ViewStateCore

class SearchUserViewState: ViewState {
    @objc fileprivate(set) dynamic var query: String?
    @objc fileprivate(set) dynamic var users: [SearchUserModel] = []
}

extension SearchUserViewState {
    var currentQuery: String {
        return query ?? ""
    }
}

extension SearchUserPresenterProtocol {
    func start(with query: String) {
        state.query = query
    }

    func setUsers(_ users: [SearchUserModel]) {
        state.users = users
    }
}
