//
//  LogLevel.swift
//  IDMFoundation
//
//  Created by FOLY on 3/14/18.
//

import Foundation

public enum LogLevel: String {
    case debug
    case none
}

public class LogConfiguration {
    public static var level: LogLevel = .debug
}

public func log(_ items: Any..., separator: String = " ", terminator: String = "❀") {
    switch LogConfiguration.level {
    case .none:
        break
    case .debug:
        print(items, separator: separator, terminator: terminator)
    }
}


