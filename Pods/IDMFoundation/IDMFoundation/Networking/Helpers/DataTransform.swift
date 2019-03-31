//
//  DataTransform.swift
//  IDMFoundation
//
//  Created by NGUYEN CHI CONG on 3/16/19.
//

import Foundation

extension UIImage {
    @objc open func transformImageToData() -> Data? {
        return self.pngData()
    }
}

extension Data {
    public func image<CustomImage: UIImage>() -> CustomImage? {
        return CustomImage(data: self)
    }
}
