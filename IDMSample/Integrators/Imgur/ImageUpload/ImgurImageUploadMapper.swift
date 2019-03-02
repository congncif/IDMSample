//
//  ImgurImageUploadMapper.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/17/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import ObjectMapper

extension ImgurImageUploadDataModel: Mappable {
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {}
}
