//
//  BaseURLUploadProvider.swift
//  IDMCommon
//
//  Created by NGUYEN CHI CONG on 8/29/17.
//  Copyright © 2017 NGUYEN CHI CONG. All rights reserved.
//

import Alamofire
import Foundation
import IDMCore
import SiFUtilities

public typealias UploadRequestAdapter = NetworkRequestAdapter<UploadRequest>

extension NetworkResponseHandler where BaseRequest == UploadRequest {
    public static let `default` = NetworkResponseHandler<UploadRequest>(handler: { request, completion in
        request.uploadProgress { progress in
            completion(.success(progress))
        }

        request.responseJSON { response in
            let isSuccess = response.result.isSuccess
            if isSuccess {
                log(url: response.response?.url, mark: "🌸", data: response.value)
                completion(.success(response.value))
            } else {
                log(url: response.response?.url, mark: "🥀", data: response.error)
                completion(.failure(response.error.unwrapped(UnknownError.default)))
            }
        }
    })
}

open class BaseUploadProvider<Parameter>: NetworkDataProvider<UploadRequest, Parameter>
    where Parameter: UploadFilesParameterProtocol, Parameter: URLBuildable {
    public var encoding: (MultipartFormData, Parameter?) -> Void

    public init(route: NetworkRequestRoutable,
                parameterEncoding: @escaping (MultipartFormData, Parameter?) -> Void = {
                    guard let param = $1 else { return }
                    $0.append(fileParameter: param)
                },
                urlRequestAdapters: [URLRequestAdapting] = [],
                requestAdapter: RequestApdapterType? = nil,
                responseHandler: ResponseHandlerType = NetworkResponseHandler<UploadRequest>.default,
                sessionManager: SessionManager = .background) {
        self.encoding = parameterEncoding
        super.init(route: route,
                   parameterEncoder: URLEncoding.default,
                   urlRequestAdapters: urlRequestAdapters,
                   requestAdapter: requestAdapter,
                   responseHandler: responseHandler,
                   sessionManager: sessionManager)
    }

    private weak var request: UploadRequest? // hack to buildRequest, just refer don't keep alive

    open override func request(parameters: Parameter?, completionResult: @escaping (ResultType) -> Void) -> CancelHandler? {
        do {
            let newRequest = try self.buildAdaptiveURLRequest(with: parameters) // don't encode parameters
            log(url: newRequest.url, mark: "📦", data: parameters?.query?.queryParameters)
            self.sessionManager.upload(multipartFormData: { [weak self] in self?.encoding($0, parameters) },
                                       with: newRequest) { [weak self] encodingResult in
                guard let self = self else { return }
                switch encodingResult {
                case .success(let upload, _, _):
                    self.request = upload
                    self.request = try? self.buildFinalRequest(with: parameters)
                    if let _request = self.request {
                        self.processRequest(_request, completion: completionResult)
                    } else {
                        completionResult(.failure(UnknownError.default))
                    }
                case .failure(let encodingError):
                    completionResult(.failure(encodingError))
                }
            }
        } catch let exception {
            completionResult(.failure(exception))
        }

        let cancelHandler: CancelHandler? = { [weak self] in
            guard let self = self, let _request = self.request else { return }
            self.cancelRequest(_request)
        }
        return cancelHandler
    }

    open override func buildRequest(with parameters: Parameter?) throws -> UploadRequest {
        if let _request = request {
            return _request
        }
        throw CommonError(message: "Cannot buildRequest".localized())
    }

    open override func cancelRequest(_ request: UploadRequest) {
        request.cancel()
    }
}
