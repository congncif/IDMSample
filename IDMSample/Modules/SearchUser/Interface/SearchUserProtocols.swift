//
//  SearchUserProtocols.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
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

protocol SearchUserViewActionDelegate: AnyObject {
    func activeView()
    func listItemDidSelect(at index: Int)
    func refresh()
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
    var actionDelegate: SearchUserViewActionDelegate? { get }
    var errorHandler: ErrorHandlingProtocol { get }

    var dataLoadingHandler: LoadingProtocol! { get }
    var dataResponseHandler: DataProcessor<SearchUserResponseModel> { get }
    
    func start(with query: String)
    func currentQuery() -> String
    func setUsers(_ users: [SearchUserModel])
    func user(at index: Int) -> SearchUserModel
}

protocol SearchUserRouterProtocol {}
