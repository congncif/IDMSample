//
//  MainSegue.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class MainSegue: UIStoryboardSegue, MainOutputProtocol {
    func openSearchModule(with query: String) {
        target?.start(with: query)
    }
    
	var target: SearchUserInputProtocol? {
		return destination as? SearchUserInputProtocol
    }

    override var identifier: String? {
        return self.typeName
    }
}
