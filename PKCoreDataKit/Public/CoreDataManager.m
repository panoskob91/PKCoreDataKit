//
//  CoreDataManager.m
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import "CoreDataManager.h"
#import "PKPersistenceManager.h"

@interface CoreDataManager ()

@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readonly) NSURL *applicationDocumentsDirectory;

@end

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;

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

#pragma  mark - Provate Properties / functions

- (void)saveContext
{
    if ([self.managedObjectContext hasChanges]) {
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        if (error) {
            NSString *exeptionName = [NSString stringWithFormat:@"Unresolved error %@", error];
            [NSException raise:exeptionName format:@"Could not save changes"];
        }
    }
}

#pragma mark - Public Properties / Functions

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        PKPersistenceManager *persistenceManager = [PKPersistenceManager sharedInstance];
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        context.persistentStoreCoordinator = [persistenceManager persistentStoreCoordinatorFromCoreDataFileName:self.coreDataFileName];
        _managedObjectContext = context;
        return context;
    }

    return _managedObjectContext;
}

- (void)addItem:(nonnull NSManagedObject<UpdateableObjectProtocol> *)item
{
    [item updateData];
}

- (void)deleteAllItems:(nonnull NSString *)entityName
{
    NSArray *entries = [self fetchDataFromEntityWithName:entityName];
    for (NSManagedObject *item in entries) {
        [self.managedObjectContext deleteObject:item];
    }
}

- (void)deleteItem:(nonnull NSManagedObject *)item
{
    [self.managedObjectContext deleteObject:item];
}

- (void)editData
{
    //TODO: Implementation
}

- (NSArray * _Nullable )fetchDataFromEntityWithName:(nonnull NSString *)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSArray *entries;
    NSError *error = nil;
    entries = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Fetch request error %@", error);
    }

    return entries;
}

- (void)saveData
{
    [self saveContext];
}

@end
