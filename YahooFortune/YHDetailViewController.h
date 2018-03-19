//
//  YHDetailViewController.h
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entity+CoreDataClass.h"

@interface YHDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *revenueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Entity *entity;
- (IBAction)favorite:(id)sender;

@end
