//
//  MainView.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import UIKit
import ViewStateCore

class MainView: UIView, MainViewProtocol {
    @IBOutlet weak var actionDelegateBridge: AnyObject?
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectedUserLabel: UILabel!
    
    var actionDelegate: MainViewActionDelegate? {
        return actionDelegateBridge as? MainViewActionDelegate
    }
    
    @IBAction func searchFieldDidChange(_ textField: UITextField) {
        actionDelegate?.searchQueryDidChange(textField.text!)
    }
}

extension MainView: ViewStateFillable {
    func fillingOptions(_ state: ViewState) -> [FillingOption] {
        if state is MainViewState.QueryState {
            struct Keys {
                private init() {}
                static let query = #keyPath(MainViewState.QueryState.query)
                static let isSearchEnabled = #keyPath(MainViewState.QueryState.query)
            }
            
            let queryOption = FillingOption(keyPath: Keys.query,
                                            target: searchField,
                                            targetKeyPath: #keyPath(UITextField.text))
            let searchEnableOption = FillingOption(keyPath: Keys.isSearchEnabled) { [weak searchButton] query in
                let _query = query as? String
                searchButton?.isEnabled = !_query.isNoValue
            }
            
            return [queryOption, searchEnableOption]
        }
        else if state is MainViewState.SelectionState {
            struct Keys {
                private init() {}
                static let selectedUser = #keyPath(MainViewState.SelectionState.selectedUser)
            }
            
            let selectedOption = FillingOption(keyPath: Keys.selectedUser) { [weak selectedUserLabel] user in
                let selectedUser = user as? SearchUserModel
                selectedUserLabel?.text = selectedUser?.name
            }
            
            return [selectedOption]
        }
        return []
    }
}
