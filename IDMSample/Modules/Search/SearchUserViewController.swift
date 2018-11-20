//
//  SearchUserViewController.swift
//  IDMSample
//
//  Created by FOLY on 11/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import SDWebImage
import UIKit
import ViewStateCore

public class SearchUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    public var presenter = SearchUserPresenter()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidFinishLayout() {
        presenter.state.subscribe(for: self)
        
        presenter.search(loader: self, text: "apple")
    }
    
    @IBAction func refreshButtonDidTap() {
        presenter.search(loader: self, text: "apple")
    }
}

// MARK: - properties

extension SearchUserViewController {
    var users: [SearchUserModel] {
        return presenter.state.users
    }
}

// MARK: - render UI

extension SearchUserViewController: ViewStateSubscriber, ViewStateRenderable {
    public func render(state: ViewState) {
        tableView.reloadData()
    }
}

// MARK: - TableView

extension SearchUserViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let model = users[indexPath.row]
        
        let imageView = cell.viewWithTag(1) as? UIImageView
        imageView?.image = nil
        if let avatar = model.avatar {
            let url = URL(string: avatar)
            imageView?.sd_setImage(with: url)
        }
        
        let titleLabel = cell.viewWithTag(2) as? UILabel
        titleLabel?.text = model.name
        
        let homeLabel = cell.viewWithTag(3) as? UILabel
        let homeUrl = model.profileUrl
        homeLabel?.text = homeUrl
        
        return cell
    }
}
