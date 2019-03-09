//
//  SearchUserBridge.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import IDMCore
import IDMFoundation

class SearchUserBridge: SearchUserDependencyBridge {
    @IBOutlet weak var loadingHandler: AnyObject? {
        didSet {
            if let handler = loadingHandler as? LoadingObjectProtocol {
                presenter.loadingHandler = handler.asValueType()
            }
        }
    }
    
    @IBOutlet weak var viewBridge: AnyObject? {
        didSet {
            if let view = viewBridge as? SearchUserViewProtocol {
                presenter.register(view: view)
            }
        }
    }
    
    @IBOutlet weak var errorHandler: AnyObject? {
        didSet {
            if let handler = errorHandler as? ErrorHandlingObjectProtocol, let _presenter = presenter as? SearchUserPresenter {
                _presenter.register(errorHandler: handler.asValueType())
            }
        }
    }

    override init() {
        super.init()
        presenter = SearchUserPresenter()
        integrator = SearchUserIntegratorFactory.getIntegrator()
    }
}
