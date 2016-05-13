//
//  CurrentLocationViewController
//  MyLocations
//
//  Created by David Perkins on 5/12/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *location;
@property (nonatomic) BOOL updatingLocation;
@property (nonatomic,strong) NSError *lastLocationError;
@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,strong) CLPlacemark *placemark;
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
        
        [self startLocationManager];
    }
    
    [self updateLabels];
    [self configureGetButton];
}

-(void)updateLabels {
    
    if (_location != nil) {
        
        _latitudeLabel.text = [NSString stringWithFormat:@"%.8f", _location.coordinate.latitude];
        _longitudeLabel.text = [NSString stringWithFormat:@"%.8f", _location.coordinate.longitude];
        _tagButton.hidden = NO;
        _messageLabel.text = @"";
        
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
        _updatingLocation = YES;
    }
}

- (void)stopLocationManager {
    if (_updatingLocation) {
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError %@", error);
    
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
    NSLog(@"didUpdateLocations %@", newLocation);
    
    // Let's ignore cached results
    if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        return;
    }
    
    // Return on invalid measurements
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    if (_location == nil || _location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        
        _lastLocationError = nil;
        _location = newLocation;
        [self updateLabels];
        
        // Stop returning locations when we reach desired accuracy for single location
        if (newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
            NSLog(@"*** We're done!");
            [self stopLocationManager];
            [self configureGetButton];
        }
        
        if (!_performingReverseGeocoding) {
            
            NSLog(@"*** Going to geocode");
            
            _performingReverseGeocoding = YES;
            
            [_geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
                
                NSLog(@"*** Found placemarks: %@, error: %@", placemarks, error);
                
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
    }
}


@end
