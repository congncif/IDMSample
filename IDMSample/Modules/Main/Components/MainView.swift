//
//  MainView.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ViewStateCore

class MainView: UIView {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectedUserLabel: UILabel!
}

extension MainView: ViewStateFillable{
//    ViewStateRenderable
//    public func render(state: ViewState) {
//        if let state = state as? MainViewState.QueryState {
//            searchField.text = state.query
//            searchButton.isEnabled = !state.query.isNoValue
//        }
//        else if let state = state as? MainViewState.SelectionState {
//            selectedUserLabel.text = state.selectedUser?.name
//        }
//    }
    
    func fillingOptions(_ state: ViewState) -> [FillingOption] {
        if state is MainViewState.QueryState {
            let queryOption = FillingOption(keyPath: #keyPath(MainViewState.QueryState.query), target: searchField, targetKeyPath: #keyPath(UITextField.text))
            
            let isSearchEnabledKey = #keyPath(MainViewState.QueryState.query)
            let searchEnableOption = FillingOption(keyPath: isSearchEnabledKey) { [weak searchButton] query in
                let _query = query as? String
                searchButton?.isEnabled = !_query.isNoValue
            }
            
            return [queryOption, searchEnableOption]
        }
        else if state is MainViewState.SelectionState {
            let selectedKey = #keyPath(MainViewState.SelectionState.selectedUser)
            let selectedOption = FillingOption(keyPath: selectedKey) { [weak selectedUserLabel] user in
                let selectedUser = user as? SearchUserModel
                selectedUserLabel?.text = selectedUser?.name
            }
            
            return [selectedOption]
        }
        return []
    }
}
