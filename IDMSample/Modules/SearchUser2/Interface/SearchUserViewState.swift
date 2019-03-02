//
//  SearchUserViewState.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import ViewStateCore

// Properties of ViewState should be protected from outside.

class SearchUserViewState: ViewState {
    @objc fileprivate(set) dynamic var query: String?
    @objc fileprivate(set) dynamic var users: [SearchUserModel] = []
}

extension SearchUserPresenterProtocol {
    func start(with query: String) {
        state.query = query
    }
    
    func setUsers(_ users: [SearchUserModel]) {
        state.users = users
    }
}
