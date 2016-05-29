//
//  ViewController.m
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "PopAnimator.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *googleLogo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoCenterYConst;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldWidthConst;

@property (nonatomic, strong) UIButton *micButton;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) PopAnimator *transition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _transition = [[PopAnimator alloc]init];
    
    _textField.layer.shadowColor = [UIColor blackColor].CGColor;
    _textField.layer.shadowOffset = CGSizeMake(0, 1);
    _textField.layer.shadowOpacity = 0.2;
    _textField.layer.shadowRadius = 1.0;
    _textField.layer.cornerRadius = 2.0;
    _textField.layer.masksToBounds = NO;
    _textField.alpha = 0;
    
    _micButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-30, self.view.center.y, 60, 60)];
    _micButton.backgroundColor = [UIColor whiteColor];
    _micButton.layer.shadowRadius = 1.0;
    _micButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _micButton.layer.shadowOpacity = 0.2;
    _micButton.layer.shadowOffset = CGSizeMake(0, 1);
    _micButton.layer.cornerRadius = _micButton.frame.size.width / 2;
    [_micButton setImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    _micButton.imageView.contentScaleFactor = UIViewContentModeScaleAspectFit;
    _micButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_micButton addTarget:self action:@selector(microphoneTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_micButton];
    

}

-(void)viewDidAppear:(BOOL)animated {
    
    [self.view layoutIfNeeded];
    
    _logoCenterYConst.constant = -120;
    _textFieldWidthConst.constant = 300;
    _textField.alpha = 1;
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _micButton.frame = CGRectMake(self.view.center.x-30, self.view.center.y+50, 60, 60);
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        _logoCenterYConst.constant = -105;
        
        [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [self.view layoutIfNeeded];
            
        } completion:nil];
        
    }];
}
     

-(void)microphoneTapped {
    
    [self performSegueWithIdentifier:@"segue" sender:self];
    
    [self.view layoutIfNeeded];
    
    _logoCenterYConst.constant = 120;
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame: _googleLogo.frame];
    newImageView.image = [UIImage imageNamed:@"googleDots"];
    newImageView.alpha = 0.0;
    [_googleLogo.superview insertSubview: newImageView aboveSubview: _googleLogo];

    
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        newImageView.alpha = 1.0;
        _googleLogo.alpha = 0.0;
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
    
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
    
    [self.view layoutIfNeeded];
    
    _logoCenterYConst.constant = -120;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

// Delegate method for presenting view controller
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    NSLog(@"animationControllerForPresentedController");
    _transition.transitionMode = PopTransitionModePresent;
    _transition.origin = _micButton.center;
    _transition.circleColor = _micButton.backgroundColor;
    
    return _transition;
    
}

// Delegate method for dismissing view controller
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    NSLog(@"animationControllerForPresentedController");
    _transition.transitionMode = PopTransitionModeDismiss;
    _transition.origin = _micButton.center;
    _transition.circleColor = _micButton.backgroundColor;
    
    return _transition;
}


@end
