//
//  TransitionDelegate.m
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TransitionDelegate.h"
#import "TransitionAnimator.h"
#import "TransitionAnimatorDismiss.h"

@interface TransitionDelegate ()

@property (nonatomic, strong) TransitionAnimator *animator;
@property (nonatomic, strong) TransitionAnimatorDismiss *dismiss;

@end

@implementation TransitionDelegate

-(id)init {
    
    if (self = [super init]) {
        
        _animator = [[TransitionAnimator alloc]init];
        _dismiss = [[TransitionAnimatorDismiss alloc]init];
        
    }
    
    return self;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    NSLog(@"animationControllerForPresentedController");
    
    return _animator;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return _dismiss;
}

@end
