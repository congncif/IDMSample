//
//  SearchUserExtensions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

/*Always put every application logic in extensions of protocols*/

extension SearchUserControllerProtocol {
    func performSearch() {
        let param = SearchUserParameter(q: presenter.currentQuery())
        integrator.prepareCall(parameters: param)
            .loadingHandler(presenter.loadingHandler)
            .errorHandler(presenter.errorHandler)
            .dataProcessor(presenter.dataProcessor)
            .call()
    }
}

extension SearchUserViewActionDelegate where Self: SearchUserControllerProtocol {
    func refresh() {
        performSearch()
    }
    
    func viewReady() {
        performSearch()
    }
}

extension SearchUserViewActionDelegate where Self: SearchUserControllerProtocol, Self: SearchUserModuleInterface {
    func listItemDidSelect(at index: Int) {
        let model = presenter.user(at: index)
        output?.userDidSelect(model)
    }
}

extension SearchUserPresenterProtocol {
    var dataProcessor: DataProcessor<SearchUserResponseModel> {
        return DataProcessor<SearchUserResponseModel>(dataProcessing: { data in
            let originItems = data?.items ?? []
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
