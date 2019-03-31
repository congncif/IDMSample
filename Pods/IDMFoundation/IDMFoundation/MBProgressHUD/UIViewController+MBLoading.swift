//
//  UIViewController+Extentions.swift
//
//
//  Created by NGUYEN CHI CONG on 7/6/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//

import Foundation
import IDMCore
import MBProgressHUD
import SiFUtilities
import UIKit

extension LoadingProtocol where Self: UIView {
    public func beginLoading() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = "Loading...".localized
    }

    public func finishLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}

extension ProgressLoadingProtocol where Self: UIView {
    public func beginProgressLoading() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = "Loading...".localized
        hud.detailsLabel.text = "0% " + "Complete".localized
        hud.mode = .determinateHorizontalBar
    }

    public func finishProgressLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }

    public func loadingDidUpdateProgress(_ progress: Progress?) {
        if let value = progress?.fractionCompleted {
            let hud = MBProgressHUD(for: self)
            hud?.progress = Float(value)
            hud?.label.text = "Loading...".localized
            hud?.detailsLabel.text = (value * 100).intValue.stringValue + "% " + "Complete".localized
        }
    }
}

extension UIView: LoadingProtocol, ProgressLoadingProtocol {}

extension UIViewController: LoadingProtocol {
    @objc open func beginLoading() {
        view.beginLoading()
    }

    @objc open func finishLoading() {
        view.finishLoading()
    }
}

extension UIViewController: ProgressLoadingProtocol {
    @objc open func beginProgressLoading() {
        view.beginProgressLoading()
    }

    @objc open func finishProgressLoading() {
        view.finishProgressLoading()
    }

    @objc open func loadingDidUpdateProgress(_ progress: Progress?) {
        view.loadingDidUpdateProgress(progress)
    }
}

