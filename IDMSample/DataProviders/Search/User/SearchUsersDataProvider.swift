//
//  SearchUsersDataProvider.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//
import Alamofire
import Foundation
import IDMCore
import IDMFoundation
import SiFUtilities

public typealias SearchUsersProvider = BaseDataProvider<SearchUsersRequestParameter>

public class SearchUsersDataProvider: SearchUsersProvider {
    public override func requestPath(parameters: SearchUsersRequestParameter?) -> String {
        return ApiEndpoint.searchUsers.path()
    }

    public override func httpMethod(parameters: SearchUsersRequestParameter?) -> HTTPMethod {
        return .get
    }
}
