//
//  CameraAsset+Upload.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 1/27/19.
//

import Foundation

extension UploadFilesParameter {
    public convenience init(assets: [CameraAsset], name: String = "assets") {
        let items = assets.compactMap { data -> UploadFileParameterProtocol? in
            switch data.type {
            case .photo:
                guard let imgData = data.image?.pngData() else { return nil }
                return UploadDataFileParameter(data: imgData, name: name)
            case .video:
                guard let url = data.url else { return nil }
                return UploadUrlFileParameter(url: url, name: name)
            }
        }
        self.init(items: items)
    }

    public convenience init<T: StringKeyValueProtocol>(assets: [CameraAsset], name: String = "assets", query: T) {
        self.init(assets: assets, name: name)
        self.query = query
    }
    
    @objc open func transformImageToData(_ image: UIImage) -> Data? {
        return image.pngData()
    }
}
