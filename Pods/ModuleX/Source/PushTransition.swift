//
//  PushTransition.swift
//  IDMFoundation
//
//  Created by FOLY on 11/8/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

open class PushTransition: NSObject {
    public var animator: AnimatorProtocol?
    public var isAnimated: Bool = true
    public var completionHandler: (() -> Void)?

    public weak var sourceViewController: UIViewController?

    public init(animator: AnimatorProtocol? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition

extension PushTransition: TransitionProtocol {
    @objc open func open(_ desinationViewController: UIViewController) {
        self.sourceViewController?.navigationController?.delegate = self
        self.sourceViewController?.navigationController?.pushViewController(desinationViewController, animated: self.isAnimated)
    }

    @objc open func close(_ sourceViewController: UIViewController) {
        sourceViewController.navigationController?.popViewController(animated: self.isAnimated)
    }
}

// MARK: - UINavigationControllerDelegate

extension PushTransition: UINavigationControllerDelegate {
    @objc open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.completionHandler?()
    }

    @objc open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        }
        else {
            animator.isPresenting = false
            return animator
        }
    }
}
