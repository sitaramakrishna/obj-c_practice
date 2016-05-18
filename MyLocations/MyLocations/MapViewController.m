//
//  MapViewController.m
//  MyLocations
//
//  Created by David Perkins on 5/18/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import "Location.h"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *locations;

@end

@implementation MapViewController


-(IBAction)showUser {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 1000, 1000);
    
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

-(IBAction)showLocations {
    
    MKCoordinateRegion region = [self regionForAnnotations: _locations];
    
    [self.mapView setRegion:region animated:YES];
}

// regionForAnnotation deals with annotations, so we can use this method in any app that uses Map Kit, without mods.
// regionForAnnotations has 3 situations to handle:
// 1: There are no annotations. Then we center map on user's current position
// 2: There's only one annotation. Center the map on that one annotation
// 3: There are 2+ annotations. Calculate extent of reach and add some padding
-(MKCoordinateRegion)regionForAnnotations:(NSArray *)annotations {
    
    MKCoordinateRegion region;
    
    if ([annotations count] == 0) {
        
        region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 1000, 1000);
    
    } else if ([annotations count] == 1) {
        
        id <MKAnnotation> annotation = [annotations lastObject];
        
        region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000);
    
    } else {
        
        CLLocationCoordinate2D topLeftCoord;
        topLeftCoord.latitude = -90;
        topLeftCoord.longitude = 180;
        
        CLLocationCoordinate2D bottomRightCoord;
        bottomRightCoord.latitude = 90;
        bottomRightCoord.longitude = -180;
        
        for (id <MKAnnotation> annotation in annotations) {
            
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
            
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
            
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        }
        
        const double extraSpace = 1.1;
        
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) / 2.0;
        
        region.center.longitude = topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude) / 2.0;
        
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace;
        
        region.span.longitudeDelta = fabs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace;
        
    }
    
    return [self.mapView regionThatFits:region];
}

-(void)updateLocations {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *foundObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (foundObjects == nil) {
        FATAL_CORE_DATA_ERROR(error);
        return;
    }
    
    if (_locations != nil) {
        [self.mapView removeAnnotations:_locations];
    }
    
    _locations = foundObjects;
    [self.mapView addAnnotations:_locations];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLocations];
    
    if ([_locations count] > 0) {
        [self showLocations];
    }
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[Location class]]) {
        
        
    }
    
}



@end
