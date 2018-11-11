# GistViewer

### Instalation

Dependencies in this project are provided via Cocoapods. Please install all dependecies with

`
pod install
`

## High level overview

#### Domain 

The `Domain` is basically what the App about and what it can do (Entities, UseCase etc.) **It does not depend on UIKit or any persistence framework**, and it doesn't have implementations apart from entities.

#### Platform

The `Platform` is a concrete implementation of the `Domain` in a specific platform like iOS. It does hide all implementation details. For example Database implementation, in this case Realm.

#### Application

`Application` is responsible for delivering information to the user and handling user input. This is the place for your `UIView`s and `UIViewController`s.  `ViewControllers` are completely independent of the `Platform`.  The only responsibility of a view controller is to "bind" the UI to the Domain to make things happen.


## Detail overview
 
To enforce modularity, `Domain`, `Platform` and `Application` are separate targets in the App, which allows us to take advantage of the `internal` access layer in Swift to prevent exposing of types that we don't want to expose.

#### Domain

Entities are implemented as Swift value types

```swift
public struct User: Codable {
    var id: String
    var username: String
    var avatarUrl: String
}
```

UseCases are protocols which do one specific thing:

```swift

public protocol GistsUseCase {
    func gists() -> Observable<[Gist]>
    func gist(id: String) -> Observable<Gist>
}

```

`UseCaseProvider` is a [service locator](https://en.wikipedia.org/wiki/Service_locator_pattern).  In the current example, it helps to hide the concrete implementation of use cases.

#### Platform

In some cases, we can't use Swift structs for our domain objects because of DB framework requirements (e.g. Realm). 

The `Platform` also contains concrete implementations of your use cases, repositories or any services that are defined in the `Domain`.

As you can see, concrete implementations are internal, because we don't want to expose our dependecies. The only thing that is exposed in the current example from the `Platform` is a concrete implementation of the `UseCaseProvider`.


#### Application

In the current example, `Application` is implemented with the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern and heavy use of [RxSwift](https://github.com/ReactiveX/RxSwift), which makes binding very easy.


The `ViewModel` performs pure transformation of a user `Input` to the `Output`.

A `ViewModel` can be injected into a `ViewController` via property injection or initializer. In the current example, this is done by `Navigator`.
