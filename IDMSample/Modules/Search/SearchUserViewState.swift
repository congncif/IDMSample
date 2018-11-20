//
//  SearchUserViewState.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ViewStateCore

public class SearchUserModel: NSObject {
    var id: String?
    var name: String?
    var avatar: String?
    var profileUrl: String?
}

public class SearchUserViewState: ViewState {
    @objc public internal(set) dynamic var users: [SearchUserModel] = []
}
