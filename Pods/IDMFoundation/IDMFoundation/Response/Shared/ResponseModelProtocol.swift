//
//  ResponseModelProtocol.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 6/6/18.
//

import Foundation

public protocol ResponseModelProtocol {
    var status: Int? { get set }
    var message: String? { get set }
}
