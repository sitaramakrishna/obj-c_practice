//
//  ViewController.m
//  BlockDemo
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testBlockStorageType];
    
    // Sample block declarations. Parameter names not required
    int (^firstBlockName)(NSString *param1, int param2);
    void (secondBlockName)(NSString *myName);
    NSDate *(^whatDayIsIt)(void);
    void (^allVoid)(void);
    NSString *(^lastBlock)(NSString *firstName, NSString *lastName);
    
    // Block definition:
//    ^(Parameters) {
//        ... block body ...
//        
//        return ReturnValue (or nothing if the block return type is void)
//    };
    
    // Assign block results to a block variable
    int (^howMany)(int, int) = ^(int a, int b){
        return a + b;
    };
    NSLog(@"%d", howmany(5, 10));
    
    void (^justAMessage)(NSString *) = ^(NSString *message) {
        NSLog(@"%@", message);
    };
    
    // Declare a block variable and define it afterwards
    void (^xyz)(void);
    xyz = ^(void) {
        NSLog(@"What's up Doc?");
    };
    
    NSDate *(^today)(void);
    today = ^(void){
        return [NSDate date];
    };
    NSLog(@"%@", today());
    
    // Declared in ViewController.h
    _blockOne = ^(NSString *firstName){
        return [NSString stringWithFormat:@"What's up %@", firstName];
    };
    
    
    float results = ^(float value1, float value2, float value3){
        return value1 * value2 * value3;
    } (1.2, 3.4, 5.6);
    NSLog(@"results: %f", results);
    
    
    int factor = 5;
    int (^newResult)(void) = ^(void){
        return factor * 10;
    };
    NSLog(@"newResult: %d", newResult());
    
    
}

// Called in viewDidLoad
-(void)testBlockStorageType{
    __block int someValue = 10;
    
    int (^myOperation)(void) = ^(void){
        someValue += 5;
        
        return someValue + 10;
    };
    
    NSLog(@"testBlockStorageType: %d", myOperation());
}

@end
