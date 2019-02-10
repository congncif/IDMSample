//
//  Data+Temporary.swift
//  Alamofire
//
//  Created by FOLY on 4/5/18.
//

import Foundation
import SiFUtilities

extension Data: TemporaryProtocol {
    public func saveTemporary(name: String? = nil) throws -> URL {
        let url = TemporaryUtils.temporaryURL(fileName: name)
        do {
            try self.write(to: url)
        } catch let e {
            let error = CommonError(message: e.localizedDescription)
            throw error
        }
        return url
    }
}

extension Data {
    public func image<CustomImage: UIImage>() -> CustomImage? {
        return CustomImage(data: self)
    }
}
