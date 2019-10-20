//
//  CoreDataManager.m
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readonly) NSURL *applicationDocumentsDirectory;

@end

@implementation CoreDataManager

#pragma mark - Initializers

- (instancetype)initWithCoreDataFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        self.coreDataFileName = fileName;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.coreDataFileName = @"";
    }
    return self;
}

#pragma  mark - Provate Properties

- (NSURL *)applicationDocumentsDirectory {
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSSearchPathDirectory documentDirectory = NSDocumentDirectory;
    NSSearchPathDomainMask domainMask = NSUserDomainMask;
    NSArray<NSURL *> *urls = [defaultFileManager URLsForDirectory:documentDirectory inDomains:domainMask];
    return urls[urls.count - 1];
}

- (NSManagedObjectModel *)managedObjectModel {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:self.coreDataFileName withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
}

- (NSPersistentContainer *)persistentContainer {
    NSPersistentContainer *container = [[NSPersistentContainer alloc] initWithName:self.coreDataFileName];
    [container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull storeDesc, NSError * _Nullable error) {
        if (error) {
            NSString *exeptionName = [NSString stringWithFormat:@"Unresolved error %@", error];
            [NSException raise:exeptionName format:@"Could not find percistent container"];
        }
    }];
    return container;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *pathComponent = [NSString stringWithFormat:@"%@.sqlite", self.coreDataFileName];
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

#pragma mark - Public Properties

//Lazy
- (NSManagedObjectContext *)mangedObjectContext {
    if (!_managedObjectContext) {
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        context.persistentStoreCoordinator = self.persistentStoreCoordinator;
        return context;
    }

    return _managedObjectContext;
}



@end
