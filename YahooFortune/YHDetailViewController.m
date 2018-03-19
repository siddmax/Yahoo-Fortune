//
//  YHDetailViewController.m
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import "YHDetailViewController.h"

@interface YHDetailViewController ()

@end

@implementation YHDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favorite:(id)sender {
    self.entity.isFavorite = YES;
    [self saveEntity:self.entity];
}

- (void)saveEntity:(Entity *)company {
    NSError *error = nil;
    
    if (![[company managedObjectContext] save:&error])
    {
        NSLog(@"Entity was not saved!");
    }
}
@end
