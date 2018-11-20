# ViewStateCore

[![CI Status](http://img.shields.io/travis/congncif/ViewStateCore.svg?style=flat)](https://travis-ci.org/congncif/ViewStateCore)
[![Version](https://img.shields.io/cocoapods/v/ViewStateCore.svg?style=flat)](http://cocoapods.org/pods/ViewStateCore)
[![License](https://img.shields.io/cocoapods/l/ViewStateCore.svg?style=flat)](http://cocoapods.org/pods/ViewStateCore)
[![Platform](https://img.shields.io/cocoapods/p/ViewStateCore.svg?style=flat)](http://cocoapods.org/pods/ViewStateCore)

## An issue with View Controller

In every proposed model, whether MVC, MVVM, or VIPER, we always face a problem. Our view controller is becoming more and more troublesome. Having to store too much information such as outlets, referenced objects, display data, user preferences, temporary variables, and so on has become increasingly confusing, especially is when the logic starts to become complicated. One solution would be to create an object that stores the above information in place of the view controller and notifies the view controller whenever something changes to refresh the view if needed. It is called `View State`.

## How it works

**View State** solves two main tasks:
- Eliminate fragmentation in the view controller by grouping them into a certain VS
- Provides an update mechanism whenever data changes

This is within the goals of Clean MVC, which is to reduce the massive view controller, resolve the mess view controller, and be the final piece of unidirectional data flow.

**View State** is based on the KVO mechanism, all properties of VS are related to Objective C. When a **View State** property changes, it sends a notification to every object that subscribes to it.
**View State** supports multiple levels meaning that a **View State** can contain multiple sub-View States within it. A best practice is that we only have 2 levels of **View State**.

## Usage

```swift
class MovieListState: ViewState {
    @objc dynamic var movies: [MovieModel] = []
}

class FilterViewState: ViewState {
    @objc dynamic var selectedCategory: String = "Love"
}

class AExampleState: ViewState {
    @objc dynamic var movies: MovieListState = MovieListState()
    @objc dynamic var search: FilterViewState = FilterViewState()
}

class ViewController: ..., ViewStateSubscriber {
    var state = AExampleState()
    
    ...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state.subscribe(for: self)
    }
    
    func viewStateDidChange(newState: ViewState) {
        if let _ = newState as? MovieListState {
            // refresh views
        } else if let _ = newState as? FilterViewState {
            // reload data
        } else {
            // refreshState()
        }
    }
}
```

## Requirements

- Xcode 8.3+
- Swift 3+

## Installation

ViewStateCore is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ViewStateCore'
```

## Author

congncif, congnc.if@gmail.com

## License

ViewStateCore is available under the MIT license. See the LICENSE file for more info.
