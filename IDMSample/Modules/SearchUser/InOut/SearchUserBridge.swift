//
//  SearchUserBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/31/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

final class SearchUserBridge: NSObject, SearchUserDependencyBridge {
    private var _presenter = SearchUserPresenter()

    @IBOutlet private weak var viewController: SearchUserViewController!
    @IBOutlet private weak var contentView: SearchUserView!
    @IBOutlet private var navigationView: SearchUserNavigationView!

    var presenter: SearchUserPresenterProtocol! { return _presenter }
    var integrator: SearchUserAbstractIntegrator!

    override init() {
        super.init()
        
        integrator = SearchUserIntegratorFactory.produce()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewController.loadViewIfNeeded()

        viewController.dependencyBridge = self

        _presenter.actionDelegate = viewController
        _presenter.add(errorHandler: viewController.asErrorHandler())
        _presenter.dataLoadingHandler = contentView.asLoadingHandler()
        
        _presenter.state.register(subscriberObject: contentView)
        _presenter.state.register(subscriberObject: navigationView)

        navigationView.actionDelegate = viewController
        contentView.actionDelegate = viewController
    }
}
