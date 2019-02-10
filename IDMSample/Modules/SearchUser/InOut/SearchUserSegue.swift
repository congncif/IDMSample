//
//  SearchUserSegue.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SearchUserSegue: UIStoryboardSegue, SearchUserOutputProtocol {
    func userDidSelect(_ user: SearchUserModel) {
        target?.selectUser(user)
    }
    
    var target: MainInputProtocol? {
        return destination as? MainInputProtocol
    }
    
    override var identifier: String? {
        return typeName
    }
}
