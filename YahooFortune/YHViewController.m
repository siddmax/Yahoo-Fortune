//
//  ViewController.m
//  YahooFortune
//
//  Created by Kevin Patel on 10/10/16.
//  Copyright © 2016 Kevin Patel. All rights reserved.
//

#import "YHViewController.h"
#import "YHCoreDataHelper.h"
#import "Entity+CoreDataClass.h"
#import "YHDetailViewController.h"

#define cellID @"cell"

@interface YHViewController ()

@property (nonatomic, strong) YHDownloadManager *manager;
@property (nonatomic, strong) NSArray *companies;
@property (nonatomic, strong) Entity *selected;

@end

@implementation YHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.manager = [YHDownloadManager sharedManager];
    self.manager.delegate = self;
    
    [self.manager downloadCompanies];
    [self getResultsFromCache];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getResultsFromCache];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.companies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    Entity *entity = self.companies[indexPath.row];
    
    cell.textLabel.text = entity.name;
    
    if (entity.isFavorite) {
        //do favorite image
        cell.imageView.image = [UIImage imageNamed:@"favorite.png"];
    } else {
        //do not favorite
        cell.imageView.image = [UIImage imageNamed:@"empty.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selected = self.companies[indexPath.row];
}

- (void)updated:(NSArray *)array {
    self.companies = array;
    [self updateTableView];
}

- (void)updateTableView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *sortKey = [defaults objectForKey:@"sort"];
        
        if (sortKey) {
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES];
            NSArray *sortedCompanies = [self.companies sortedArrayUsingDescriptors:@[sortDescriptor]];
            self.companies = sortedCompanies;
        } else {
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            NSArray *sortedCompanies = [self.companies sortedArrayUsingDescriptors:@[sortDescriptor]];
            self.companies = sortedCompanies;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)getResultsFromCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Company"];
    
    NSError *fetchError = nil;
    NSArray *result = [[YHCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&fetchError];
    
    if (!fetchError) {
        self.companies = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } else {
        NSLog(@"Error fetching data.");
        NSLog(@"%@, %@", fetchError, fetchError.localizedDescription);
    }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"detail"]) {
        YHDetailViewController *vc = [segue destinationViewController];
        vc.nameLabel.text = self.selected.name;
        vc.yearLabel.text = [NSString stringWithFormat:@"%d", self.selected.year];
        vc.revenueLabel.text = [NSString stringWithFormat:@"%lld", self.selected.revenue];
        vc.rankLabel.text = [NSString stringWithFormat:@"%d", self.selected.rank];
        vc.profitLabel.text = [NSString stringWithFormat:@"%.2f", self.selected.profit];
        vc.entity = self.selected;
    }
}


@end
