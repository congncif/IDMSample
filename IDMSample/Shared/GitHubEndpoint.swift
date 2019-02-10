//
//  GitHubEndpoint.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SiFUtilities

protocol GitHubEndpointProtocol: EndpointProtocol {}

extension GitHubEndpointProtocol {
    public static var base: String { return "https://api.github.com" }
}

public enum GitHubEndpoint: String, GitHubEndpointProtocol {
    public static var root: String { return "" }
    
    case searchUsers = "search/users"
}
