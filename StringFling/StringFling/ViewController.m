//
//  ViewController.m
//  StringFling
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
    
    
    NSString *firstName = @"David";
    NSString *allocatedString = [[NSString alloc]init]; // almost never going to use this, work with string literals
    
    NSLog(@"Name: %@", firstName); // prints Name: David
    
    NSString *fullName = [NSString stringWithFormat:@"%@ Smith %@", firstName, @"Charles"];
    
    NSLog(@"%@", fullName); // prints David Smith Charles
    
    NSString *display = [fullName stringByAppendingString:@" - 2080"];
    
    NSLog(@"%@", display); // prints David Smith Charles - 2080
    
    // String comparisons
    
    NSString *var1 = @"Junk";
    NSString *var2 = @"in the trunk";
    NSString *var3 = @"junk";
    
    if (![var1 isEqualToString:var2]) {
        NSLog(@"They are not the same!");
    }
    
    if ([var1.lowercaseString isEqualToString:var3]) {
        NSLog(@"We gotteth here!");
    }
    
    if ([var1 caseInsensitiveCompare:var3] == NSOrderedSame) {
        NSLog(@"Woohoo!");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
