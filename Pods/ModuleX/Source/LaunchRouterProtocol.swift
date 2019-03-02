//
//  RootRouterProtocol.swift
//  IDMFoundation
//
//  Created by FOLY on 11/13/18.
//

import Foundation
import UIKit

public protocol LaunchRouterProtocol {
    var window: UIWindow? { get }

    func launch(_ desinationModule: ModuleInterface, animationOptions: UIView.AnimationOptions, duration: TimeInterval)
}

extension LaunchRouterProtocol {
    public func launch(_ desinationModule: ModuleInterface, animationOptions: UIView.AnimationOptions = .curveEaseInOut, duration: TimeInterval = 0.3) {
        guard let window = self.window else {
            return
        }
        let viewController = desinationModule.viewController
        window.rootViewController = viewController

        UIView.transition(with: window, duration: duration, options: animationOptions, animations: {}) { _ in }
    }
}
