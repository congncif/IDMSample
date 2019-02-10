//
//  CameraAsset+Temporary.swift
//  IDMExtension
//
//  Created by FOLY on 2/1/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import SiFUtilities

/**
 * To custom asset quality before uploading, create a subclass of CameraAsset then override `transformImageToData(_:)`, currently only support image
 * Eg: class SubAsset: CameraAsset {...}
 * let subAsset = asset as? SubAsset ...
 */
extension CameraAsset: TemporaryProtocol {
    @objc open func saveTemporary(name: String? = nil) throws -> URL {
        var url: URL
        
        switch type {
        case .video:
            url = TemporaryUtils.temporaryURL(fileName: name, fileExtension: "mov")
            if let videoURL = self.url {
                do {
                    try FileManager.default.copyItem(at: videoURL, to: url)
                } catch let ex {
                    let err = CommonError(title: "Can not copy video".localized, message: ex.localizedDescription)
                    throw err
                }
            } else {
                let err = CommonError(message: "Video URL not found".localized)
                throw err
            }
            
        default:
            url = TemporaryUtils.temporaryURL(fileName: name, fileExtension: "png")
            if let image = self.image?.fixOrientation() {
                let data = transformImageToData(image)
                do {
                    try data?.write(to: url)
                } catch let e {
                    let error = CommonError(title: "Can not save temporary image".localized, message: e.localizedDescription)
                    throw error
                }
            } else {
                let err = CommonError(message: "Image not found".localized)
                throw err
            }
        }
        return url
    }
    
    @objc open func transformImageToData(_ image: UIImage) -> Data? {
        return image.pngData()
    }
}
