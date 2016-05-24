//
//  MasterViewController.m
//  UISearchController
//
//  Created by David Perkins on 5/23/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Candy.h"

@interface MasterViewController ()

@property (nonatomic, strong) DetailViewController *detailVC;
@property (nonatomic, strong) UISplitViewController *splitVC;
@property (nonatomic, strong) NSArray *candyArray;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.splitViewController != nil) {
        
        _splitVC = self.splitViewController;
        NSArray<UIViewController *> *controllers = _splitVC.viewControllers;
        UINavigationController *navController = (UINavigationController *)(controllers[controllers.count-1]);
        _detailVC = (DetailViewController *)navController.topViewController;
        
    }
    
    Candy *candy1 = [[Candy alloc]init];
    candy1.category = @"Chocolate";
    candy1.name = @"Chocolate Bar";
    
    Candy *candy2 = [[Candy alloc]init];
    candy2.category = @"Chocolate";
    candy2.name = @"Chocolate Chip";
    
    Candy *candy3 = [[Candy alloc]init];
    candy3.category = @"Chocolate";
    candy3.name = @"Dark Chocolate";
    
    Candy *candy4 = [[Candy alloc]init];
    candy4.category = @"Hard";
    candy4.name = @"Lollipop";
    
    Candy *candy5 = [[Candy alloc]init];
    candy5.category = @"Hard";
    candy5.name = @"Candy Cane";
    
    Candy *candy6 = [[Candy alloc]init];
    candy6.category = @"Hard";
    candy6.name = @"Jaw Breaker";
    
    Candy *candy7 = [[Candy alloc]init];
    candy7.category = @"Other";
    candy7.name = @"Caramel";
    
    Candy *candy8 = [[Candy alloc]init];
    candy8.category = @"Other";
    candy8.name = @"Sour Chew";
    
    Candy *candy9 = [[Candy alloc]init];
    candy9.category = @"Other";
    candy9.name = @"Gummi Bear";
    
    [[[Candy sharedInstance]arrayOfCandy]addObjectsFromArray:@[candy1,candy2,candy3,candy4,candy5,candy6,candy7,candy8,candy9]];

    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.clearsSelectionOnViewWillAppear = _splitVC.collapsed;
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[Candy sharedInstance]arrayOfCandy]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell" forIndexPath:indexPath];
    
    Candy *candy = [[Candy sharedInstance]arrayOfCandy][indexPath.row];
    cell.textLabel.text = candy.name;
    cell.detailTextLabel.text = candy.category;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"showDetail"]) {
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        UINavigationController *navigationController = segue.destinationViewController;
        DetailViewController *controller = (DetailViewController *)navigationController.topViewController;
        
        controller.detailCandy = [[Candy sharedInstance]arrayOfCandy][indexPath.row];
        controller.navigationItem.leftBarButtonItem = _splitVC.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    
}


@end
