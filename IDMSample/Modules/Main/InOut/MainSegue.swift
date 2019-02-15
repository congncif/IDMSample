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
    func openSearchModule(with query: String) {
        target?.start(with: query)
        target?.output = current
    }
    
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
