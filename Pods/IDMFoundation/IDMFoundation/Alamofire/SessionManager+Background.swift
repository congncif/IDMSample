//
//  SessionManager+Background.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//

import Alamofire
import Foundation

extension SessionManager {
    public static let background: SessionManager = _sharedBackground

    private static var _sharedBackground: SessionManager {
        let id = ProcessInfo.processInfo.globallyUniqueString
        let configuration = URLSessionConfiguration.background(withIdentifier: id)
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let session = SessionManager(configuration: configuration)
        return session
    }
}
