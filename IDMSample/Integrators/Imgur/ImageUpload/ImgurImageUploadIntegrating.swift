//
//  ImgurImageUploadIntegrating.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/17/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//
import Foundation
import IDMCore
import IDMFoundation


extension ImgurImageUploadDataModel: ModelProtocol {}
extension ImgurImageUploadResponseModel: ModelProtocol {}

public typealias ImgurImageUploadBaseProvider = AnyResultDataProvider<UploadFilesParameter>

public class ImgurImageUploadIntegrator: MagicalIntegrator<ImgurImageUploadBaseProvider, ImgurImageUploadResponseModel> {}

