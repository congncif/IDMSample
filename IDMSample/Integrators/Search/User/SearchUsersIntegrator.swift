//
//  SearchUsersIntegrator.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

public class SearchUsersRequestParameter: RequestParameter {
    var q: String?

    public init(q: String?) {
        self.q = q
    }
}

public class SearchUsersResponseModel: SearchUsersResponse, ModelProtocol {
}

public typealias SearchUsersBaseProvider = RootAnyProvider<SearchUsersRequestParameter>

public class SearchUsersIntegrator: MagicalIntegrator<SearchUsersBaseProvider, SearchUsersResponseModel> {
}
