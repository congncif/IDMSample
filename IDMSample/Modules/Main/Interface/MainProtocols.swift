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

public protocol MainModuleInterface: ModuleInterface, MainInputProtocol {
    var output: MainOutputProtocol? { get set }
}

protocol MainControllerProtocol {
    var presenter: MainPresenterProtocol! { get }
    var router: MainRouterProtocol? { get }
}

extension MainControllerProtocol {
    var router: MainRouterProtocol? { return nil }
}

protocol MainPresenterProtocol {
    var state: MainViewState { get }

    func selectUser(_ user: SearchUserModel)
    func setQuery(_ query: String?)
}

protocol MainRouterProtocol {
    func openSearchModule(with query: String)
}

// In/Out

public protocol MainInputProtocol {
    func selectUser(_ user: SearchUserModel)
}

public protocol MainOutputProtocol {}
