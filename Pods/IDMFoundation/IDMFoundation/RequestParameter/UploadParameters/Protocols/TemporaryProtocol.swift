//
//  TemporaryProtocol.swift
//  
//
//  Created by NGUYEN CHI CONG on 4/7/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import Foundation

public protocol TemporaryProtocol {
    func saveTemporary(name: String?) throws -> URL
}



