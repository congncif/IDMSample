//
//  SearchUsersIntegrator+Builder.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation

extension SearchUsersIntegrator {
	convenience init() {
        self.init(dataProvider: SearchUsersDataProvider())
    }
}
