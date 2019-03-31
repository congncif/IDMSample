//
//  Protocols.swift
//  ViewStateCore
//
//  Created by NGUYEN CHI CONG on 2/13/19.
//

import Foundation

public protocol ViewStateSubscriber {
    func viewStateDidChange(newState: ViewState)

    // Optionals

    // Useful to show animation
    func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?)

    // Listening subscribing
    func viewStateDidSubscribe(_ state: ViewState)
    func viewStateWillUnsubscribe(_ state: ViewState)
}

// Optional methods

extension ViewStateSubscriber {
    public func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?) {}

    public func viewStateDidSubscribe(_ state: ViewState) {}

    public func viewStateWillUnsubscribe(_ state: ViewState) {}
}

/**********************************************************************
 /// Use ViewStateFillable if you want listen changes of each of ViewState keys then fill into a target.

 => Best practices in this case is a flat ViewState with no nested ViewState.

 class MainState: ViewState {
    @objc dynamic var name: String = "[iF] Solution"
 }

 class Subscriber: NSObject, ViewStateFillable {
    var fillingOptions: [FillingOption] {
        let nameOption = FillingOption(keyPath: #keyPath(MainState.name), target: textLabel, fillingKeyPath: #keyPath(UITextField.text))
        return [nameOption]
    }
 }
 **********************************************************************/

/// Default Keys. You can add custom FillableKey by extend FillableKey struct.
/// Eg: extension FillableKey {
///         public static let customKey = "customKey"
///     }
public struct FillableKey {
    public static let title = "title"

    public static let isHidden = "isHidden"
    public static let isEnabled = "isEnabled"

    public static let text = "text"
    public static let attributedText = "attributedText"
    public static let placeholder = "placeholder"
    public static let attributedPlaceholder = "attributedPlaceholder"

    // UIButton
    public static let currentTitle = "currentTitle"
    public static let currentImage = "currentImage"
    public static let currentAttributedTitle = "currentAttributedTitle"

    public static let tintColor = "tintColor"
    public static let textColor = "textColor"
    public static let currentTitleColor = "currentTitleColor"

    public static let image = "image"
}

public struct FillingOption {
    public var keyPath: String
    public var action: (Any?) -> Void

    public init(keyPath: String, action: @escaping (Any?) -> Void) {
        self.keyPath = keyPath
        self.action = action
    }

    public init(keyPath: String, target: NSObject, targetKeyPath: String) {
        let _fillingValue: (Any?) -> Void = { [weak target] value in
            guard let _target = target else { return }
            if _target.propertyNames().contains(targetKeyPath) {
                _target.setValue(value, forKeyPath: targetKeyPath)
            } else {
                print("[ViewStateCore] The target \(_target) doesn't contain \(targetKeyPath) key")
            }
        }
        self.init(keyPath: keyPath, action: _fillingValue)
    }
}

public protocol ViewStateFillable: ViewStateSubscriber {
    func fillingOptions(_ state: ViewState) -> [FillingOption]
}

extension ViewStateFillable {
    public func viewStateDidChange(newState: ViewState) {}

    public func viewStateDidChange(newState: ViewState, keyPath: String, oldValue: Any?, newValue: Any?) {
        fill(value: newValue, of: newState, forKeyPath: keyPath)
    }

    public func viewStateDidSubscribe(_ state: ViewState) {
        let workingKeys = state.workingKeys
        for key in workingKeys {
            let value = state.value(forKeyPath: key)
            fill(value: value, of: state, forKeyPath: key)
        }
    }

    fileprivate func fill(value: Any?, of state: ViewState, forKeyPath keyPath: String) {
        let options = fillingOptions(state)
        let targets = options.filter { $0.keyPath == keyPath }
        for item in targets {
            item.action(value)
        }
    }
}

/**********************************************************************
 /// Use ViewStateRenderable if you want divide ViewState into multiples sections then listen changes of each separated section.

 => Best practices in this case is 2 level ViewState with one deep nested ViewState.

 - Delare ViewState:

 class MainViewState: ViewState {
    class QueryState: ViewState {
        @objc fileprivate(set) dynamic var query: String?
    }

    class SelectionState: ViewState {
        @objc fileprivate(set) dynamic var selectedUser: SearchUserModel?
    }

    @objc fileprivate(set) dynamic var queryState = QueryState()
    @objc fileprivate(set) dynamic var selectionState = SelectionState()
 }

 - Hanlde:

 public func render(state: ViewState) {
    if let state = state as? MainViewState.QueryState {
        searchField.text = state.query
        searchButton.isEnabled = !state.query.isNoValue
    }
    else if let state = state as? MainViewState.SelectionState {
        selectedUserLabel.text = state.selectedUser?.name
    }
 }
 **********************************************************************/

public protocol ViewStateRenderable: ViewStateSubscriber {
    func render(state: ViewState)
}

extension ViewStateRenderable {
    public func viewStateDidChange(newState: ViewState) {
        render(state: newState)
    }

    public func viewStateDidSubscribe(_ state: ViewState) {
        render(state: state)
    }
}
