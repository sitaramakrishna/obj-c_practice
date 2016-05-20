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
@dynamic date;
@dynamic locationDescription;
@dynamic category;
@dynamic placemark;
@dynamic photoId;

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title {
    
    if ([self.locationDescription length] > 0) {
        return self.locationDescription;
    } else {
        return @"(No Description)";
    }
}

-(NSString *)subtitle {
    
    return self.category;
}

-(BOOL)hasPhoto {
    
    return (self.photoId != nil) && ([self.photoId integerValue] != -1);
    
}

-(NSString *)documentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths lastObject];
    
    return documentsDirectory;
    
}

-(NSString *)photoPath {
    
    NSString *filename = [NSString stringWithFormat:@"Photo-%ld.jpg", [self.photoId integerValue]];
    
    return [[self documentsDirectory] stringByAppendingPathComponent:filename];
    
}

-(UIImage *)photoImage {
    
    NSAssert(self.photoId != nil, @"No photoID set");
    NSAssert([self.photoId integerValue] != -1, @"Photo ID is -1");
    
    return [UIImage imageWithContentsOfFile:[self photoPath]];
    
}

+(NSInteger)nextPhotoId {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger photoId = [defaults integerForKey:@"PhotoID"];
    [defaults setInteger:photoId+1 forKey:@"PhotoID"];
    [defaults synchronize];
    
    return photoId;
    
}


@end





