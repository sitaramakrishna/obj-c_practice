//
//  SecondViewController.m
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "PopAnimator.h"
#import "TransitionDelegate.h"

@interface SecondViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PopAnimator *transition;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIImageView *googleLogo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoCenterYConst;
@property (weak, nonatomic) IBOutlet UILabel *speakNowLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButtonTapped:(id)sender;
@property (nonatomic, strong) TransitionDelegate *transitionDelegate;

@end

@implementation SecondViewController
{
    UIView *blueDot;
    UIView *redDot;
    UIView *yellowDot;
    UIView *greenDot;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additiPonal setup after loading the view.
    
    _transitionDelegate = [[TransitionDelegate alloc]init];
    
    _logoCenterYConst.constant = -105;
    [self.view layoutIfNeeded];
    
    _speakNowLabel.font = [UIFont fontWithName:@"Roboto-Light" size:25];
    _speakNowLabel.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    
    UIColor *googleBlue = [UIColor colorWithRed:72.0f/255.0f green:133.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
    UIColor *googleRed = [UIColor colorWithRed:219.0f/255.0f green:50.0f/255.0f blue:54.0f/255.0f alpha:1.0f];
    UIColor *googleYellow = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:13.0f/255.0f alpha:1.0f];
    UIColor *googleGreen = [UIColor colorWithRed:60.0f/255.0f green:186.0f/255.0f blue:84.0f/255.0f alpha:1.0f];
    
    blueDot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    blueDot.center = CGPointMake(self.view.center.x - 60, _googleLogo.center.y);
    blueDot.backgroundColor = googleBlue;
    blueDot.layer.cornerRadius = blueDot.frame.size.width / 2;
    blueDot.alpha = 0.0;
    [self.view addSubview:blueDot];
    
    redDot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    redDot.center = CGPointMake(self.view.center.x - 20, _googleLogo.center.y);
    redDot.backgroundColor = googleRed;
    redDot.layer.cornerRadius = redDot.frame.size.width / 2;
    redDot.alpha = 0.0;
    [self.view addSubview:redDot];
    
    yellowDot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    yellowDot.center = CGPointMake(self.view.center.x + 20, _googleLogo.center.y);
    yellowDot.backgroundColor = googleYellow;
    yellowDot.layer.cornerRadius = yellowDot.frame.size.width / 2;
    yellowDot.alpha = 0.0;
    [self.view addSubview:yellowDot];
    
    greenDot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    greenDot.center = CGPointMake(self.view.center.x + 60, _googleLogo.center.y);
    greenDot.backgroundColor = googleGreen;
    greenDot.layer.cornerRadius = greenDot.frame.size.width / 2;
    greenDot.alpha = 0.0;
    [self.view addSubview:greenDot];
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    
    _logoCenterYConst.constant = 160;
    
    CGRect newFrame = _googleLogo.frame;
    newFrame.size.height = 10;
    newFrame.size.width = 60;
    
    _googleLogo.translatesAutoresizingMaskIntoConstraints = YES;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _googleLogo.frame = newFrame;
        _googleLogo.center = CGPointMake(self.view.center.x, self.view.center.y + 160);
        
        blueDot.alpha = 1.0;
        redDot.alpha = 1.0;
        yellowDot.alpha = 1.0;
        greenDot.alpha = 1.0;
        _googleLogo.alpha = 0.0;
        
        blueDot.center = CGPointMake(blueDot.center.x + 30, self.view.center.y + 160);
        redDot.center = CGPointMake(redDot.center.x + 10, self.view.center.y + 160);
        yellowDot.center = CGPointMake(yellowDot.center.x - 10, self.view.center.y + 160);
        greenDot.center = CGPointMake(greenDot.center.x - 30, self.view.center.y + 160);
        
        
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            
            blueDot.center = CGPointMake(blueDot.center.x, blueDot.center.y + 20);
            
        } completion:nil];
        
        [UIView animateWithDuration:1.0 delay:0.1 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            
            redDot.center = CGPointMake(redDot.center.x, redDot.center.y + 20);
            
        } completion:nil];
        
        [UIView animateWithDuration:1.0 delay:0.2 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            
            yellowDot.center = CGPointMake(yellowDot.center.x, yellowDot.center.y + 20);
            
        } completion:nil];
        
        [UIView animateWithDuration:1.0 delay:0.3 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            
            greenDot.center = CGPointMake(greenDot.center.x, greenDot.center.y + 20);
            
        } completion:nil];
        
    }];
    
    
}




@end






