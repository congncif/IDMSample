# IDMFoundation

[![CI Status](http://img.shields.io/travis/congncif/IDMFoundation.svg?style=flat)](https://travis-ci.org/congncif/IDMFoundation)
[![Version](https://img.shields.io/cocoapods/v/IDMFoundation.svg?style=flat)](http://cocoapods.org/pods/IDMFoundation)
[![License](https://img.shields.io/cocoapods/l/IDMFoundation.svg?style=flat)](http://cocoapods.org/pods/IDMFoundation)
[![Platform](https://img.shields.io/cocoapods/p/IDMFoundation.svg?style=flat)](http://cocoapods.org/pods/IDMFoundation)

## Summary

**IDMFoundation** is a collection of what is needed to create a popular ios application that uses web services.

As part of the base project, **IDMFoundation** includes the foundation classes built into the **IDMVC** architecture (read more here https://github.com/congncif/IDMCore) and a standard error handling and loading mechanism. **IDMFoundation** is divided into several sub-specs, which means that it is designed quite flexibly, you can choose which really needed sub-spec to install for your project to not become redundant.

## Components

- **Core**: includes base classes of `Data Provider`.
  + `ConvertProvider`, `ForwardProvider` or `BridgeResponseProvider` are support providers. They help to create a sequence provider by connecting some providers together.
  
  To install it, simply add the following line to your Podfile: 
  ```ruby
  pod 'IDMFoundation/Core'
  ```
- **Alamofire**: Use `Alamofire` to request data.
  + `BaseDataProvider` handles data request.
  + `BaseUploadProvider` handles upload request.
  + `BaseDownloadProvider` handles download request.
  
  To install it, simply add the following line to your Podfile: 
  ```ruby
  pod 'IDMFoundation/Alamofire'
  ```
  
- **Parameter**:Encode request parameters for `Data Provider`:

To install it, simply add the following line to your Podfile: 
  ```ruby
  pod 'IDMFoundation/RequestParameter'
  ```
  
- **Data Mapping**: Most of apps use JSON API, so *ObjectMapper* is an integral part. We built some base models to parse JSON data to custom object which is more useful for real projects.

 To install it, simply add the following line to your Podfile: 
  ```ruby
  pod 'IDMFoundation/ObjectMapper'
  ```
  
- **Loading**: includes methods to handle loading, loading progress and presenting error. These methods are added to `UIView` and `UIViewController` by default. This help us use easily.

There are two sub-specs for *Loading*, you can choose one of them for your project:
```ruby
pod 'IDMFoundation/JGProgressHUD'
```

or

```ruby
pod 'IDMFoundation/MBProgressHUD'
```
- Some other sub-specs you can look into:
  + ```pod 'IDMFoundation/Reachability'```
  + ```pod 'IDMFoundation/CameraAsset'```
  

## Requirements

Xcode 9.3+

Swift 4.1+

## [Bonus] Template

**IDMFoundation** provides a template to help quicly create a data flow which follows **IDMCore**.

To install template, clone this repo then go to the project directory, run command `./install-template.sh`.

Once that's done, when you create a new file, you'll see IDMFoundation template appears.

![alt text](https://i.imgur.com/6b7euWy.png "IDM Template")

Create one with name of flow `GetData`, all of necessary classes will be created.

```swift
import Foundation
import IDMCore
import IDMFoundation
import Alamofire

class GetDataRequestParameter: RequestParameter {
    
}

class GetDataResponseModel: DataResponseModel<<#GetDataModel#>>, ModelProtocol {
    
}

typealias GetDataBaseProvider = RootAnyProvider<GetDataRequestParameter>
typealias GetDataProvider = BaseDataProvider<GetDataRequestParameter>

class GetDataDataProvider: GetDataProvider {
    override func requestPath(parameters: GetDataRequestParameter?) -> String {
        return <#code#>
    }

    override func httpMethod(parameters: GetDataRequestParameter?) -> HTTPMethod {
        return <#.post#>
    }
}

class GetDataService: MagicalIntegrator<GetDataBaseProvider, GetDataResponseModel> {
    
}

extension GetDataService {
	convenience init() {
        self.init(dataProvider: GetDataDataProvider())
    }
}
```

Enter your configurations then you have been finished a new flow completely.

Use easily in view controller or wherever you need a service to get data:

```swift
fileprivate let getDataService = GetDataService()

[...]

getDataService
            .prepareCall(parameters: param)
            .loading(monitor: self)
            .error(handler: self)
            .onSuccess { responseModel in
                print(responseModel)
            }
            .call()

```

*Happy coding!*

## Author

congncif, congnc.if@gmail.com

## License

IDMFoundation is available under the MIT license. See the LICENSE file for more info.
