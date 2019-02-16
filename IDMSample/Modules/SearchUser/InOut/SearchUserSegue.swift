//
//  SearchUserSegue.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SearchUserSegue: UIStoryboardSegue, SearchUserRouterProtocol {}

extension SearchUserSegue {
    override var identifier: String? {
        return typeName
    }
}
