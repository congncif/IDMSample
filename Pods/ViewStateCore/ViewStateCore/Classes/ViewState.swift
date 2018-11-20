//
//  ViewState.swift
//  ViewStateCore
//
//  Created by NGUYEN CHI CONG on 1/17/18.
//  Copyright © 2018 NGUYEN CHI CONG. All rights reserved.
//

import Foundation

public struct Subscriber: Equatable {
    var id: String
    var target: (() -> ViewStateSubscriber?)?
    
    public static func == (lhs: Subscriber, rhs: Subscriber) -> Bool {
        return lhs.id == rhs.id
    }
}

public protocol ViewStateRenderable {
    func render(state: ViewState)
}

public protocol ViewStateSubscriber: NSObjectProtocol {
    func viewStateDidChange(newState: ViewState)
    func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?)
    func viewStateDidSubscribed(state: ViewState)
    func viewStateWillUnsubscribed(state: ViewState)
}

public extension ViewStateSubscriber {
    public func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?) {
        // default
    }
    
    public func viewStateDidSubscribed(state: ViewState) {
        // default
    }
    
    public func viewStateWillUnsubscribed(state: ViewState) {
        // default
    }
}

public extension ViewStateSubscriber where Self: ViewStateRenderable {
    public func viewStateDidChange(newState: ViewState) {
        render(state: newState)
    }
    
    public func viewStateDidSubscribed(state: ViewState) {
        render(state: state)
    }
}

fileprivate let kSubscribers = "subscribers"
fileprivate let kDelegate = "delegate"
fileprivate let kPrivateDelegate = "_delegate"

open class ViewState: NSObject, ViewStateSubscriber {
    public private(set) var subscribers: [Subscriber] = []
    public weak var delegate: ViewStateSubscriber? {
        get {
            return _delegate
        }
        
        set {
            if newValue == nil {
                _delegate?.viewStateWillUnsubscribed(state: self)
            }
            _delegate = newValue
            
            if let value = newValue {
                value.viewStateDidSubscribed(state: self)
            }
        }
    }
    
    fileprivate weak var _delegate: ViewStateSubscriber?
    
    public var keys: [String] {
        var results = [String]()
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            if let key = child.label {
                results.append(key)
            }
        }
        
        var mirror: Mirror = otherSelf
        
        while let superMirror = mirror.superclassMirror {
            for child in superMirror.children {
                if let key = child.label {
                    results.append(key)
                }
            }
            mirror = superMirror
        }
        
        return results
    }
    
    open var ignoreKeys: [String] {
        return [kSubscribers, kDelegate, kPrivateDelegate]
    }
    
    open var allowedKeys: [String] {
        return []
    }
    
    private var workingKeys: [String] {
        var workingKeys = keys
        if allowedKeys.count > 0 {
            workingKeys = allowedKeys
        }
        return workingKeys
    }
    
    public override init() {
        super.init()
        addObservers()
    }
    
    open func addObservers() {
        for key in workingKeys {
            guard !ignoreKeys.contains(key) else { continue }
            addObserver(self, forKeyPath: key, options: [.old, .new], context: nil)
            
            if let subState = self.value(forKey: key) as? ViewState {
                subState.delegate = self
            }
        }
    }
    
    open func removeObservers() {
        for key in workingKeys {
            guard !ignoreKeys.contains(key) else { continue }
            removeObserver(self, forKeyPath: key)
        }
    }
    
    public func subscribe<S>(for object: S) where S: NSObject, S: ViewStateSubscriber {
        let id = String(describing: object)
        let target = { [weak object] in
            object
        }
        let subscriber = Subscriber(id: id, target: target)
        
        if !subscribers.contains(subscriber) {
            subscribers.append(subscriber)
            
            let target = subscriber.target?()
            target?.viewStateDidSubscribed(state: self)
        }
    }
    
    public func unsubscribe<S>(for object: S) where S: NSObject, S: ViewStateSubscriber {
        let id = String(describing: object)
        if let index = subscribers.index(where: { (scrb) -> Bool in
            scrb.id == id
        }) {
            let subscriber = subscribers[index]
            let target = subscriber.target?()
            target?.viewStateWillUnsubscribed(state: self)
            
            subscribers.remove(at: index)
        }
    }
    
    deinit {
        subscribers.removeAll()
        removeObservers()
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath, !ignoreKeys.contains(key) else { return }
        
        notifyStateDidChange(newState: self)
        
        let oldValue = change?[NSKeyValueChangeKey.oldKey]
        let newValue = change?[NSKeyValueChangeKey.newKey]
        if let value = newValue as? ViewState {
            value.delegate = self
        }
        notifyStateDidChange(newState: self, keyPath: key, oldValue: oldValue, newValue: newValue)
    }
    
    public func notifyStateDidChange(newState: ViewState? = nil) {
        let state = newState ?? self
        delegate?.viewStateDidChange(newState: state)
        
        for scrb in subscribers {
            let target = scrb.target?()
            target?.viewStateDidChange(newState: state)
        }
    }
    
    public func notifyStateDidChange(newState: ViewState? = nil, keyPath: String, oldValue: Any?, newValue: Any?) {
        let state = newState ?? self
        
        delegate?.viewStateDidChange(newState: state, keyPath: keyPath, oldValue: oldValue, newValue: newValue)
        
        for scrb in subscribers {
            let target = scrb.target?()
            target?.viewStateDidChange(newState: state, keyPath: keyPath, oldValue: oldValue, newValue: newValue)
        }
    }
    
    public func viewStateDidChange(newState: ViewState) {
        notifyStateDidChange(newState: newState)
    }
    
    public func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?) {
        notifyStateDidChange(newState: newState, keyPath: keyPath, oldValue: oldValue, newValue: newValue)
    }
    
    fileprivate func key(for value: ViewState) -> String? {
        for aKey in workingKeys {
            if let val = self.value(forKeyPath: aKey) as? ViewState, val == value {
                return aKey
            }
        }
        return nil
    }
}
