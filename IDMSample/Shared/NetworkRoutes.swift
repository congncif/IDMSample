//
//  NetworkRoutes.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMFoundation

struct GitHubRoute {
    struct Search {
        static let user = NetworkRoute(endpoint: GitHubEndpoint.searchUsers, method: .get)
    }
}
