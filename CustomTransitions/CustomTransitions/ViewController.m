//
//  ViewController.m
//  CustomTransitions
//
//  Created by David Perkins on 5/25/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "PopAnimator.h"
#import "SecondViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) PopAnimator *transition;
- (IBAction)firstButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _transition = [[PopAnimator alloc]init];
    
}

-(void)viewWillLayoutSubviews {
    _firstButton.layer.cornerRadius = _firstButton.frame.size.width / 2;
    _secondButton.layer.cornerRadius = _secondButton.frame.size.width / 2;
    _thirdButton.layer.cornerRadius = _thirdButton.frame.size.width / 2;
    _fourthButton.layer.cornerRadius = _fourthButton.frame.size.width / 2;
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)buttonPressed:(id)sender {
    
    self.selectedButton = sender;
    
    [self performSegueWithIdentifier:@"modalSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SecondViewController *controller = (SecondViewController *)segue.destinationViewController;
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
}

// Unwind segue from SecondViewController
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
    SecondViewController *controller = segue.sourceViewController;
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
}

// Delegate method for presenting view controller
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    _transition.transitionMode = PopTransitionModePresent;
    _transition.origin = _selectedButton.center;
    _transition.circleColor = _selectedButton.backgroundColor;
    
    return _transition;
    
}

// Delegate method for dismissing view controller
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    _transition.transitionMode = PopTransitionModeDismiss;
    _transition.origin = _selectedButton.center;
    _transition.circleColor = _selectedButton.backgroundColor;
    
    return _transition;
}

@end







