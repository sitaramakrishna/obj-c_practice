//
//  CurrentLocationViewController
//  MyLocations
//
//  Created by David Perkins on 5/12/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import "LocationDetailsViewController.h"

@interface CurrentLocationViewController ()

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *location;
@property (nonatomic) BOOL updatingLocation;
@property (nonatomic,strong) NSError *lastLocationError;
@property (nonatomic,strong) CLGeocoder *geocoder; // object that performs the geocoding
@property (nonatomic,strong) CLPlacemark *placemark; // object that contains the address
@property (nonatomic) BOOL performingReverseGeocoding;
@property (nonatomic,strong) NSError *lastGeocodingError;

@end

@implementation CurrentLocationViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        _locationManager = [[CLLocationManager alloc]init];
        _geocoder = [[CLGeocoder alloc]init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self updateLabels];
    [self configureGetButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender {
    
    if (_updatingLocation) {
        [self stopLocationManager];
    } else {
        _location = nil;
        _lastLocationError = nil;
        _placemark = nil;
        _lastGeocodingError = nil;
        
        [self startLocationManager];
    }
    
    [self updateLabels];
    [self configureGetButton];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TagLocation"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        LocationDetailsViewController *controller = (LocationDetailsViewController *)navigationController.topViewController;
        controller.coordinate = _location.coordinate;
        controller.placemark = _placemark;
        controller.managedObjectContext = self.managedObjectContext;
    }
}

-(NSString *)stringFromPlacemark:(CLPlacemark *)thePlacemark {
    
    return [NSString stringWithFormat:@"%@ %@\n%@ %@ %@", thePlacemark.subThoroughfare, thePlacemark.thoroughfare, thePlacemark.locality, thePlacemark.administrativeArea, thePlacemark.postalCode];
}

-(void)updateLabels {
    
    if (_location != nil) {
        
        _latitudeLabel.text = [NSString stringWithFormat:@"%.8f", _location.coordinate.latitude];
        _longitudeLabel.text = [NSString stringWithFormat:@"%.8f", _location.coordinate.longitude];
        _tagButton.hidden = NO;
        _messageLabel.text = @"";
        
        if (_placemark != nil) {
            
            _addressLabel.text = [self stringFromPlacemark: _placemark];
            
        } else if (_performingReverseGeocoding) {
            _addressLabel.text = @"Searching for Address...";
        } else if (_lastGeocodingError != nil) {
            _addressLabel.text = @"Error Finding Address";
        } else {
            _addressLabel.text = @"No Address Found";
        }
        
    } else {
        
        _latitudeLabel.text = @"";
        _longitudeLabel.text = @"";
        _addressLabel.text = @"";
        _tagButton.hidden = YES;
        
        NSString *statusMessage;
        if (_lastLocationError != nil) {
            if ([_lastLocationError.domain isEqualToString:kCLErrorDomain] && _lastLocationError.code == kCLErrorDenied) {
                statusMessage = @"Location Services Disabled";
            } else {
                statusMessage = @"Error Getting Location";
            }
        } else if (![CLLocationManager locationServicesEnabled]) {
            statusMessage = @"Location Services Disabled";
        } else if (_updatingLocation) {
            statusMessage = @"Searching...";
        } else {
            statusMessage = @"Press the Button to Start";
        }
        
        self.messageLabel.text = statusMessage;
    }
}

-(void)configureGetButton {
    
    if (_updatingLocation) {
        [self.getButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.getButton setTitle:@"Get My Location" forState:UIControlStateNormal];
    }
}

-(void)startLocationManager {
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager startUpdatingLocation];
        [_locationManager requestWhenInUseAuthorization];
        _updatingLocation = YES;
        
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
    }
}

- (void)stopLocationManager {
    if (_updatingLocation) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didTimeOut:) object:nil];
        
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
    }
}

-(void)didTimeOut:(id)obj {
    
//    NSLog(@"*** Time out");
    
    if (_location == nil) {
        [self stopLocationManager];
        
        _lastLocationError = [NSError errorWithDomain:@"MyLocationsErrorDomain" code:1 userInfo:nil];
        
        [self updateLabels];
        [self configureGetButton];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    NSLog(@"didFailWithError %@", error);
    
    if (error.code == kCLErrorLocationUnknown) {
        return;
    }
    
    [self stopLocationManager];
    _lastLocationError = error;
    
    [self updateLabels];
    [self configureGetButton];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
//    NSLog(@"didUpdateLocations %@", newLocation);
    
    // Let's ignore cached results
    if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        return;
    }
    
    // Return on invalid measurements
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    CLLocationDistance distance = MAXFLOAT;
    if (_location != nil) {
        distance = [newLocation distanceFromLocation:_location];
    }
    
    if (_location == nil || _location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        
        _lastLocationError = nil;
        _location = newLocation;
        [self updateLabels];
        
        // Stop returning locations when we reach desired accuracy for single location
        if (newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
//            NSLog(@"*** We're done!");
            [self stopLocationManager];
            [self configureGetButton];
            
            if (distance > 0) {
                _performingReverseGeocoding = NO;
            }
        }
        
        if (!_performingReverseGeocoding) {
            
//            NSLog(@"*** Going to geocode");
            
            _performingReverseGeocoding = YES;
            
            [_geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
                
//                NSLog(@"*** Found placemarks: %@, error: %@", placemarks, error);
                
                _lastGeocodingError = error;
                
                if (error == nil && [placemarks count] > 0) {
                    _placemark = [placemarks lastObject];
                    
                } else {
                    _placemark = nil;
                }
                
                _performingReverseGeocoding = NO;
                [self updateLabels];
            }];
            
        }
        // If distance isn't much different and it's been over 10 seconds since original reading
        else if (distance < 1.0) {
            NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceDate:_location.timestamp];
            if (timeInterval > 10) {
//                NSLog(@"*** Force done!");
                [self stopLocationManager];
                [self updateLabels];
                [self configureGetButton];
            }
        }
        
        
    }
}


@end
