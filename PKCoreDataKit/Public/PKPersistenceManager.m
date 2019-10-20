//
//  PKPersistenceManager.m
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import "PKPersistenceManager.h"

@implementation PKPersistenceManager

+ (instancetype)sharedInstance
{
    static PKPersistenceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PKPersistenceManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory {
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSSearchPathDirectory documentDirectory = NSDocumentDirectory;
    NSSearchPathDomainMask domainMask = NSUserDomainMask;
    NSArray<NSURL *> *urls = [defaultFileManager URLsForDirectory:documentDirectory inDomains:domainMask];
    return urls[urls.count - 1];
}

- (NSManagedObjectModel *)managedObjectModelForCoreDataFileName:(NSString *)fileName
{
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
}

- (NSPersistentContainer *)persistentContainerForCoreDataFileName:(NSString *)fileName
{
    NSPersistentContainer *container = [[NSPersistentContainer alloc] initWithName:fileName];
    [container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull storeDesc, NSError * _Nullable error) {
        if (error) {
            NSString *exeptionName = [NSString stringWithFormat:@"Unresolved error %@", error];
            [NSException raise:exeptionName format:@"Could not find percistent container"];
        }
    }];
    return container;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorFromCoreDataFileName:(NSString *)fileName
{
    NSManagedObjectModel *managedObjectModel = [self managedObjectModelForCoreDataFileName:fileName];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]
                                                 initWithManagedObjectModel:managedObjectModel];
    NSString *pathComponent = [NSString stringWithFormat:@"%@.sqlite", fileName];
    NSURL *url = [self.applicationDocumentsDirectory URLByAppendingPathComponent:pathComponent];
    NSError *error = nil;
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:url
                                    options:nil
                                      error:&error];
    if (error) {
        NSLog(@"An error occured: %@", error);
        abort();
    }
    
    return coordinator;
}

@end
