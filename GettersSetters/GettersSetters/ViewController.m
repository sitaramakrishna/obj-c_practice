//
//  ViewController.m
//  GettersSetters
//
//  Created by David Perkins on 4/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "Vehicle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    Vehicle *car = [[Vehicle alloc]init];
    car.odometer = 112; // this will not set the odometer to -100, because in setOdometer:, we're making sure that this value must be greater than what car.odometer currently is (0 before being set to anything)
    
    NSLog(@"Odometer: %lu", car.odometer);
    
    
    car.model = @"Honda Civic";
    NSLog(@"I drive a %@", car.model);
}



@end
