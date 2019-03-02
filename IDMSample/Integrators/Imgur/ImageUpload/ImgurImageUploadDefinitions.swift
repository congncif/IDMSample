//
//  ImgurImageUploadDefinitions.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/17/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//
import Foundation
import IDMCore
import IDMFoundation

public struct ImgurImageUploadDataModel {}

public class ImgurImageUploadResponseModel: NSObject, ProgressDataModelProtocol {
	public var progress: Progress?
    public var isDelaying: Bool = false
    public var data: ImgurImageUploadDataModel?
}

public typealias ImgurImageUploadAbstractIntegrator = AbstractIntegrator<UploadFilesParameter, ImgurImageUploadResponseModel>