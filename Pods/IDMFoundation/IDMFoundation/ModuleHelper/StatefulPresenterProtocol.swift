//
//  StatefulPresenterProtocol.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 3/27/19.
//

import Foundation
import ViewStateCore

public protocol StatefulPresenterProtocol {
    associatedtype State: ViewState
    
    var state: State { get }
}
