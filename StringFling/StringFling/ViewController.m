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
    
    NSString *firstName = @"John"; // this is a string literal
    
    NSString *allocatedString = [[NSString alloc]init]; // likely never going to allocate empty string
    
    NSLog(@"Name: %@", firstName); // like string interpolation, proper way to print variables
    
    NSString *fullName = [NSString stringWithFormat:@"%@ Smith %@", firstName, @"Charles"];
    
    NSString *display = [fullName stringByAppendingString:@" - Died 1448"];
    
    NSLog(@"Fullname: %@", fullName);
    
    NSLog(@"%@", display);
    
    
    
    NSString *var1 = @"Junk";
    NSString *var2 = @"in the trunk";
    NSString *var3 = @"junk";
    
    // How to compare strings in Objective-C
    if (![var1 isEqualToString:var2]) {
        
        NSLog(@"They are not the same");
        
    }
    
    if ([var1.lowercaseString isEqualToString:var3]) {
        NSLog(@"It's a match");
    }
    
    if ([var1 caseInsensitiveCompare:var3] == NSOrderedSame) {
        
        NSLog(@"Woohoo");
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
