//
//  ViewState.swift
//  ViewStateCore
//
//  Created by NGUYEN CHI CONG on 1/17/18.
//  Copyright © 2018 NGUYEN CHI CONG. All rights reserved.
//

import Foundation

public typealias ViewStateSubscriberObject = ViewStateSubscriber & AnyObject

private struct Subscriber: Equatable {
    var id: String
    var target: ViewStateSubscriber? {
        if let _target = _retainTarget {
            return _target
        }
        return _weakTarget
    }
    
    init(target: ViewStateSubscriberObject, retain: Bool) {
        self.id = String(describing: target)
        if retain {
            _retainTarget = target
        } else {
            _weakTarget = target
        }
    }
    
    init(target: ViewStateSubscriber) {
        self.id = String(describing: target)
        _retainTarget = target
    }
    
    private weak var _weakTarget: ViewStateSubscriberObject?
    private var _retainTarget: ViewStateSubscriber?
    
    static func == (lhs: Subscriber, rhs: Subscriber) -> Bool {
        return lhs.id == rhs.id
    }
}

open class ViewState: NSObject, ViewStateSubscriber {
    enum IgnoreKey: String, CaseIterable {
        case subscribers
        case delegate
        case _delegate
    }
    
    private var subscribers: [Subscriber] = []
    public weak var delegate: ViewStateSubscriberObject? {
        get {
            return _delegate
        }
        
        set {
            if newValue == nil {
                _delegate?.viewStateWillUnsubscribe(self)
            }
            _delegate = newValue
            
            if let value = newValue {
                notifyviewStateDidSubscribe(to: value)
            }
        }
    }
    
    fileprivate weak var _delegate: ViewStateSubscriberObject?
    
    open var ignoreKeys: [String] {
        return []
    }
    
    open var allowedKeys: [String] {
        return []
    }
    
    public override init() {
        super.init()
        addObservers()
    }
    
    open func addObservers() {
        for key in workingKeys {
            addObserver(self, forKeyPath: key, options: [.old, .new], context: nil)
            
            if let subState = self.value(forKey: key) as? ViewState {
                subState.delegate = self
            }
        }
    }
    
    open func removeObservers() {
        for key in workingKeys {
            removeObserver(self, forKeyPath: key)
        }
    }
    
    public func register(subscriberObject: ViewStateSubscriberObject, retain: Bool = false) {
        let _subscriber = Subscriber(target: subscriberObject, retain: retain)
        
        if !subscribers.contains(_subscriber) {
            subscribers.append(_subscriber)
            
            if let target = _subscriber.target {
                notifyviewStateDidSubscribe(to: target)
            }
        }
    }
    
    public func register(subscriber: ViewStateSubscriber) {
        let _subscriber = Subscriber(target: subscriber)
        
        if !subscribers.contains(_subscriber) {
            subscribers.append(_subscriber)
            
            if let target = _subscriber.target {
                notifyviewStateDidSubscribe(to: target)
            }
        }
    }
    
    public func unregister(subscriber: ViewStateSubscriber) {
        let id = String(describing: subscriber)
        if let index = subscribers.firstIndex(where: { (scrb) -> Bool in
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
        guard let key = keyPath, workingKeys.contains(key) else { return }
        
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
}

fileprivate extension ViewState {
    func key(for value: ViewState) -> String? {
        for aKey in workingKeys {
            if let val = self.value(forKeyPath: aKey) as? ViewState, val == value {
                return aKey
            }
        }
        return nil
    }
    
    var allIgnoreKeys: [String] {
        return ignoreKeys + IgnoreKey.allCases.map { $0.rawValue }
    }
    
    var keys: [String] {
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
}

internal extension ViewState {
    var workingKeys: [String] {
        var workingKeys = keys
        if allowedKeys.count > 0 {
            workingKeys = allowedKeys
        }
        let igKeys = allIgnoreKeys
        workingKeys = workingKeys.filter { !igKeys.contains($0) }
        
        return workingKeys
    }
    
    var children: [ViewState] {
        return workingKeys.compactMap { [weak self] (key) -> ViewState? in
            if let val = self?.value(forKeyPath: key) as? ViewState {
                return val
            }
            return nil
        }
    }
    
    var deepStates: [ViewState] {
        let _children = children
        if _children.count > 0 {
            return _children.reduce([self], { (result, child) -> [ViewState] in
                result + child.deepStates
            })
        } else {
            return [self]
        }
    }
    
    func notifyviewStateDidSubscribe(to subscriber: ViewStateSubscriber) {
        let allStates = deepStates
        allStates.forEach { currentState in
            subscriber.viewStateDidSubscribe(currentState)
        }
    }
}
