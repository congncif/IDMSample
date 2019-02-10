//
//  Router.swift
//  IDMFoundation
//
//  Created by FOLY on 11/8/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

open class Router: RouterProtocol, Closable {
    public weak var sourceModule: ModuleInterface?
    public private(set) var openTransition: TransitionProtocol?

    public init() {}

    open func open(_ desinationModule: ModuleInterface, transition: TransitionProtocol) {
        transition.sourceViewController = self.sourceModule?.viewController
        self.openTransition = transition
        transition.open(desinationModule.viewController)
    }

    open func close(transition: TransitionProtocol? = nil) {
        let closeTransition = transition ?? openTransition
        guard let activeTransition = closeTransition else {
            print("Router: No transition")
            return
        }
        guard let viewController = self.sourceModule?.viewController else {
            print("Router: No thing to close")
            return
        }
        activeTransition.close(viewController)
    }
}
