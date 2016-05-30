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

@property (weak, nonatomic) IBOutlet UIImageView *googleLogo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoCenterYConst;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additiPonal setup after loading the view.
    
    _transition = [[PopAnimator alloc]init];
    
    _logoCenterYConst.constant = -120;
    [self.view layoutIfNeeded];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _logoCenterYConst.constant = 120;
    
    [UIView animateWithDuration:3.2 animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}



@end
