//
//  SearchUserPresenter.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ViewStateCore
import SiFUtilities

public class SearchUserPresenter {
    public private(set) var state: SearchUserViewState

    fileprivate let searchService = SearchUsersIntegrator()

    public init() {
        let newState = SearchUserViewState()
        state = newState
    }

    public func search<Loader: LoaderProtocol>(loader: Loader, text: String) {
        let param = SearchUsersRequestParameter(q: text)
        searchService.prepareCall(parameters: param)
            .loading(monitor: loader)
            .onSuccess { [unowned self] model in
                let result = model?.items ?? []
                self.state.users = result.map({ (item) -> SearchUserModel in
                    let newUser = SearchUserModel()
                    newUser.id = item.id?.stringValue
                    newUser.name = item.login
                    newUser.avatar = item.avatarUrl
                    newUser.profileUrl = item.htmlUrl
                    return newUser
                })
            }
            .call()
    }
}
