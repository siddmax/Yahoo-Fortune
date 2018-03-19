//
//  YHDownload.m
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import "YHDownload.h"

@implementation YHDownload

NSURLSession* currentSession;

#pragma mark Class Methods

+ (NSURLSession*)currentInstance {
    if (currentSession == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        currentSession = [NSURLSession sessionWithConfiguration:config];
    }
    return currentSession;
}


+ (void)httpGET: (NSString*)urlString withCompletionHandler:(void (^)(NSError* error, NSData *data, NSURLResponse *response))completionBlock {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession* session = [YHDownload currentInstance];
    if (session)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURLSessionDataTask *dataTask =
            [currentSession dataTaskWithURL: url
                          completionHandler:^(NSData *data,
                                              NSURLResponse *response,
                                              NSError *error)
             {
                 if(completionBlock != nil)
                 {
                     completionBlock(error, data, response);
                 }
             }];
            [dataTask resume];
        });
    }
}

@end
