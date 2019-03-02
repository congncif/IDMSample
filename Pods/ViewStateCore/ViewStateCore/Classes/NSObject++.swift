//
//  NSObject+Properties.swift
//  ViewStateCore
//
//  Created by NGUYEN CHI CONG on 2/13/19.
//

import Foundation

extension NSObject {
    //
    // Retrieves an array of property names found on the current object
    // using Objective-C runtime functions for introspection:
    // https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
    //
    public func propertyNames() -> Array<String> {
        var results: Array<String> = []
        
        var count: UInt32 = 0
        let myClass: AnyClass = self.classForCoder
        let properties = class_copyPropertyList(myClass, &count)
        
        for i in 0..<count {
            if let property = properties?[Int(i)] {
                let cname = property_getName(property)
                let name = String(cString: cname)
                results.append(name)
            }
        }
        
        free(properties)
        
        return results
    }
}
