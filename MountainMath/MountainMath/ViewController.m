//
//  ViewController.m
//  MountainMath
//
//  Created by David Perkins on 4/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    int imAnIn = 5;
    float iAmAFloat = 3.3;
    double iAmTheDouble = 5.66666669;
    
    NSLog(@"Int: %d", imAnIn);
    NSLog(@"Float: %f", iAmAFloat);
    NSLog(@"Double: %f", iAmTheDouble);
    
    
    NSNumber *numInt = [NSNumber numberWithInt:5];
    NSNumber *numInt2 = [NSNumber numberWithInt:6];
    
    int val = numInt.intValue;
    int val2 = numInt2.intValue;
    
    int sum = val + val2; // to do operations, don't need to store numbers in NSNumber
    
    NSLog(@"%d", sum); // prints 11
    
    NSNumber *numSum = [NSNumber numberWithInt:sum]; // storing number of native C type in NSNumber
    
    NSArray *arr = @[numInt, numInt2, numSum]; // can be stored in NSArray
    
    NSString *str = numSum.stringValue; // grabs string value
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
