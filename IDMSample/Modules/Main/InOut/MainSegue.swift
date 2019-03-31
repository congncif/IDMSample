//
//  MainSegue.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

final class MainSegue: UIStoryboardSegue, MainRouterProtocol {
    private struct SearchUserOutputAdapter: SearchUserOutputProtocol {
        weak var output: MainModuleInterface?
        
        func userDidSelect(_ user: SearchUserModel) {
            output?.selectUser(user)
        }
    }
    
    func openSearchModule(with query: String) {
        target?.start(with: query)
        target?.output = SearchUserOutputAdapter(output: current)
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
        return self.typeName
    }
}
