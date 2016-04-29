//
//  ViewController.m
//  Loops
//
//  Created by David Perkins on 4/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Loop through array
    NSArray *cars = @[@"Bimmer", @"Maserati", @"Bronco II"];
    
    for (int x = 0; x < cars.count; x++) {
        NSString *car = [cars objectAtIndex:x];
        NSLog(@"Car: %@", car);
    }
    
    for (NSString *car in cars) {
        
        NSLog(@"Car: %@", car);
        
    }
    
    // Loop through dictionary
    NSDictionary *dict = @{@"1":@"Toyota",@"2":@"Honda",@"3":@"Buick"};
    
    for (id key in dict)
        NSLog(@"key = %@ value = %@", key, [dict objectForKey:key]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
