//
//  ViewController.m
//  MethodMan
//
//  Created by David Perkins on 4/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic) double bankAccount;
@property (nonatomic) double itemAmount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bankAccount = 500.50;
    self.itemAmount = 400.00;
    
}

- (BOOL)canPurchase:(double)amount {
    
    if (self.bankAccount >= amount) {
        return YES;
    }
    
    return NO;
    
}

- (void)playground {
    
    if ([self canPurchase:self.itemAmount]) {
        NSLog(@"We can buy!");
    }
    
    
    Person *person = [[Person alloc]init];
    [person speakName];
    [Person stateSpecies];
    
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://google.com"]]];
    
    
    
}





@end













