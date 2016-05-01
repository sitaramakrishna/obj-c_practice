//
//  ViewController.m
//  OOP
//
//  Created by David Perkins on 4/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "Vehicle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Vehicle *car = [[Vehicle alloc] init];
    car.make = @"Toyota";
    car.model = @"Corolla";
    car.engineSize = @"V12";
    
    Vehicle *car2 = [[Vehicle alloc] init];
    car2.make = @"Tesla";
    car2.model = @"Model S";
    car2.engineSize = @"Electric";
    
    NSArray *arr = [NSArray arrayWithObjects:car, car2, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
