//
//  UploadParameter.swift
//  IDMFoundation
//
//  Created by FOLY on 10/28/18.
//

import Foundation

open class UploadDataFileParameter: UploadFileParameterProtocol {
    public var type: UploadFileType
    public var name: String
    public var fileName: String?
    public var mimeType: String?

    public init(data: Data, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.type = .data(data)
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

open class UploadUrlFileParameter: UploadFileParameterProtocol {
    public var type: UploadFileType
    public var name: String
    public var fileName: String?
    public var mimeType: String?

    public init(url: URL, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.type = .fileUrl(url)
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

open class UploadFilesParameter: UploadFilesParameterProtocol {
    open var uploadItems: [UploadFileParameterProtocol]
    open var query: StringKeyValueProtocol?

    public init(urls: [URL], name: String = "files") {
        var items: [UploadUrlFileParameter] = []
        for url in urls {
            let item = UploadUrlFileParameter(url: url, name: name)
            items.append(item)
        }
        self.uploadItems = items
    }

    public convenience init<T: StringKeyValueProtocol>(urls: [URL], name: String = "files", query: T) {
        self.init(urls: urls, name: name)
        self.query = query
    }

    public init(items: [UploadFileParameterProtocol]) {
        self.uploadItems = items.map { (item) -> UploadFileParameterProtocol in
            let newItem = item
            return newItem
        }
    }

    public convenience init<T: StringKeyValueProtocol>(items: [UploadFileParameterProtocol], query: T) {
        self.init(items: items)
        self.query = query
    }

    public convenience init(images: [UIImage], name: String = "images") {
        let items = images.map { img -> UploadDataFileParameter in
            if let data = img.transformImageToData() {
                return UploadDataFileParameter(data: data, name: name)
            } else {
                fatalError("No data available")
            }
        }
        self.init(items: items)
    }

    public convenience init<T: StringKeyValueProtocol>(images: [UIImage], name: String = "images", query: T) {
        self.init(images: images, name: name)
        self.query = query
    }

    public convenience init(imageData: [Data], name: String = "images") {
        let items = imageData.map { data -> UploadDataFileParameter in
            return UploadDataFileParameter(data: data, name: name)
        }
        self.init(items: items)
    }

    public convenience init<T: StringKeyValueProtocol>(imageData: [Data], name: String = "images", query: T) {
        self.init(imageData: imageData, name: name)
        self.query = query
    }
}

extension UploadFilesParameter: URLBuildable {}
