//
//  MainExtensions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

/*Always put every application logic in extensions of protocols*/

extension MainViewActionDelegate where Self: MainControllerProtocol {
    func viewReady() {
        // <#code here#>
    }
    
    func searchQueryDidChange(_ query: String) {
        presenter.setQuery(query)
    }
}
