//
//  CategoryPickerViewController.h
//  MyLocations
//
//  Created by David Perkins on 5/13/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CategoryPickerViewController : UITableViewController

@property (nonatomic, strong) NSString *selectedCategoryName;

@end
