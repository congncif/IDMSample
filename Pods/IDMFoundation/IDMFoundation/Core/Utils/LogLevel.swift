//
//  LogLevel.swift
//  IDMFoundation
//
//  Created by FOLY on 3/14/18.
//

import Foundation

public class LogConfiguration {
    public enum LogLevel: String {
        case debug
        case none
    }

    public static var level: LogLevel = .debug
}

public func log(_ items: Any...) {
    switch LogConfiguration.level {
    case .none:
        break
    case .debug:
        print(items)
    }
}

func log(url: URL?, mark: String, data: Any?) {
    switch LogConfiguration.level {
    case .none:
        break
    case .debug:
        print("🚀🚀🚀")
        print(url ?? URL(fileURLWithPath: ""))

        print(mark + mark + mark)
        if let message = data as? [String: Any] {
            let output = message as NSDictionary
            print(output)
        } else {
            print(String(describing: data))
        }
    }
}
