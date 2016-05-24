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
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *filteredCandies;

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
    
    _filteredCandies = [NSArray arrayWithArray:[[Candy sharedInstance]arrayOfCandy]];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchBar.scopeButtonTitles = @[@"All", @"Chocolate", @"Hard", @"Other"];
    _searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = _searchController.searchBar;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.clearsSelectionOnViewWillAppear = _splitVC.collapsed;
    [super viewWillAppear:animated];
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    UISearchBar *searchBar = _searchController.searchBar;
    
    [self filterContentForSearchText:searchBar.text andScope:searchBar.scopeButtonTitles[searchBar.selectedScopeButtonIndex]];
    
}

-(void)filterContentForSearchText:(NSString *)searchText andScope:(NSString *)scope {
    
    NSPredicate *predicate;
    
    if (![scope isEqualToString:@"All"]) {
        predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ AND category == %@", searchText, scope]; // [cd] is case and diacritic insensitive
    } else {
        predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
    }
    
    _filteredCandies = [[[Candy sharedInstance]arrayOfCandy] filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
    
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
    [self filterContentForSearchText:searchBar.text andScope:searchBar.scopeButtonTitles[selectedScope]];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_searchController.active && ![_searchController.searchBar.text isEqualToString:@""]) {
        return _filteredCandies.count;
    }
    
    return [[[Candy sharedInstance]arrayOfCandy]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell" forIndexPath:indexPath];
    
    Candy *candy;
    
    if (_searchController.active && ![_searchController.searchBar.text isEqualToString:@""]) {
        candy = _filteredCandies[indexPath.row];
    } else {
        candy = [[Candy sharedInstance]arrayOfCandy][indexPath.row];
    }
    
    cell.textLabel.text = candy.name;
    cell.detailTextLabel.text = candy.category;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"showDetail"]) {
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        UINavigationController *navigationController = segue.destinationViewController;
        DetailViewController *controller = (DetailViewController *)navigationController.topViewController;
        
        Candy *candy;
        if (_searchController.active && ![_searchController.searchBar.text isEqualToString:@""]) {
            candy = _filteredCandies[indexPath.row];
        } else {
            candy = [[Candy sharedInstance]arrayOfCandy][indexPath.row];
        }
        
        controller.detailCandy = candy;
        controller.navigationItem.leftBarButtonItem = _splitVC.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    
}


@end
