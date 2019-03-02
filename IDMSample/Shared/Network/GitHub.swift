//
//  GitHubEndpoint.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMFoundation
import SiFUtilities

protocol GitHubEndpointProtocol: EndpointProtocol {}

extension GitHubEndpointProtocol {
    static var base: String { return "https://api.github.com" }
}

enum GitHubEndpoint: String, GitHubEndpointProtocol {
    static var root = String()

    case searchUsers = "search/users"
}

struct GitHubRoute {
    struct Search {
        static let user = NetworkRoute(endpoint: GitHubEndpoint.searchUsers, method: .get)
    }
}
