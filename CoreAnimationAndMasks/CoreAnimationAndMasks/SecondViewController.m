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
    
    _logoCenterYConst.constant = -105;
    [self.view layoutIfNeeded];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _logoCenterYConst.constant = 160;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    UIColor *googleBlue = [UIColor colorWithRed:72.0f/255.0f green:133.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
    UIColor *googleRed = [UIColor colorWithRed:219.0f/255.0f green:50.0f/255.0f blue:54.0f/255.0f alpha:1.0f];
    UIColor *googleYellow = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:13.0f/255.0f alpha:1.0f];
    UIColor *googleGreen = [UIColor colorWithRed:60.0f/255.0f green:186.0f/255.0f blue:84.0f/255.0f alpha:1.0f];
    
    CAShapeLayer *blueDot = [CAShapeLayer layer];
    [blueDot setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(_googleLogo.frame.origin.x + 10, _googleLogo.frame.origin.y + 10, 10, 10)] CGPath]];
    [blueDot setStrokeColor: googleBlue.CGColor];
    [blueDot setFillColor:googleBlue.CGColor];
    [[self.view layer] addSublayer:blueDot];
    
    CAShapeLayer *redDot = [CAShapeLayer layer];
    [redDot setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(_googleLogo.frame.origin.x + 30, _googleLogo.frame.origin.y + 10, 10, 10)] CGPath]];
    [redDot setStrokeColor: googleRed.CGColor];
    [redDot setFillColor:googleRed.CGColor];
    [[self.view layer] addSublayer:redDot];
    
    
    
}



@end
