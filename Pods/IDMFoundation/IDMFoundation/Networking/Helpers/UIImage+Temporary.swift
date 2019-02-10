//
//  UIImage+Temporary.swift
//  IDMFoundation
//
//  Created by FOLY on 3/9/18.
//
import AVFoundation
import Foundation
import SiFUtilities
import UIImage_FixOrientation

extension UIImage: TemporaryProtocol {
    @objc open func saveTemporary(name: String? = nil) throws -> URL {
        let url = TemporaryUtils.temporaryURL(fileName: name, fileExtension: "png")

        if let img = self.fixOrientation() {
            let data = img.transformImageToData()
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
        return url
    }
}

extension UIImage {
    @objc open func transformImageToData() -> Data? {
        return self.pngData()
    }
}
