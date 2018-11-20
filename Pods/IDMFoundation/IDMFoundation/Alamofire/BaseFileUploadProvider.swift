//
//  BaseFileUploadProvider.swift
//  IDMFoundation
//
//  Created by FOLY on 10/28/18.
//

import Foundation
import Alamofire

open class BaseFileUploadProvider: BaseUploadProvider<UploadFilesParameter> {
    open override func buildFormData(multipart: MultipartFormData, with parameters: UploadFilesParameter?) {
        if let exData = parameters {
            multipart.append(urlParameter: exData)
        }
    }
    
    open override func cleanUp(parameters: UploadFilesParameter?) {
       // do nothing
    }
    
    open override func saveTemporary(parameters: UploadFilesParameter?) {
        // do nothing
    }
}
