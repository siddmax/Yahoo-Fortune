//
//  Entity+CoreDataProperties.h
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Entity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t year;
@property (nonatomic) int16_t rank;
@property (nonatomic) int64_t revenue;
@property (nonatomic) double profit;
@property (nonatomic) BOOL isFavorite;

@end

NS_ASSUME_NONNULL_END
