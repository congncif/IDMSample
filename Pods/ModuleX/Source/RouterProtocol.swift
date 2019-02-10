//
//  RouterProtocol.swift
//  IDMFoundation
//
//  Created by FOLY on 11/8/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation

public protocol Closable: class {
    func close(transition: TransitionProtocol?)
}

public protocol RouterProtocol: class {
    var sourceModule: ModuleInterface? { get }
    
    func open(_ desinationModule: ModuleInterface, transition: TransitionProtocol)
}
