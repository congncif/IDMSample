//
//  SearchUserViewController.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit
import SiFUtilities
import ViewStateCore

public final class SearchUserViewController: UIViewController, SearchUserControllerBridgeProtocol, SearchUserModuleInterface {
    public var output: SearchUserOutputProtocol?

    var dependencyBridge: SearchUserDependencyBridge!

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func start(with query: String) {
        presenter.start(with: query)
    }
}

extension SearchUserViewController: SearchUserViewActionDelegate {
    public override func viewDidFinishInitialLayout() {
        viewReady()
    }
}
