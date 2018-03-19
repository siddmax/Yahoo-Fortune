//
//  Entity+CoreDataProperties.m
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Entity+CoreDataProperties.h"

@implementation Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Company"];
}

@dynamic name;
@dynamic year;
@dynamic rank;
@dynamic revenue;
@dynamic profit;
@dynamic isFavorite;

@end
