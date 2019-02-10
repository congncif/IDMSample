//
//  CameraAsset.swift
//
//
//  Created by NGUYEN CHI CONG on 4/7/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import AVFoundation
import Foundation
import MobileCoreServices
import UIKit

public enum AssetType: String {
    case photo
    case video
    
    public var key: String {
        switch self {
        case .video:
            return kUTTypeMovie as String
        default:
            return kUTTypeImage as String
        }
    }
}

open class CameraAsset: NSObject {
    open var type: AssetType
    open var image: UIImage?
    open var url: URL?
    open var thumbnail: UIImage? {
        switch type {
        case .photo:
            return image
        case .video:
            guard let url = url else {
                return nil
            }
            return generateThumbImage(url: url)
        }
    }
    
    public init(type: AssetType, image: UIImage? = nil, url: URL? = nil) {
        self.type = type
        self.image = image
        self.url = url
    }
    
    private func generateThumbImage(url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time: CMTime = CMTimeMake(value: 1, timescale: 30)
        
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let frameImg = UIImage(cgImage: img)
            return frameImg
        } catch let ex {
            print(ex)
            return nil
        }
    }
}
