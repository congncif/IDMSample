//
//  ParametersProvider.swift
//
//
//  Created by NGUYEN CHI CONG on 8/18/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import SiFUtilities

public typealias BridgeResponseProvider<R: ModelProtocol> = BridgeDataProvider<Any, R> where R.DataType == Any
