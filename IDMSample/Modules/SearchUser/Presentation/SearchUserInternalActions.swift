//
//  SearchUserInternalActions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation

// MARK: - Actions

extension SearchUserViewActionDelegate where Self: SearchUserControllerProtocol {
    func refresh() {
        performSearch()
    }
    
    func viewReady() {
        performSearch()
    }
}
