//
//  StandardProgressResponseModel.swift
//  IDMFoundation
//
//  Created by FOLY on 3/15/18.
//

import Foundation
import IDMCore

open class StandardProgressResponseModel: ProgressModelProtocol {
    public var progress: Progress?
    public var isDelaying: Bool = false

    public required init?(fromData data: Any?) throws {
        if let _progress = data as? Progress {
            progress = _progress
            isDelaying = true
        } else {
            isDelaying = false
        }
    }
}

open class StandardProgressDataResponseModel<D: ModelProtocol>: StandardProgressResponseModel where D.DataType == Any {
    public var data: D?

    public required init?(fromData data: Any?) throws {
        do {
            try super.init(fromData: data)
            self.data = try D(fromData: data)
        } catch let ex {
            throw ex
        }
    }

    open var invalidDataError: Error? {
        return data?.invalidDataError
    }
}
