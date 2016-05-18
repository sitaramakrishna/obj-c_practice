//
//  Location+CoreDataProperties.h
//  MyLocations
//
//  Created by David Perkins on 5/16/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *locationDescription;
@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) CLPlacemark *placemark;

@end

NS_ASSUME_NONNULL_END
