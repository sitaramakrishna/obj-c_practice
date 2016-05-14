//
//  CategoryPickerViewController.m
//  MyLocations
//
//  Created by David Perkins on 5/13/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "CategoryPickerViewController.h"

@implementation CategoryPickerViewController
{
    
    NSArray *_categories;
    NSIndexPath *_selectedIndexPath;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categories = @[
                    @"No Category", @"Apple Store", @"Bar",
                    @"Bookstore", @"Club",
                    @"Grocery Store", @"Historic Building", @"House",
                    @"Icecream Vendor", @"Landmark", @"Park"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *categoryName = _categories[indexPath.row];
    cell.textLabel.text = categoryName;
    if ([categoryName isEqualToString: self.selectedCategoryName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _selectedIndexPath = indexPath;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectedCategoryName = _categories[indexPath.row];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PickedCategory"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        self.selectedCategoryName = _categories[indexPath.row];
    }
}

@end
