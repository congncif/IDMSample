//
//  UploadURLsParameter.swift
//
//
//  Created by NGUYEN CHI CONG on 8/29/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//

import Foundation

open class URLUploadItem: URLUploadItemProtocol {
    open var uploadUrl: URL
    open var uploadName: String
    open var fileName: String?
    open var mimeType: String?
    
    public init(url: URL, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.uploadUrl = url
        self.uploadName = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    open func saveTemporaryData() {
        // Do nothing
    }
}

open class ImageUploadItem: URLUploadItemProtocol {
    open private(set) var uploadUrl: URL = URL(fileURLWithPath: "")
    open var uploadName: String = ""
    open var fileName: String?
    open var mimeType: String?
    
    open var image: UIImage
    
    public init(image: UIImage, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.image = image
        self.uploadName = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    open func saveTemporaryData() {
        do {
            let url = try image.saveTemporary(name: fileName)
            uploadUrl = url
        } catch let ex {
            print("Error in \(#function): \(String(describing: ex))")
        }
    }
}

open class ImageDataUploadItem: URLUploadItemProtocol {
    open private(set) var uploadUrl: URL = URL(fileURLWithPath: "")
    open var uploadName: String = ""
    open var fileName: String?
    open var mimeType: String?
    
    open var imageData: Data
    
    public init(imageData: Data, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.imageData = imageData
        self.uploadName = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    open func saveTemporaryData() {
        do {
            let url = try imageData.saveTemporary(name: fileName)
            uploadUrl = url
        } catch let ex {
            print("Error in \(#function): \(String(describing: ex))")
        }
    }
}

open class UploadURLsParameter {
    open var uploadItems: [URLUploadItemProtocol]
    
    open var query: StringKeyValueProtocol?
    
    public init(urls: [URL], name: String = "files") {
        var items = [URLUploadItem]()
        for url in urls {
            let item = URLUploadItem(url: url, name: name)
//            item.saveTemporaryData()
            items.append(item)
        }
        self.uploadItems = items
    }
    
    public convenience init<T: StringKeyValueProtocol>(urls: [URL], name: String = "files", query: T) {
        self.init(urls: urls, name: name)
        self.query = query
    }
    
    public init(items: [URLUploadItemProtocol]) {
        self.uploadItems = items.map { (item) -> URLUploadItemProtocol in
            let newItem = item
//            newItem.saveTemporaryData()
            return newItem
        }
    }
    
    public convenience init<T: StringKeyValueProtocol>(items: [URLUploadItemProtocol], query: T) {
        self.init(items: items)
        self.query = query
    }
    
    public convenience init(images: [UIImage], name: String = "images") {
        let items = images.map { img -> ImageUploadItem in
            return ImageUploadItem(image: img, name: name)
        }
        self.init(items: items)
    }
    
    public convenience init<T: StringKeyValueProtocol>(images: [UIImage], name: String = "images", query: T) {
        self.init(images: images, name: name)
        self.query = query
    }
    
    public convenience init(imageData: [Data], name: String = "images") {
        let items = imageData.map { img -> ImageDataUploadItem in
            return ImageDataUploadItem(imageData: img, name: name)
        }
        self.init(items: items)
    }
    
    public convenience init<T: StringKeyValueProtocol>(imageData: [Data], name: String = "images", query: T) {
        self.init(imageData: imageData, name: name)
        self.query = query
    }
    
    open func cleanUp() throws {
        for item in self.uploadItems {
            item.cleanTemporaryData()
        }
    }
}
