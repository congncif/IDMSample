//
//  File.swift
//  IDMFoundation
//
//  Created by FOLY on 3/14/18.
//

import Foundation
import SiFUtilities

public class RequestParameterConfiguration {
    public static let shared = RequestParameterConfiguration()

    private init() {
    }

    public var baseParameter: [String: Any] = [:] // parameter will be extended from baseParameter
    public var ignoreKeys: [String] = []
    public var mapKeys: [String: String] = [:]
    public var page: Int = 0
    public var pageSize: Int = 24
}

extension ParameterProtocol {
    public var parameters: [String: Any] {
        var query = RequestParameterConfiguration.shared.baseParameter
        for (key, value) in dictionary {
            query[key] = value
        }
        return query
    }
}
