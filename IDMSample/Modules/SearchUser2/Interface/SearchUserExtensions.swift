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
    var state: SearchUserViewState { return presenter.state }
    
    func performSearch() {
        let param = SearchUserParameter(q: state.query.unwrapped())
        integrator.prepareCall(parameters: param)
            .setLoadingMonitor(presenter.dataLoadingMonitor)
            .dataProcessor(presenter.dataProcessor)
            .call()
    }
}

extension SearchUserViewActionDelegate where Self: SearchUserControllerProtocol {
    func viewReady() {
        // <#code here#>
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
