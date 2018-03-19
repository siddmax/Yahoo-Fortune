//
//  YHDownload.h
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDownload : NSObject

+(void)httpGET:(NSString*)urlString withCompletionHandler:(void (^)(NSError* error, NSData *data, NSURLResponse *response))completionBlock;

@end
