//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by David Perkins on 5/13/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class Location;

@interface LocationDetailsViewController : UITableViewController

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Location *locationToEdit;

@end

