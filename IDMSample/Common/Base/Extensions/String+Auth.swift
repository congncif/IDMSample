//
//  String+Auth.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/17/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation

extension String {
    var bearer: String {
        if self.hasPrefix("Bearer") {
            return self
        }
        return "Bearer " + self
    }
}
