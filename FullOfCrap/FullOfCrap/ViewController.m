//
//  ViewController.m
//  FullOfCrap
//
//  Created by David Perkins on 5/14/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface ViewController () <UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *xBar;
@property (weak, nonatomic) IBOutlet UIProgressView *yBar;
@property (weak, nonatomic) IBOutlet UIProgressView *zBar;

@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@property (nonatomic,strong) UIAccelerometer *accelerometer;

@property (weak, nonatomic) IBOutlet UIButton *poopingBtn;
- (IBAction)poopingBtnPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)poopingBtnPressed:(id)sender {
    
    
}


@end
