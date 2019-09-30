# BitQuotation
#### A simple app to display visualization on bitcoin quotation.
---

## Installation and requirements

You will need [CocoaPods](https://cocoapods.org/) and [Xcode](https://developer.apple.com/xcode/) installed on your machine to retrieve and build the libraries used on this project, followed by these steps:

```bash
git clone https://github.com/alexandrehcdc/BitQuotation
cd BitQuotation
pod install
open BitQuotation.xcworkspace/
```

The credentials might need a change for running the project.

## Architecture

The project is mainly inspired by MVP, with minor touchs of others architectures. 
- Screen (View) and environments related are segmented in modules
- Common folder contains every structure, component and methods applied to the project
- Local and Model contains the attributes and the methods that persists to the database and displays data to the application (works online and offline) 

## Tools and libraries used
* [Realm](https://github.com/realm/realm-cocoa): Local object-oriented database
* [Charts](https://github.com/danielgindi/Charts): iOS charts and data components for graph visualization