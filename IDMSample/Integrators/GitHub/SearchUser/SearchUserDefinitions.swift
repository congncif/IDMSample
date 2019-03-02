//
//  SearchUserDefinitions.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMCore

public struct SearchUserParameter {
    var q: String?
    
    public init(q: String?) {
        self.q = q
    }
}

public struct SearchUserResponseModel {
    public var incompleteResults: Bool? = false
    public var totalCount: Int?
    public var items: [SearchUser]?
}

public struct SearchUser {
    public var organizationsUrl: String?
    public var score: Float?
    public var reposUrl: String?
    public var htmlUrl: String?
    public var siteAdmin: Bool? = false
    public var gravatarId: String?
    public var starredUrl: String?
    public var avatarUrl: String?
    public var type: String?
    public var gistsUrl: String?
    public var login: String?
    public var followersUrl: String?
    public var id: Int?
    public var subscriptionsUrl: String?
    public var followingUrl: String?
    public var receivedEventsUrl: String?
    public var nodeId: String?
    public var url: String?
    public var eventsUrl: String?
}

public typealias SearchUserAbstractIntegrator = AbstractIntegrator<SearchUserParameter, SearchUserResponseModel>
