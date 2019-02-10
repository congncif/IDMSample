//
//  TransitionProtocol.swift
//  IDMFoundation
//
//  Created by FOLY on 11/8/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

public protocol TransitionProtocol: class {
    var sourceViewController: UIViewController? { get set }
    
    func open(_ desinationViewController: UIViewController)
    func close(_ sourceViewController: UIViewController)
}
