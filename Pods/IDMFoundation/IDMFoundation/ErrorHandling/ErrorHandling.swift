//
//  ErrorHandling.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 3/24/19.
//

import Foundation
import IDMCore
import UIKit

extension ErrorHandlingProtocol where Self: UIViewController {
    public func handle(error: Error?) {
        guard let error = error else { return }
        showErrorAlert(error)
    }
}

extension UIViewController: ErrorHandlingProtocol {}

extension DedicatedErrorHandler where E: Error {
    public init(errorType: E.Type, viewController: UIViewController?) {
        self.init(errorType: errorType) { [weak viewController] error in
            viewController?.showErrorAlert(error)
        }
    }

    public init(viewController: UIViewController?) {
        self.init { [weak viewController] error in
            viewController?.showErrorAlert(error)
        }
    }
}
