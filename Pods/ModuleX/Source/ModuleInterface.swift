//
//  ModuleInterface.swift
//  IDMFoundation
//
//  Created by FOLY on 11/11/18.
//

import Foundation
import UIKit

public protocol ModuleInterface: class {
    var viewController: UIViewController { get }
}

extension ModuleInterface where Self: UIViewController {
    public var viewController: UIViewController {
        return self
    }
}
