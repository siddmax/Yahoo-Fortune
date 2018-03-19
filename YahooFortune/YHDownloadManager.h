//
//  YHDownloadManager.h
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YHDownloadDelegate <NSObject>

@required
- (void)updated:(NSArray *)array;

@end

@interface YHDownloadManager : NSObject

@property (weak, nonatomic) id<YHDownloadDelegate> delegate;

+ (instancetype) sharedManager;
- (void)downloadCompanies;

@end
