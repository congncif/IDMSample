//
//  LoaderProtocol.swift
//  IDMFoundation
//
//  Created by FOLY on 11/7/18.
//

import Foundation
import IDMCore

public protocol LoaderProtocol: AnyObject, LoadingProtocol {}
public protocol ErrorHandlerProtocol: AnyObject, ErrorHandlingProtocol {}
public protocol DisplayHandlerProtocol: LoaderProtocol, ErrorHandlerProtocol {}

extension IntegrationCall {
    @discardableResult
    public func loadingHandler(_ hanlder: LoaderProtocol) -> Self {
        onBeginning { [weak hanlder] in
            hanlder?.beginLoading()
        }
        
        onCompletion { [weak hanlder] in
            hanlder?.finishLoading()
        }
        
        return self
    }
    
    @discardableResult
    public func errorHandler(_ handler: ErrorHandlerProtocol) -> Self {
        onError { [weak handler] err in
            handler?.handle(error: err)
        }
        
        return self
    }
    
    @discardableResult
    public func display(on handler: DisplayHandlerProtocol) -> Self {
        loadingHandler(handler).errorHandler(handler)
        return self
    }
}
