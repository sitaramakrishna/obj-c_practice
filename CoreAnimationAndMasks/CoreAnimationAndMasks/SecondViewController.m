//
//  SecondViewController.m
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "SecondViewController.h"
#import "PopAnimator.h"

@interface SecondViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PopAnimator *transition;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additiPonal setup after loading the view.
    
    _transition = [[PopAnimator alloc]init];
    
}



@end
