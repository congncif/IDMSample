//
//  ImgurImageUploadIntegratorFactory.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/17/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Foundation
import IDMFoundation

public class ImgurImageUploadIntegratorFactory {
	public static func getIntegrator() -> ImgurImageUploadAbstractIntegrator {
        let route = ImgurRoute.Image.upload
		return ImgurImageUploadIntegrator(dataProvider: ImgurImageUploadUploadProvider(route: route), executingType: .only)
	}
}
