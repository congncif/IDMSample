//
//  NetworkParameterProtocol.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//

import Foundation
import SiFUtilities

public protocol URLBuildable {
    func build(from endpoint: EndpointProtocol) throws -> URL
}

public protocol ParameterProtocol: KeyValueProtocol, URLBuildable {
    var payload: [String: Any] { get }
}

extension ParameterProtocol {
    public var payload: [String: Any] {
        return dictionary
    }
}

public protocol DownloadParameterProtocol: ParameterProtocol {
    func destinationUrl(suggestedFilename: String?) -> URL?
}

extension DownloadParameterProtocol {
    public func destinationUrl(suggestedFilename: String?) -> URL? {
        return nil
    }
}
