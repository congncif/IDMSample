//
//  MainSegue.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class MainSegue: UIStoryboardSegue, MainRouterProtocol {
    private struct SearchUserOutputProxy: SearchUserOutputProtocol {
        weak var output: MainModuleInterface?
        
        func userDidSelect(_ user: SearchUserModel) {
            output?.selectUser(user)
        }
    }
    
    func openSearchModule(with query: String) {
        target?.start(with: query)
        target?.output = SearchUserOutputProxy(output: current)
    }
}

extension MainSegue {
    var target: SearchUserModuleInterface? {
        return destination as? SearchUserModuleInterface
    }
    
    var current: MainModuleInterface? {
        return source as? MainModuleInterface
    }
    
    override var identifier: String? {
        return typeName
    }
}
