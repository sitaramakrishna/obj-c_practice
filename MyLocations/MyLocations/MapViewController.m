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
#import "LocationDetailsViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *locations;

@end

@implementation MapViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        // Tells NSNotificationCenter to add self as observer for NSManagedObjectContextObjectsDidChangeNotification, sent out by managedObjectContext when data store changes
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    }
    
    return self;
}

-(void)contextDidChange:(NSNotification *)notification {
    
    // Get Location object out of notification.userInfo, insert it as param into updateLocations
    NSSet *inserted = [notification.userInfo objectForKey:@"inserted"];
    NSSet *deleted = [notification.userInfo objectForKey:@"deleted"];
    NSSet *updated = [notification.userInfo objectForKey:@"updated"];
    
    if (inserted != nil) {
        
        for (Location *newLocation in inserted) {
            
            [self updateLocations:newLocation becauseItWas:@"inserted"];
            
        }
        
    } else if (deleted != nil) {
        
        for (Location *removedLocation in deleted) {
            
            [self updateLocations:removedLocation becauseItWas:@"deleted"];
            
        }
        
    } else if (updated != nil) {
        
        for (Location *updatedLocation in updated) {
            
            [self updateLocations:updatedLocation becauseItWas:@"updated"];
            
        }
        
    }
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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


-(void)updateLocations:(nullable Location *)location becauseItWas:(nullable NSString *)action {
    
    if ([action isEqualToString:@"updated"] || (location == nil && action == nil)) {
        
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
        
        [_locations removeAllObjects];
        _locations = [NSMutableArray arrayWithArray:foundObjects];
        
        [self.mapView addAnnotations:_locations];
        
    } else if ([action isEqualToString:@"inserted"]) {
        
        NSLog(@"*** New location inserted");
        [self.mapView addAnnotation:location];
        [_locations addObject:location];
        
    } else if ([action isEqualToString:@"deleted"]) {
        
        NSLog(@"*** Location deleted");
        [self.mapView removeAnnotation:location];
        [_locations removeObject:location];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLocations:nil becauseItWas:nil];
    
    if ([_locations count] > 0) {
        [self showLocations];
    }
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // 1 -- MKAnnotation is a protocol, so objects may not be of Location class
    if ([annotation isKindOfClass:[Location class]]) {
        
        // 2 -- Reuse an annotation view object. If it can't find a recyclable annotation view, create a new one
        static NSString *identifier = @"Location";
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
            // 3 -- sets properties, make pin green
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = NO;
            annotationView.pinTintColor = [UIColor greenColor];
            
            // 4 -- Add a detail disclosure button to the annotation view's accessory view
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(showLocationDetails:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = rightButton;
        
        } else {
            
            annotationView.annotation = annotation;
        }
        
        // 5 -- Once annotation view is constructed, obtain a reference to the detail disclosure button again and set tag to index of Location object in _locations array.
        UIButton *button = (UIButton *)annotationView.rightCalloutAccessoryView;
        button.tag = [_locations indexOfObject:(Location *)annotation];
        return annotationView;
    }
    
    return nil;
}

-(void)showLocationDetails:(UIButton *)button {
    
    [self performSegueWithIdentifier:@"EditLocation" sender:button];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"EditLocation"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        LocationDetailsViewController *controller = (LocationDetailsViewController *)navigationController.topViewController;
        
        controller.managedObjectContext = self.managedObjectContext;
        
        UIButton *button = (UIButton *)sender;
        
        NSLog(@"prepareforsegue1");
        Location *location = _locations[button.tag];
        NSLog(@"prepareforsegue2");
        controller.locationToEdit = location;
    }
}



@end
