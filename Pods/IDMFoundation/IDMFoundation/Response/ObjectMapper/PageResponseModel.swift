//
//  PageDataResponse.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 7/31/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

open class PageResponseModel: ResponseModel {
    open var page: Int = 0
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        
        page <- map[pageKey]
    }
    
    open var pageKey: String {
        return ResponseModelConfiguration.shared.pageKey
    }
}

open class PageDataResponseModel<T: Mappable>: PageResponseModel {
    open var data: [T] = []
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map[dataKey]
    }
    
    open var dataKey: String {
        return ResponseModelConfiguration.shared.dataKey
    }
}
