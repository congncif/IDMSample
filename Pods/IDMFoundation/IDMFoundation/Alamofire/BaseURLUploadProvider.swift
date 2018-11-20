//
//  BaseURLUploadProvider.swift
//  Alamofire
//
//  Created by NGUYEN CHI CONG on 6/6/18.
//

import Foundation
import Alamofire

open class BaseURLUploadProvider: BaseUploadProvider<UploadURLsParameter> {
    open override func buildFormData(multipart: MultipartFormData, with parameters: UploadURLsParameter?) {
        if let exData = parameters {
            multipart.append(urlParameter: exData)
        }
    }

    open override func cleanUp(parameters: UploadURLsParameter?) {
        if let exData = parameters {
            try? exData.cleanUp()
        }
    }

    open override func saveTemporary(parameters: UploadURLsParameter?) {
        if let exData = parameters {
            for var item in exData.uploadItems {
                item.saveTemporaryData()
            }
        }
    }
}
