//
//  YHSettingsViewController.m
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import "YHSettingsViewController.h"

@interface YHSettingsViewController ()

@end

@implementation YHSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sortByName:(id)sender {
    [self saveSortPreference:@"name"];
}

- (IBAction)sortByYear:(id)sender {
    [self saveSortPreference:@"year"];
}

- (IBAction)sortByRank:(id)sender {
    [self saveSortPreference:@"rank"];
}

- (void)saveSortPreference:(NSString *)sort {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:@"sort"];
    
    [defaults synchronize];
}
@end
