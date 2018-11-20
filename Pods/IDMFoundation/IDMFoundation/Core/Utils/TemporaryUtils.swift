//
//  TemporaryUtils.swift
//
//
//  Created by NGUYEN CHI CONG on 4/7/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import Foundation
import SiFUtilities

public struct TemporaryUtils {
    public static func temporaryPath(fileName: String? = nil, fileExtension: String = "file") -> String {
        let temp = NSTemporaryDirectory() as NSString
        var fname = fileName ?? String.random(length: 10)
        let dateText = Date().toString(format: "_yyyy_MM_dd_hh_mm_ss_SSSS")
        fname += dateText
        let name = fileExtension.isEmpty ? fname : fname + "." + fileExtension
        let path  = temp.appendingPathComponent(name)
        return path as String
    }
    
    public static func temporaryURL(fileName: String? = nil, fileExtension: String = "") -> URL {
        let path = temporaryPath(fileName: fileName, fileExtension: fileExtension)
        return URL(fileURLWithPath: path)
    }
}
