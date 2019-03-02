//
//  SearchUserProtocols.swift
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

public protocol SearchUserModuleInterface: ModuleInterface, SearchUserInputProtocol {
	var output: SearchUserOutputProtocol? { get set }
}

/// In/Out

public protocol SearchUserInputProtocol {
	// Declare method to come in from outside module
    func start(with query: String)
}

public protocol SearchUserOutputProtocol {
	// Declare method to go out module
    func userDidSelect(_ user: SearchUserModel)
}

/// Internal

protocol SearchUserViewActionDelegate: class {
    func viewReady()
}

protocol SearchUserViewProtocol: ViewStateSubscriber {
    var actionDelegate: SearchUserViewActionDelegate? { get }
}

protocol SearchUserControllerProtocol {
    var presenter: SearchUserPresenterProtocol! { get }
    var integrator: SearchUserAbstractIntegrator! { get }

    // Declare methods to work internal module
}

protocol SearchUserPresenterProtocol {
    var state: SearchUserViewState { get }

    var dataLoadingMonitor: LoadingMonitorProtocol? { get set }
    var dataProcessor: DataProcessor<SearchUserResponseModel> { get }
    
    func start(with query: String)
    func setUsers(_ users: [SearchUserModel])
}

protocol SearchUserRouterProtocol {}
