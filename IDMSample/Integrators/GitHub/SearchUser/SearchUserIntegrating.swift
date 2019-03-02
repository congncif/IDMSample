//
//  SearchUserIntegrating.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

extension SearchUserParameter: ParameterProtocol {}
extension SearchUserResponseModel: ModelProtocol {}

public typealias SearchUserBaseProvider = AnyResultDataProvider<SearchUserParameter>

public class SearchUserIntegrator: MagicalIntegrator<SearchUserBaseProvider, SearchUserResponseModel> {}
