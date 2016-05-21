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
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
}

#pragma mark - UITableViewDelegate 

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.backgroundColor = [UIColor blackColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = cell.textLabel.textColor;
    
    UIView *selectionView = [[UIView alloc]initWithFrame:CGRectZero];
    selectionView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    cell.selectedBackgroundView = selectionView;
    
    if (indexPath.row == 2) {
        UILabel *addressLabel = (UILabel *)[cell viewWithTag:100];
        addressLabel.textColor = [UIColor whiteColor];
        addressLabel.highlightedTextColor = addressLabel.textColor;
    }
    
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

// Unwind segue back to LocationDetailViewController, THEN categoryPickerDidPickCategory:segue is called on LocationDetailVC
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PickedCategory"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        self.selectedCategoryName = _categories[indexPath.row];
    }
}

@end
