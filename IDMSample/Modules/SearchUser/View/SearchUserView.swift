//
//  SearchUserView.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import UIKit
import ViewStateCore

class SearchUserView: UIView, SearchUserViewProtocol {
	@IBOutlet weak var actionDelegateBridge: AnyObject?
    
    @IBOutlet var dataSource: SearchUserArrayController?
    @IBOutlet weak var tableView: UITableView!

    var actionDelegate: SearchUserViewActionDelegate? {
        return actionDelegateBridge as? SearchUserViewActionDelegate
    }
    
    @IBAction func refreshButtonDidTap() {
        actionDelegate?.refresh()
    }
}

extension SearchUserView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionDelegate?.listItemDidSelect(at: indexPath.row)
    }
}

// Render ViewState

extension SearchUserView: ViewStateRenderable {
    func render(state: ViewState) {
        guard let state = state as? SearchUserViewState else { return }
        dataSource?.users = state.users
    }
}
