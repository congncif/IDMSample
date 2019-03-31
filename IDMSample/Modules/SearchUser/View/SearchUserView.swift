//
//  SearchUserView.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import UIKit
import ViewStateCore

final class SearchUserView: UIView, SearchUserViewProtocol {
    weak var actionDelegate: SearchUserViewActionDelegate?
    
    @IBOutlet var dataSource: SearchUserArrayController?
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
