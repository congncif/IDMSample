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
public protocol LoadingMonitorProtocol: LoaderProtocol, ErrorHandlerProtocol {}
public protocol ProgressTrackerProtocol: AnyObject, ProgressLoadingProtocol {}

extension IntegrationCall {
    public func setLoader(_ loader: LoaderProtocol?) -> Self {
        onBeginning { [weak loader] in
            loader?.beginLoading()
        }
        
        onCompletion { [weak loader] in
            loader?.finishLoading()
        }
        
        return self
    }
    
    public func setErrorHandler(_ handler: ErrorHandlerProtocol?) -> Self {
        onError { [weak handler] err in
            handler?.handle(error: err)
        }
        
        return self
    }
    
    public func setLoadingMonitor(_ monitor: LoadingMonitorProtocol?) -> Self {
        setLoader(monitor).setErrorHandler(monitor)
        return self
    }
}

extension IntegrationCall where ModelType: ProgressModelProtocol {
    public func setProgressTracker(_ tracker: ProgressTrackerProtocol?) -> Self {
        onBeginning { [weak tracker] in
            tracker?.beginProgressLoading()
        }
        
        onCompletion { [weak tracker] in
            tracker?.finishProgressLoading()
        }
        
        onProgress { [weak tracker] model in
            tracker?.loadingDidUpdateProgress(model?.progress)
        }
        return self
    }
}
