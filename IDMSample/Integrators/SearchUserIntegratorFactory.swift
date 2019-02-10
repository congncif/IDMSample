//
//  SearchUserIntegratorFactory.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Alamofire
import Foundation
import IDMFoundation

public class SearchUserIntegratorFactory {
    public static func getIntegrator() -> SearchUserAbstractIntegrator {
        return SearchUserIntegrator(dataProvider: SearchUserDataProvider(route: GitHubRoute.Search.user))
    }
}
