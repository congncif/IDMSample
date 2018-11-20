//
//  BaseProvider.swift
//  IDMFoundation
//
//  Created by FOLY on 7/21/18.
//
import Alamofire
import Foundation
import IDMCore
import SiFUtilities

open class BaseProvider<ParameterType>: RootAnyProvider<ParameterType> {
    open override func request(parameters: ParameterType?, completion: @escaping (Bool, Any?, Error?) -> Void) -> CancelHandler? {
        fatalError("You need custom \(#function) for request \(self.requestPath(parameters: parameters))")
    }
    
    open func requestPath(parameters: ParameterType?) -> String {
        fatalError("You need set the path for request by override function \(#function)")
    }
    
    open func validate(parameters: ParameterType?) -> Error? {
        return nil
    }
    
    open func httpMethod(parameters: ParameterType?) -> HTTPMethod {
        return .post
    }
    
    open func headers(parameters: ParameterType?) -> [String: String]? {
        return ProviderConfiguration.shared.headerFields
    }
    
    open func logEnabled(parameters: ParameterType?) -> Bool {
        return ProviderConfiguration.shared.logger.isLoggerEnabled
    }
    
    open func preprocessResponse(_ response: DataResponse<Any>) -> (success: Bool, value: Any?, error: Error?) {
        let value = response.value
        let error = response.error
        let success = error == nil
        return (success, value, error)
    }
    
    open func testResponseData(parameters: ParameterType?) -> ProviderResponseAny? {
        if let filePath = testResponseFile(parameters: parameters) {
            let keeper = ValueKeeper<ProviderResponseAny>(getValueAsync: { fullfill in
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
                    let text = try? String(contentsOfFile: filePath)
                    fullfill((true, text, nil))
                }
            })
            return keeper.syncValue
        } else {
            return nil
        }
    }
    
    open func testResponseFile(parameters: ParameterType?) -> String? {
        return nil
    }
    
    open func customRequest(_ request: Request) {
        if let customClosure = ProviderConfiguration.shared.customRequest {
            customClosure(request)
        }
        if let credential = ProviderConfiguration.shared.credential {
            request.authenticate(usingCredential: credential)
        }
    }
}

open class BaseTaskProvider<ParameterType>: BaseProvider<ParameterType> {
    public override init() {
        super.init()
    }
    
    open var trackingProgressEnabled: Bool {
        return true
    }
    
    open func buildFormData(multipart: MultipartFormData, with parameters: ParameterType?) {
    }
    
    open func cleanUp(parameters: ParameterType?) {
    }
    
    open func saveTemporary(parameters: ParameterType?) {
    }
}
