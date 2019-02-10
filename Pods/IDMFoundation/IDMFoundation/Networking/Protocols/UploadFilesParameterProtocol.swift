//
//  UploadFilesParameterProtocol.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//

import Foundation

public enum UploadFileType {
    case fileUrl(URL)
    case data(Data)
}

public protocol UploadFileParameterProtocol {
    var type: UploadFileType { get }
    var name: String { get }
    var fileName: String? { get }
    var mimeType: String? { get }
}

public protocol UploadFilesParameterProtocol {
    var uploadItems: [UploadFileParameterProtocol] { get }
    var query: StringKeyValueProtocol? { get }
}
