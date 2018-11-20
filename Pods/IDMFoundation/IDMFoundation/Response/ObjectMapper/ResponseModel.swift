//
//  APIResponse.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 1/23/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

open class ResponseModel: NSObject, ResponseModelProtocol, Mappable {
    open var status: Int?
    open var message: String?
    
    public override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        message <- map[messageKey]
        status <- map[statusKey]
    }
    
    open var messageKey: String {
        return ResponseModelConfiguration.shared.messageKey
    }
    
    open var statusKey: String {
        return ResponseModelConfiguration.shared.statusKey
    }
    
    open var invalidDataError: Error? {
        return ResponseModelConfiguration.shared.validator?(self)
    }
}
