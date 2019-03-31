//
//  MainExtensions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

/* Always put every application logic in extensions of protocols */

// MARK: - Controller

extension MainControllerProtocol {}

// MARK: - Presenter

extension MainPresenterProtocol {
}

extension MainPresenterProtocol where Self: MultipleErrorHandlingProtocol {
    var errorHandler: ErrorHandlingProtocol {
        return errorHandlingProxy
    }
}
