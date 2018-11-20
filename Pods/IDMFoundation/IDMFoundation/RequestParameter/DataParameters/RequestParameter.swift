//
//  NoParameter.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 1/23/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import Foundation
import SiFUtilities

open class RequestParameter: NSObject, ParameterProtocol {
    public override init() {
        super.init()
    }
    
    open var mapKeys: [String : String] {
        return RequestParameterConfiguration.shared.mapKeys
    }
    
    open var ignoreKeys: [String] {
        return RequestParameterConfiguration.shared.ignoreKeys
    }
}
