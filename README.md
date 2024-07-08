# SwiftIdentifier

A lightweight library that helps to define ID types.

## Requirements

- Swift 5.9+

## Features

### What problems does SwiftIdentifier solve?

Suppose you have `User` and `Book` types, each of which has an ID of type `Int`:

```swift
struct User {
    let id: Int
}

struct Book {
    let id: Int
}
```

and have a `userIDHandler` closure:

```swift
let userIDHandler: (Int) -> Void = { ... }
```

There are two main problems here.

- `userIDHandler` accepts a Book ID, leading to silent bugs.
- The argument type of `userIDHandler` does not fully convey intent.

### Solution with SwiftIdentifier

You can easily define **different ID types for each type**!

```swift
struct User {
    typealias ID = Identifier<Self, Int>
    let id: ID
}
struct Book {
    typealias ID = Identifier<Self, Int>
    let id: ID
}

let user = User(id: 10)
let book = Book(id: 500)

// The argument type become clearer!
let userIDHandler: (User.ID) -> Void = { ... }

userIDHandler(user.id) // OK
userIDHandler(book.id) // Compile error!
```

### Other features

- You can collaborate nicely with `Codable`.
  
  ```swift
  struct User: Codable {
      typealias ID = Identifier<Self, Int>
      let id: ID
      let name: String
  }
  
  // Compatible JSON
  """
  {
      "id": 100,
      "name": "John"
  }
  """
  ```

## Using SwiftIdentifier in your project

To use the `SwiftIdentifier` library in a SwiftPM project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/jrsaruo/SwiftIdentifier", from: "1.1.1"),
```

and add `SwiftIdentifier` as a dependency for your target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "SwiftIdentifier", package: "SwiftIdentifier"),
    // other dependencies
]),
```

Finally, add `import SwiftIdentifier` in your source code.
