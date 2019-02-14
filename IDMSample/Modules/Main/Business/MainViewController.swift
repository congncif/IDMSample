//
//  MainViewController.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ModuleX
import UIKit
import ViewStateCore

public class MainViewController: UIViewController, MainControllerBridgeProtocol, MainModuleInterface {
    @IBOutlet var bridge: MainDependencyBridge!

    private var mainView: MainView { return view as! MainView }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Keep this at end of viewDidLoad
        mainView.subscribeStateChange(state)
    }

    public func selectUser(_ user: SearchUserModel) {
        presenter.selectUser(user)
    }
}

// Routing & Actions
extension MainViewController {
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segue = segue as? MainOutputProtocol {
            segue.openSearchModule(with: state.currentQuery)
        }
    }

    @IBAction private func unwindToMain(segue: UIStoryboardSegue) {}

    @IBAction private func textFieldDidChange(_ textField: UITextField) {
        presenter.setQuery(textField.text)
    }
}
