//
//  MainInternalActions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation

// MARK: - Actions

extension MainViewActionDelegate where Self: MainControllerProtocol {
    func viewReady() {
        // <#code here#>
    }
    
    func searchQueryDidChange(_ query: String) {
        presenter.setQuery(query)
    }
}
