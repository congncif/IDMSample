//
//  SearchUserExtensions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

/* Always put every application logic in extensions of protocols */

// MARK: - Controller

extension SearchUserControllerProtocol {
    func performSearch() {
        let param = SearchUserParameter(q: presenter.currentQuery())
        integrator.prepareCall(parameters: param)
            .loadingHandler(presenter.dataLoadingHandler)
            .errorHandler(presenter.errorHandler)
            .dataProcessor(presenter.dataResponseHandler)
            .call()
    }
}

// MARK: - Presenter

extension SearchUserPresenterProtocol {
    var dataResponseHandler: DataProcessor<SearchUserResponseModel> {
        return DataProcessor<SearchUserResponseModel>(dataProcessing: { data in
            let originItems = data.items ?? []
            let items: [SearchUserModel] = originItems.map { item in
                let newUser = SearchUserModel()
                newUser.id = item.id?.stringValue
                newUser.name = item.login
                newUser.avatar = item.avatarUrl
                newUser.profileUrl = item.htmlUrl
                return newUser
            }
            self.setUsers(items)
        })
    }
}

extension SearchUserPresenterProtocol where Self: MultipleErrorHandlingProtocol {
    var errorHandler: ErrorHandlingProtocol {
        return errorHandlingProxy
    }
}
