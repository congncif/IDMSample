# You said UIStoryboard is disastrous, I say it is awesome.

When Apple introduced the Storyboard, everyone spent a ton of articles to "say hello" to it. When the excessive use makes it difficult to control, people spend tons of ink paper to "say goodbye" it.

I think Apple provides us a good tool, but turning it into an excellent tool or waste tool is the job of its users.

Many people have talked about the benefits and harms of using the Storyboard. Today I do not repeat those things, I will only talk about ways to turn the disadvantages of storyboard into good.

# Why are people afraid of the Storyboard?

## 1) Merge Conflict

Perhaps code conflicts are a headache for all teams but it is important that with xib files or storyboards once confused, it is often difficult to resolve. However, Apple has listened to this. These files are less confict. Currently, you can use separate storyboard files for each different screen so you can fully work on a separate storyboard file with others.

*Read more here*: https://medium.com/@stasost/xcode-a-better-way-to-deal-with-storyboards-8b6a8b504c06

## 2) Reusability

Storyboard does not enhance reuse. Normally for each module, layout is less reused. For small components on the reused interface many times, you can **use xib files or code programming** such as *UITableViewCell*, *UICollectionViewCell* or *CustomView*. Also you can embed **ContainerView** to custom view, it is able to resuse across between Storyboard files.

<img src="https://i.imgur.com/D5v5Pihm.png"/>

As for the layout design of the entire module it is made for each module and we don't want to reuse it for another module.

## 3) Custom ViewController inititializer to inject dependencies

*The example uses IDMFoundation Template, you can install this template here https://github.com/congncif/IDMFoundation*

When not using Dependency Injection, you may have difficulty with how to solve the problem of initializing dependencies especially with VIPER or using protocol oriented programing.
I have solved this problem with a Dependency Bridge which will initialize all dependencies in an NSObject with the Storyboard View Controller.
```swift
class SearchUserDependencyBridge: NSObject {
    var router: SearchUserRouterProtocol?
    var presenter: SearchUserPresenterProtocol!
    var integrator: SearchUserAbstractIntegrator!
}
```

```swift
class SearchUserBridge: SearchUserDependencyBridge {
    override init() {
        super.init()
        presenter = SearchUserPresenter()
        integrator = SearchUserIntegratorFactory.getIntegrator()
    }
}
```

In `SearchUserViewController`, declare a connectable bridge: `@IBOutlet var bridge: SearchUserDependencyBridge!`
Drag an object into Storyboard, set custom class to SearchUserBridge. Then connect it to property of `SearchUserViewController`.

Once done, you have made Storyboard to become a Builder.

<img src="https://i.imgur.com/sK19DTnl.png"/>

## 4) Coupled view controllers

The navigation in the ios application makes ViewController confusing, because it needs to know about other view controllers it wants to navigate to. This makes the viewControllers hooked together rigidly.
Therefore, VIPER has defined an object called Router / Wireframe to replace ViewController's task. For architectures that do not define a router like MVC, MVP or MVVM, this problem remains unresolved. Therefore, many experts have defined an additional object called Coordinator.

*Read more:* https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started

Storyboard has UIStoryboardSegue to make navigation more magical but most people don't like to use it because with normal usage everything is still tied together. 

Basically navigation is done by view controller containers, Routers or Coordinators do nothing other than call these containers instead of having to call directly inside ViewController.
This responsibility can be fully realized by UIStoryboardSegue. so we may not need to add an object like the Router anymore. By the power of the Storyboard.
Here is detail:

```swift
protocol SearchUserOutputProtocol {
    func userDidSelect(_ user: SearchUserModel)
}
```

```swift
public protocol MainInputProtocol {
    func selectUser(_ user: SearchUserModel)
}
```

```swift
class SearchUserSegue: UIStoryboardSegue, SearchUserOutputProtocol {
    func userDidSelect(_ user: SearchUserModel) {
        target?.selectUser(user)
    }
    
    var target: MainInputProtocol? {
        return destination as? MainInputProtocol
    }
}
```
Once done. Then we use `UIStoryboardReference` and custom Segue class to connect everything.

<img src="https://i.imgur.com/38rHA8Kl.png"/>


