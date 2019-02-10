//
//  MainBuilderProtocol.swift
//  IDMFoundation_Example
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMCore
import ModuleX
import ViewStateCore

public protocol MainModuleInterface: ModuleInterface, MainInputProtocol {}

protocol MainControllerProtocol {
    var presenter: MainPresenterProtocol! { get }
    var router: MainRouterProtocol? { get }
}

protocol MainPresenterProtocol {
    var state: MainViewState { get }

    func selectUser(_ user: SearchUserModel)
    func setQuery(_ query: String?)
}

// Go in module

public protocol MainBuilderProtocol: ModuleBuilderProtocol {
    func findInNavigationContainer(from source: ModuleInterface) -> MainModuleInterface?
}

// Go out module

protocol MainRouterProtocol: MainOutputProtocol {}

// In/Out

public protocol MainInputProtocol {
    func selectUser(_ user: SearchUserModel)
}

protocol MainOutputProtocol {
    func openSearchModule(with query: String)
}
