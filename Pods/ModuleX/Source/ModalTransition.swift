//
//  ModalTransition.swift
//  IDMFoundation
//
//  Created by FOLY on 11/8/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

open class ModalTransition: NSObject {
    public var animator: AnimatorProtocol?
    public var isAnimated: Bool = true

    public var modalTransitionStyle: UIModalTransitionStyle
    public var modalPresentationStyle: UIModalPresentationStyle

    public var completionHandler: (() -> Void)?

    public weak var sourceViewController: UIViewController?

    public init(animator: AnimatorProtocol? = nil,
                isAnimated: Bool = true,
                modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

// MARK: - Transition

extension ModalTransition: TransitionProtocol {
    @objc open func open(_ desinationViewController: UIViewController) {
        desinationViewController.transitioningDelegate = self
        desinationViewController.modalTransitionStyle = modalTransitionStyle
        desinationViewController.modalPresentationStyle = modalPresentationStyle

        self.sourceViewController?.present(desinationViewController, animated: self.isAnimated, completion: self.completionHandler)
    }

    @objc open func close(_ sourceViewController: UIViewController) {
        sourceViewController.dismiss(animated: self.isAnimated, completion: self.completionHandler)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ModalTransition: UIViewControllerTransitioningDelegate {
    @objc open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }

    @objc open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
