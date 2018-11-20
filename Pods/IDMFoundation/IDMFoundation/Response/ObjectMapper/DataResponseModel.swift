//
//  DataResponseModel.swift
//  IDMFoundation
//
//  Created by FOLY on 11/18/18.
//

import Foundation
import ObjectMapper

open class DataResponseModel<T: Mappable>: ResponseModel {
    open var data: T?
    
    public override init() {
        super.init()
    }
    
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
