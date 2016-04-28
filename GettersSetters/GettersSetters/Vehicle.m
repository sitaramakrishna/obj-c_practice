//
//  Vehicle.m
//  GettersSetters
//
//  Created by David Perkins on 4/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

@synthesize odometer = _odometer; // when declaring a setter AND a getter in same class, must declare @synthesize
    
-(void)setOdometer:(long)odometer {
    if (odometer > _odometer) {
        _odometer = odometer;
    }
}

// This would be a getter for odometer, where 69 would be returned every time odometer is read
//-(long *)odometer {
//    
//    return 69;
//    
//}

// Getter for model
-(NSString *)model {
    if ([_model isEqualToString:@"Honda Civic"]) {
        return @"POS";
    } else {
        return _model;
    }
}

@end
