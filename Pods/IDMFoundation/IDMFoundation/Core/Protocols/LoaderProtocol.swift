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
public protocol IDMPresentationDelegate: AnyObject, LoadingProtocol, ErrorHandlingProtocol {}
