//
//  SearchUserViewController.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public class SearchUserViewController: UIViewController, SearchUserControllerBridgeProtocol, SearchUserModuleInterface {
    public weak var output: SearchUserOutputProtocol?

    @IBOutlet var bridge: SearchUserDependencyBridge!
    @IBOutlet var usersArrayController: SearchUserArrayController!

    @IBOutlet weak var tableView: UITableView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Keep this at end of viewDidLoad
        usersArrayController.subscribeStateChange(state)
    }

    public override func viewDidFinishLayout() {
        performSearch(query: state.query.unwrapped(), displayer: self)
    }

    public func start(with query: String) {
        presenter.start(with: query)
    }
}

// Routing & Actions
extension SearchUserViewController {
    @IBAction private func refreshButtonDidTap() {
        performSearch(query: state.query.unwrapped(), displayer: self)
    }
}

extension SearchUserViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = state.users[indexPath.row]
        output?.userDidSelect(model)
    }
}
