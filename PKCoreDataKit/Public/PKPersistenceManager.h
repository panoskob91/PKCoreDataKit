//
//  PKPersistenceManager.h
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PKPersistenceManager : NSObject

+ (instancetype)sharedInstance;

//- (NSManagedObjectModel *)managedObjectModelForCoreDataFileName:(NSString *)fileName;
//- (NSPersistentContainer *)persistentContainerForCoreDataFileName:(NSString *)fileName;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorFromCoreDataFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
