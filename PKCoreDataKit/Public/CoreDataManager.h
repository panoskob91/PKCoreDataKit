//
//  CoreDataManager.h
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataCommunicationProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A class for managing core data functionality
 */
@interface CoreDataManager : NSObject<CoreDataCommunicationProtocol>

/**
 The file name for the .xcdatammodeld
 */
@property (strong, nonatomic) NSString *coreDataFileName;

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

/**
 Designated initialzer.

 @param fileName The name of .xcdatammodeld file
 @return CoreDataManager instance.
 */
- (instancetype)initWithCoreDataFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
