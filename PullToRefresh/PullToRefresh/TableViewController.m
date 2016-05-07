//
//  TableViewController.m
//  PullToRefresh
//
//  Created by David Perkins on 5/6/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TableViewController.h"
#import "Groceries.h"

@interface TableViewController ()
@property (nonatomic, strong) Groceries *groceries;
@property (nonatomic, strong) NSArray *array2;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _groceries = [[Groceries alloc]init];
    
    [[self refreshControl]addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    
    _array2 = [NSArray arrayWithObjects:@"Garbanzo Beans", @"Blueberries", @"Cottage Cheese", nil];
    
    UIRefreshControl *refreshMe = [[UIRefreshControl alloc] init];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull Me"];
    [refreshMe addTarget:self action:@selector(handleRefresh:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshMe;
}

-(void)handleRefresh:(UIRefreshControl *)refreshControl {
    
    NSLog(@"sup");
    
    [[_groceries groceryList]removeAllObjects];
    
    [[_groceries groceryList]addObjectsFromArray:_array2];
    
    [[self tableView]reloadData];
    
    [[self refreshControl]endRefreshing];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _groceries.groceryList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _groceries.groceryList[indexPath.row];
    
    return cell;
}


@end
