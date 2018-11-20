//
//  ApiEndpoint.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import SiFUtilities

public protocol ApiEndpointProtocol: EndpointProtocol {}

extension ApiEndpointProtocol {
    public static var base: String {
        return "https://api.github.com"
    }
}

public enum ApiEndpoint: String, ApiEndpointProtocol {
    public static var root: String {
        return ""
    }
    
    case searchUsers = "search/users"
}
