//
//  MainViewController.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit
import ViewStateCore

public final class MainViewController: UIViewController, MainControllerBridgeProtocol, MainViewActionDelegate, MainModuleInterface {
    public var output: MainOutputProtocol?

    var dependencyBridge: MainDependencyBridge!

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: MainInputProtocol {
    public func selectUser(_ user: SearchUserModel) {
        presenter.selectUser(user)
    }
}

// Routing & Actions
extension MainViewController {
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segue = segue as? MainRouterProtocol {
            segue.openSearchModule(with: presenter.currentQuery())
        }
    }
    
    @IBAction private func unwindToMain(segue: UIStoryboardSegue) {}
}
