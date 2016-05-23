//
//  ViewController.m
//  UISearchController
//
//  Created by David Perkins on 5/22/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Candy *candy1 = [[Candy alloc]init];
    candy1.category = @"Chocolate";
    candy1.name = @"Chocolate Bar";
    
    Candy *candy2 = [[Candy alloc]init];
    candy2.category = @"Chocolate";
    candy2.name = @"Chocolate Chip";
    
    Candy *candy3 = [[Candy alloc]init];
    candy3.category = @"Chocolate";
    candy3.name = @"Dark Chocolate";
    
    Candy *candy4 = [[Candy alloc]init];
    candy4.category = @"Hard";
    candy4.name = @"Lollipop";
    
    Candy *candy5 = [[Candy alloc]init];
    candy5.category = @"Hard";
    candy5.name = @"Candy Cane";
    
    Candy *candy6 = [[Candy alloc]init];
    candy6.category = @"Hard";
    candy6.name = @"Jaw Breaker";
    
    Candy *candy7 = [[Candy alloc]init];
    candy7.category = @"Other";
    candy7.name = @"Caramel";
    
    Candy *candy8 = [[Candy alloc]init];
    candy8.category = @"Other";
    candy8.name = @"Sour Chew";
    
    Candy *candy9 = [[Candy alloc]init];
    candy9.category = @"Other";
    candy9.name = @"Gummi Bear";
    
    self.candyArray = [NSArray arrayWithObjects:candy1,candy2,candy3,candy4,candy5,candy6,candy7,candy8,candy9, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
