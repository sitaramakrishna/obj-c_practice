//
//  Location+CoreDataProperties.m
//  MyLocations
//
//  Created by David Perkins on 5/16/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

@dynamic latitude;
@dynamic longitude;
@dynamic data;
@dynamic locationDescription;
@dynamic category;
@dynamic placemark;

@end
