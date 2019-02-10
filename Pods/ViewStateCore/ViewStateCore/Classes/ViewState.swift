//
//  ViewState.swift
//  ViewStateCore
//
//  Created by NGUYEN CHI CONG on 1/17/18.
//  Copyright © 2018 NGUYEN CHI CONG. All rights reserved.
//

import Foundation

public struct Subscriber: Equatable {
    public var id: String
    public weak var target: ViewStateSubscriber?
    
    public static func == (lhs: Subscriber, rhs: Subscriber) -> Bool {
        return lhs.id == rhs.id
    }
}

public protocol ViewStateRenderable: ViewStateSubscriber {
    func render(state: ViewState)
}

public protocol ViewStateSubscriber: AnyObject {
    func viewStateDidChange(newState: ViewState)
    
    // Optional
    
    // Useful to show animation
    func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?)
    
    // Subscribing
    func subscribeStateChange(_ state: ViewState)
    func unsubscribeStateChange(_ state: ViewState)
    
    // Listening subscribing
    func viewStateDidSubscribe(_ state: ViewState)
    func viewStateWillUnsubscribe(_ state: ViewState)
}

extension ViewStateSubscriber {
    public func subscribeStateChange(_ state: ViewState) {
        state.register(subscriber: self)
    }
    
    public func unsubscribeStateChange(_ state: ViewState) {
        state.unregister(subscriber: self)
    }
}

public extension ViewStateSubscriber {
    public func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?) {
        // default do nothing
    }
    
    public func viewStateDidSubscribe(_ state: ViewState) {
        // default do nothing
    }
    
    public func viewStateWillUnsubscribe(_ state: ViewState) {
        // default do nothing
    }
}

public extension ViewStateRenderable {
    public func viewStateDidChange(newState: ViewState) {
        render(state: newState)
    }
    
    public func viewStateDidSubscribe(_ state: ViewState) {
        render(state: state)
    }
}

open class ViewState: NSObject, ViewStateSubscriber {
    enum IgnoreKey: String, CaseIterable {
        case subscribers
        case delegate
        case _delegate
    }
    
    public private(set) var subscribers: [Subscriber] = []
    public weak var delegate: ViewStateSubscriber? {
        get {
            return _delegate
        }
        
        set {
            if newValue == nil {
                _delegate?.viewStateWillUnsubscribe(self)
            }
            _delegate = newValue
            
            if let value = newValue {
                value.viewStateDidSubscribe(self)
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
        return IgnoreKey.allCases.map { $0.rawValue }
    }
    
    open var allowedKeys: [String] {
        return []
    }
    
    fileprivate var workingKeys: [String] {
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
    
    public func register(subscriber: ViewStateSubscriber) {
        let id = String(describing: subscriber)
        let _subscriber = Subscriber(id: id, target: subscriber)
        
        if !subscribers.contains(_subscriber) {
            subscribers.append(_subscriber)
            
            let target = _subscriber.target
            target?.viewStateDidSubscribe(self)
        }
    }
    
    public func unregister(subscriber: ViewStateSubscriber) {
        let id = String(describing: subscriber)
        if let index = subscribers.index(where: { (scrb) -> Bool in
            scrb.id == id
        }) {
            let _subscriber = subscribers[index]
            let target = _subscriber.target
            target?.viewStateWillUnsubscribe(self)
            
            subscribers.remove(at: index)
        }
    }
    
    deinit {
        subscribers.removeAll()
        removeObservers()
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath, !ignoreKeys.contains(key) else { return }
        
        let oldValue = change?[NSKeyValueChangeKey.oldKey]
        let newValue = change?[NSKeyValueChangeKey.newKey]
        
        // trick to forward signal from substate
        if let value = newValue as? ViewState {
            value.delegate = self
        }
        
        notifyStateDidChange(newState: self)
        notifyStateDidChange(newState: self, keyPath: key, oldValue: oldValue, newValue: newValue)
    }
    
    @objc open func notifyStateDidChange(newState: ViewState? = nil) {
        let state = newState ?? self
        delegate?.viewStateDidChange(newState: state)
        
        for scrb in subscribers {
            let target = scrb.target
            target?.viewStateDidChange(newState: state)
        }
    }
    
    @objc open func notifyStateDidChange(newState: ViewState? = nil, keyPath: String, oldValue: Any?, newValue: Any?) {
        let state = newState ?? self
        
        delegate?.viewStateDidChange(newState: state, keyPath: keyPath, oldValue: oldValue, newValue: newValue)
        
        for scrb in subscribers {
            let target = scrb.target
            target?.viewStateDidChange(newState: state, keyPath: keyPath, oldValue: oldValue, newValue: newValue)
        }
    }
    
    // Use to forward signal form substate
    
    @objc open func viewStateDidChange(newState: ViewState) {
        notifyStateDidChange(newState: newState)
    }
    
    @objc open func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?) {
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
