//
//  YHDownloadManager.m
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import "YHDownloadManager.h"
#import "YHDownload.h"
#import "YHCoreDataHelper.h"
#import "Entity+CoreDataClass.h"

#define kURLString @"http://gomashup.com/json.php?fds=finance/fortune500/year/2008"

@implementation YHDownloadManager {
    NSTimer *timer;
}

+ (instancetype) sharedManager {
    static YHDownloadManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)downloadCompanies {
    if (timer != nil) {
        [self removeTimer];
    }
    [self downloadData];
    timer = [NSTimer scheduledTimerWithTimeInterval:300.0
                                             target:self
                                           selector:@selector(downloadData)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)downloadData {
    __weak typeof(self) weakSelf = self;
    
    [YHDownload httpGET:kURLString withCompletionHandler:^(NSError *error, NSData *data, NSURLResponse *response) {
        if (error) {
            //handle error
        } else {
            data = [self parseData:data];
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions
                                                                           error:&error];
            [self storeCompanyArray:response[@"result"] callback:^{
                __strong typeof(self) strongSelf = weakSelf;
                //fetch all companies
                [strongSelf.delegate updated:[strongSelf fetchEntitiesWithPredicate:nil]];
            }];
        }
    }];
}

- (NSData *)parseData:(NSData *)data {
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange begin = [output rangeOfString:@"(" options:NSLiteralSearch];
    NSRange end = [output rangeOfString:@")" options:NSBackwardsSearch|NSLiteralSearch];
    BOOL parseFail = (begin.location == NSNotFound || end.location == NSNotFound || end.location - begin.location < 2);
    if (!parseFail)
    {
        output = [output substringWithRange:NSMakeRange(begin.location + 1, (end.location - begin.location) - 1)];
    }
    
    return [output dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)storeCompanyArray:(NSArray *)companies callback:(void (^)())callback {
    for (NSDictionary *company in companies) {
        NSString *name = company[@"Company"];
        
        //checking if company with this name already exists
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"name", name];
        NSArray *result = [self fetchEntitiesWithPredicate:predicate];
        
        //just overrwrite old company data
        if (result.count == 1) {
            Entity *entity  = result[0];
            entity.year = [company[@"Year"] intValue];
            entity.rank = [company[@"Rank"] intValue];
            entity.revenue = [company[@"Revenue"] intValue];
            entity.profit = [company[@"Profit"] doubleValue];
            [self saveEntity:entity];
        } else if (result.count == 0) {
            //new company, need to save
            Entity *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:[YHCoreDataHelper managedObjectContext]];
            entity.name = company[@"Name"];
            entity.year = [company[@"Year"] intValue];
            entity.rank = [company[@"Rank"] intValue];
            entity.revenue = [company[@"Revenue"] intValue];
            entity.profit = [company[@"Profit"] doubleValue];
            [self saveEntity:entity];
        } else {
            NSLog(@"Error - multiple companies with the same name");
        }
        
    }
    
    callback();
}

- (void)saveEntity:(Entity *)company {
    NSError *error = nil;

    if (![[company managedObjectContext] save:&error])
    {
        NSLog(@"Entity was not saved!");
    }
}

- (NSArray *)fetchEntitiesWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Company"];
    [fetchRequest setPredicate:predicate];
    
    NSError *fetchError = nil;
    NSArray *result = [[YHCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&fetchError];
    
    if (!fetchError) {
        return result;
    } else {
        NSLog(@"Error fetching data.");
        NSLog(@"%@, %@", fetchError, fetchError.localizedDescription);
        return nil;
    }
}

- (void)removeTimer {
    [timer invalidate];
    timer = nil;
}

- (void)dealloc {
    [self removeTimer];
}

@end
