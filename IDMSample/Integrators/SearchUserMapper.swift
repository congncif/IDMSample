//
//  SearchUserMapper.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper

extension SearchUserResponseModel: Mappable {
    private struct SerializationKeys {
        static let incompleteResults = "incomplete_results"
        static let totalCount = "total_count"
        static let items = "items"
    }
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        incompleteResults <- map[SerializationKeys.incompleteResults]
        totalCount <- map[SerializationKeys.totalCount]
        items <- map[SerializationKeys.items]
    }
}

extension SearchUser: Mappable {
    private struct SerializationKeys {
        static let organizationsUrl = "organizations_url"
        static let score = "score"
        static let reposUrl = "repos_url"
        static let htmlUrl = "html_url"
        static let siteAdmin = "site_admin"
        static let gravatarId = "gravatar_id"
        static let starredUrl = "starred_url"
        static let avatarUrl = "avatar_url"
        static let type = "type"
        static let gistsUrl = "gists_url"
        static let login = "login"
        static let followersUrl = "followers_url"
        static let id = "id"
        static let subscriptionsUrl = "subscriptions_url"
        static let followingUrl = "following_url"
        static let receivedEventsUrl = "received_events_url"
        static let nodeId = "node_id"
        static let url = "url"
        static let eventsUrl = "events_url"
    }
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        organizationsUrl <- map[SerializationKeys.organizationsUrl]
        score <- map[SerializationKeys.score]
        reposUrl <- map[SerializationKeys.reposUrl]
        htmlUrl <- map[SerializationKeys.htmlUrl]
        siteAdmin <- map[SerializationKeys.siteAdmin]
        gravatarId <- map[SerializationKeys.gravatarId]
        starredUrl <- map[SerializationKeys.starredUrl]
        avatarUrl <- map[SerializationKeys.avatarUrl]
        type <- map[SerializationKeys.type]
        gistsUrl <- map[SerializationKeys.gistsUrl]
        login <- map[SerializationKeys.login]
        followersUrl <- map[SerializationKeys.followersUrl]
        id <- map[SerializationKeys.id]
        subscriptionsUrl <- map[SerializationKeys.subscriptionsUrl]
        followingUrl <- map[SerializationKeys.followingUrl]
        receivedEventsUrl <- map[SerializationKeys.receivedEventsUrl]
        nodeId <- map[SerializationKeys.nodeId]
        url <- map[SerializationKeys.url]
        eventsUrl <- map[SerializationKeys.eventsUrl]
    }
}
