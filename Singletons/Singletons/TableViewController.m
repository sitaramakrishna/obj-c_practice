//
//  TableViewController.m
//  Singletons
//
//  Created by David Perkins on 5/8/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TableViewController.h"
#import "Groceries.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray *array2;
- (IBAction)editTableView:(id)sender;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self refreshControl]addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    
    _array2 = [NSArray arrayWithObjects:@"Garbanzo Beans", @"Blueberries", @"Cottage Cheese", nil];
    
    UIRefreshControl *refreshMe = [[UIRefreshControl alloc] init];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull Me"];
    [refreshMe addTarget:self action:@selector(handleRefresh:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshMe;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[self tableView]reloadData];
    
}

-(void)handleRefresh:(UIRefreshControl *)refreshControl {
    
    [[[Groceries sharedInstance]groceryList]removeAllObjects];
    
    [[[Groceries sharedInstance]groceryList]addObjectsFromArray:_array2];
    
    [[self tableView]reloadData];
    
    [[self refreshControl]endRefreshing];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[Groceries sharedInstance]groceryList]count];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    UITableViewCell *itemToMove = [[[Groceries sharedInstance]groceryList]objectAtIndex:sourceIndexPath.row];
    [[[Groceries sharedInstance]groceryList]removeObjectAtIndex:sourceIndexPath.row];
    [[[Groceries sharedInstance]groceryList]insertObject:itemToMove atIndex:destinationIndexPath.row];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[[Groceries sharedInstance]groceryList]removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[Groceries sharedInstance]groceryList][indexPath.row];
    
    return cell;
}


- (IBAction)editTableView:(id)sender {
    
    self.editing = !self.editing;
    
}
@end
