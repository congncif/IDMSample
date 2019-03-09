//
//  MainBridge.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/10/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation

class MainBridge: MainDependencyBridge {
    override init() {
        super.init()
        presenter = MainPresenter()
    }
    
    @IBOutlet weak var viewBridge: AnyObject? {
        didSet {
            if let view = viewBridge as? MainViewProtocol {
                presenter.register(view: view)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
