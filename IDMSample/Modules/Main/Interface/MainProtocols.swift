//
//  MainProtocols.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/2/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation
import ModuleX
import ViewStateCore

/// Come from outside

public protocol MainModuleInterface: ModuleInterface, MainInputProtocol {
	var output: MainOutputProtocol? { get set }
}

/// In/Out

public protocol MainInputProtocol {
	// Declare method to come in from outside module
    func selectUser(_ user: SearchUserModel)
}

public protocol MainOutputProtocol {
	// Declare method to go out module
}

/// Internal

protocol MainViewActionDelegate: class {
    func viewReady()
    
    func searchQueryDidChange(_ query: String)
}

protocol MainViewProtocol: ViewStateSubscriber {
    var actionDelegate: MainViewActionDelegate? { get }
}

protocol MainControllerProtocol {
    var presenter: MainPresenterProtocol! { get }

    // Declare methods to work internal module
}

protocol MainPresenterProtocol {
    func register(view: MainViewProtocol)
    func currentQuery() -> String
    func selectUser(_ user: SearchUserModel)
    func setQuery(_ query: String?)
}

protocol MainRouterProtocol {
    func openSearchModule(with query: String)
}
