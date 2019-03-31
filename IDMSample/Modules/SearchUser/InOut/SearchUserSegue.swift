//
//  SearchUserSegue.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

final class SearchUserSegue: UIStoryboardSegue, SearchUserRouterProtocol {
//	private struct <#TargetModuleOutputAdapter#>: <#TargetModuleOutputProtocol#> {
//      weak var output: SearchUserModuleInterface?
//  }
}

extension SearchUserSegue {
//	var target: <#TargetModuleInterface#>? {
//		return destination as? <#TargetModuleInterface#>
//  }

    var current: SearchUserModuleInterface? {
        return source as? SearchUserModuleInterface
    }

    override var identifier: String? {
        return self.typeName
    }
}
