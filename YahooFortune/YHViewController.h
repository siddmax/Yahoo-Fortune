//
//  ViewController.h
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHDownloadManager.h"

@interface YHViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, YHDownloadDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

