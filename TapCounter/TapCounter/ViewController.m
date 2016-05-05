//
//  ViewController.m
//  TapCounter
//
//  Created by David Perkins on 5/5/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic) int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.count = 0;
    _countLabel.text = @"0";
}

- (IBAction)increment:(id)sender {
    
    self.count += 1;
    _countLabel.text = [NSString stringWithFormat:@"%d", self.count];
    
}

- (IBAction)reset:(id)sender {
    
    self.count = 0;
    _countLabel.text = @"0";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
