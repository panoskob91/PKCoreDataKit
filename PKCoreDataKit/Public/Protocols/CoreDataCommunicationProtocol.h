//
//  CoreDataCommunicationProtocol.h
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PKUpdateableObjectProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CoreDataCommunicationProtocol <NSObject>

/**
Fetches data from the entity with the provided entity name.
 @param entityName The entity name
 @return Array of object stored on specified entity.
 */
- (NSArray * _Nullable)fetchDataFromEntityWithName:(NSString *)entityName;

/**
 Adds Item.

 @param item The object to be added.
 */
- (void)addItem:(NSManagedObject<PKUpdateableObjectProtocol> *)item;
/**
 Saves data to core data.
 */
- (void)saveData;

/**
 Deletes item from core data.

 @param item The object to be deleted.
 */
- (void)deleteItem:(NSManagedObject *)item;

/**
 Deletes all items inside an entity

 @param entityName The name of the entity
 */
- (void)deleteAllItemsFromEntityWithName:(NSString *)entityName;

@end

NS_ASSUME_NONNULL_END
