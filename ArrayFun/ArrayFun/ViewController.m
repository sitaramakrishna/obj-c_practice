//
//  ViewController.m
//  ArrayFun
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
    // Do any additional setup after loading the view, typically from a nib.
    
    // NSArray is immutable. Can't change or modify, add or remove objects. Use NSMutable array instead.
    NSArray *arr = [NSArray arrayWithObjects:@"My", @"mother", @"told", @"me", nil];
    NSArray *arr2 = @[@"Donkey", @"Kong", @"Ate", @"Your", @"Mom"];
    
    NSString *str = [arr objectAtIndex:2]; // Can grab values out, but can't mutate
    
    // NSMutableArray is mutable.
    NSMutableArray *mut = [NSMutableArray arrayWithObjects:@"boom",@"jam",@"slam",@"damn", nil];
    NSLog(@"MUT: %@", mut.debugDescription);
    
    [mut removeObjectAtIndex:2];
    [mut addObject:@"beast master"];
    
    NSLog(@"MUT 2: %@", mut.debugDescription);
    
    
    
    //Initialize array with another array
    NSArray *arr3 = [NSArray arrayWithArray:arr];
    
    NSArray *arr4 = mut;
//    NSMutableArray *arr5 = arr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
