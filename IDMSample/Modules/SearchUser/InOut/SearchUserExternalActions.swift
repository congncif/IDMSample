//
//  SearchUserExternalActions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation

extension SearchUserViewActionDelegate where Self: SearchUserControllerProtocol, Self: SearchUserModuleInterface {
    func listItemDidSelect(at index: Int) {
        let model = presenter.user(at: index)
        output?.userDidSelect(model)
    }
}
