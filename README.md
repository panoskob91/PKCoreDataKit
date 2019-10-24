# PKCoreDataKit 
A framework for managing Core Data's functionality.

## Getting Started


## Usage

The central class is the PKCoreDataManager. To manage core data functions an instance of an PKContentManager should be created. The initializer initWithCoreDataFileName should be used. The fileName passed is the name of the .xcdatamodeld file.

```
let coreDataManager = CoreDataManager(fileName: "<file name>")
```

All available core data manager functions are defined into "PKCoreDataCommunicationProtocol" protocol.

## Licence

**MIT**
