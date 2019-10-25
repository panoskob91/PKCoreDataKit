//
//  IdentifiableProtocol.h
//  PKCoreDataKit
//
//  Created by Panagiotis  Kompotis  on 20/10/19.
//  Copyright © 2019 Panagiotis  Kompotis . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PKIdentifiableProtocol <NSObject>

/**
 The name of the entity
 
 @return The name of the core data entity.
 */
- (NSString *)entityName;


@end

NS_ASSUME_NONNULL_END
