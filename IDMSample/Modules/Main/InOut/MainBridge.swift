//
//  MainBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 3/30/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

final class MainBridge: NSObject, MainDependencyBridge {
    private var _presenter = MainPresenter()

    @IBOutlet private weak var viewController: MainViewController!
    @IBOutlet private weak var view: MainView!

    var presenter: MainPresenterProtocol! { return _presenter }

    override init() {
        super.init()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewController.loadViewIfNeeded()

        viewController.dependencyBridge = self

        _presenter.add(errorHandler: viewController.asErrorHandler())
        _presenter.dataLoadingHandler = view.asLoadingHandler()
        _presenter.state.register(subscriberObject: view)

        view.actionDelegate = viewController
    }
}
