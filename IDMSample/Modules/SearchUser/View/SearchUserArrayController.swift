//
//  TableArrayController.swift
//  NativeRouter
//
//  Created by NGUYEN CHI CONG on 2/1/19.
//  Copyright © 2019 NGUYEN CHI CONG. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit
import ViewStateCore

class SearchUserArrayController: NSObject, UITableViewDataSource {
    @IBOutlet private weak var tableView: UITableView?
    
    var users: [SearchUserModel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: SearchUserTableViewCell.className, for: indexPath)
        if let cell = dequeueCell as? SearchUserTableViewCell {
            let model = users[indexPath.row]
            cell.load(data: model)
        }
        return dequeueCell
    }
}

// Load cell data

extension SearchUserTableViewCell {
    fileprivate func load(data: SearchUserModel) {
        thumbImageView.image = nil
        if let avatar = data.avatar {
            let url = URL(string: avatar)
            thumbImageView.sd_setImage(with: url)
        }
        titleLabel.text = data.name
        homePageLabel.text = data.profileUrl
    }
}
