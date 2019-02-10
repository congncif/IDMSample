//
//  Network++.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 1/31/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Alamofire
import Foundation
import IDMFoundation

extension BaseDataProvider {
    public convenience init(route: NetworkRequestRoutable) {
        let adapter = BaseRequestAdapter<DataRequest> { $0.validate() }
        self.init(route: route,
                  parameterEncoder: URLEncoding.default,
                  urlRequestAdapters: [],
                  requestAdapter: adapter,
                  sessionManager: .background)
    }
}
