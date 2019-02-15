//
//  MainViewController.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public class MainViewController: UIViewController, MainControllerBridgeProtocol, MainModuleInterface {
    public weak var output: MainOutputProtocol?

    @IBOutlet var bridge: MainDependencyBridge!

    private var mainView: MainView { return view as! MainView }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Keep this at end of viewDidLoad
        mainView.subscribeStateChange(state)
    }
    
    public func userDidSelect(_ user: SearchUserModel) {
        presenter.selectUser(user)
    }
}

// Routing & Actions
extension MainViewController {
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segue = segue as? MainRouterProtocol {
            segue.openSearchModule(with: state.currentQuery)
        }
    }

    @IBAction private func unwindToMain(segue: UIStoryboardSegue) {}

    @IBAction private func textFieldDidChange(_ textField: UITextField) {
        presenter.setQuery(textField.text)
    }
}
