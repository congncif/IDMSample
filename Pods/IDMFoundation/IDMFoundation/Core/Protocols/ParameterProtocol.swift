//
//  ParameterProtocol.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 5/30/18.
//
import Foundation
import SiFUtilities

public protocol ParameterProtocol: KeyValueProtocol {
    var parameters: [String: Any] { get }
}

public protocol DownloadParameterProtocol: ParameterProtocol {
    func destinationUrl(suggestedFilename: String?) -> URL?
    var downloadPath: String? { get }
}

extension DownloadParameterProtocol {
    public func destinationUrl(suggestedFilename: String?) -> URL? {
        return nil
    }

    public var ignoreKeys: [String] {
        return ["downloadPath"]
    }
}
