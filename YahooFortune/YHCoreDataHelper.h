//
//  YHCoreDataHelper.h
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity+CoreDataClass.h"
#import "Entity+CoreDataProperties.h"

@interface YHCoreDataHelper : NSObject

+(NSManagedObjectContext *)managedObjectContext;

@end
