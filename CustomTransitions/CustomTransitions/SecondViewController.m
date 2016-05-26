//
//  SecondViewController.m
//  CustomTransitions
//
//  Created by David Perkins on 5/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "SecondViewController.h"
#import "PopAnimator.h"
#import "SecondViewController.h"

@interface SecondViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PopAnimator *transition;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _transition = [[PopAnimator alloc]init];
    
    [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backButton setTitle:@"" forState:UIControlStateNormal];
    [_backButton setTintColor:[UIColor whiteColor]];
    
}



@end
