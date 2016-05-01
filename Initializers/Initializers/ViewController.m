//
//  ViewController.m
//  Initializers
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [[Person alloc]init];
//    Person *person2 = [Person new];
    
    [person printName];
    
    Person *person3 = [[Person alloc]initWIthFirstName:@"Petey" lastName:@"McFreedy"];
    [person3 printName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
