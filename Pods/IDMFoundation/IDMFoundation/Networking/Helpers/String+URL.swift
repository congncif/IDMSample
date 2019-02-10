//
//  String+URL.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/30/19.
//

import Foundation
import SiFUtilities

extension String {
    func toURL() throws -> URL {
        guard let url = URL(string: self) else { throw CommonError(message: "InvalidURL".localized()) }
        return url
    }
}
