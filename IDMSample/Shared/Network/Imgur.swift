//
//  Imgur.swift
//  IDMSample
//
//  Created by NGUYEN CHI CONG on 2/17/19.
//  Copyright © 2019 [iF] Solution. All rights reserved.
//

import Alamofire
import Foundation
import IDMFoundation
import SiFUtilities

protocol ImgurEndpointProtocol: EndpointProtocol {}

extension ImgurEndpointProtocol {
    static var base: String { return "https://api.imgur.com/3" }
}

enum ImgurEndpoint: String, ImgurEndpointProtocol {
    static var root = String()

    case image
}

extension NetworkRoute {
    init(imgurEndpoint: ImgurEndpointProtocol, method: HTTPMethod) {
        self.init(endpoint: imgurEndpoint,
                  method: method,
                  headers: ["Authorization": ImgurRoute.accessToken.bearer])
    }
}

struct ImgurRoute {
    static var accessToken: String = "25697a2f34b88cfe5c9a78b3760d9a83a480b485"

    struct Image {
        static let upload = NetworkRoute(imgurEndpoint: ImgurEndpoint.image, method: .post)
    }
}
