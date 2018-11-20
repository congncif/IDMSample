//
//  URLUploadProtocol.swift
//  IDMFoundation
//
//  Created by FOLY on 3/9/18.
//

import Foundation
import SiFUtilities

public protocol StringKeyValueProtocol: ParameterProtocol {
    var queryParameters: [(String, String)] { get }
}

public protocol URLUploadItemProtocol {
    var uploadUrl: URL { get }
    var uploadName: String { get }
    var fileName: String? { get }
    var mimeType: String? { get }

    mutating func saveTemporaryData() // change URL
    func cleanTemporaryData()
}

extension URLUploadItemProtocol {
    public func cleanTemporaryData() {
        do {
            try FileManager.default.removeItem(at: uploadUrl)
            log("Removed temporary file: \(uploadUrl.path)")
        } catch let ex {
            print("Can't delete temporary file: \(uploadUrl.path) - \(ex)")
        }
    }
}

extension StringKeyValueProtocol {
    public var queryParameters: [(String, String)] {
        var components: [(String, String)] = []
        let params = parameters
        for key in params.keys.sorted(by: <) {
            let value = params[key]!
            components += queryComponents(fromKey: key, value: value)
        }

        return components
    }

    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: key + "[]", value: value)
            }
        } else {
            components.append((key, String(describing: value)))
        }

        return components
    }
}
