//
//  SearchUserViewController.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit
import ViewStateCore

public class SearchUserViewController: UIViewController, SearchUserControllerBridgeProtocol, SearchUserViewActionDelegate, SearchUserModuleInterface {
    public var output: SearchUserOutputProtocol?

    @IBOutlet var bridge: SearchUserDependencyBridge!

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func viewDidFinishLayout() {
        performSearch()
    }

    public func start(with query: String) {
        presenter.start(with: query)
    }
}

// Routing & Actions
extension SearchUserViewController {
    @IBAction private func refreshButtonDidTap() {
        performSearch()
    }
}

extension SearchUserViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = state.users[indexPath.row]
        output?.userDidSelect(model)
    }
}
