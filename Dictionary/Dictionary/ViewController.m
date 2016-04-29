//
//  ViewController.m
//  Dictionary
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
    
    // NSDictionary is IMMUTABLE, don't try changing or modifying it (esp with setValue:)
    NSNumber *age = [NSNumber numberWithInt:40];
    NSNumber *age2 = [NSNumber numberWithInt:34];
    NSDictionary *dict = @{@"jack": age, @"jon": age2, @"peter": @"parker"};
    
    int jacksAge = [[dict objectForKey:@"jack"] intValue];
    NSLog(@"Jack's age: %d", jacksAge);
    
    
    
    // NSMutableDictionary is mutable, can be modified
    NSMutableDictionary *mut = [@{@"1": @"BMW", @"2": @"Volvo", @"3": @"Ugly honda civic"} mutableCopy];
    
    NSMutableDictionary *mut2 = [[NSMutableDictionary alloc]init];
    //or...
    NSMutableDictionary *mut3 = [NSMutableDictionary dictionaryWithObjects:@[@"Toyota", @"Lambo"] forKeys:@[@"4", @"5"]];
    
    NSLog(@"%@", mut3.debugDescription);
    
    [mut2 setObject:@"An Object" forKey:@"A key"];
    [mut2 setObject:[NSNumber numberWithDouble:20.0000]  forKey:@"doubletrouble"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
