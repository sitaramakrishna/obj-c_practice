//
//  TransitionAnimatorDismiss.m
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TransitionAnimatorDismiss.h"
#import "ViewController.h"

@implementation TransitionAnimatorDismiss

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    NSLog(@"animateTransitionDismiss");
    
    ViewController *destinationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = (UIView *)[transitionContext containerView];
    destinationController.view.alpha = 0.0;
    [containerView addSubview:destinationController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        destinationController.view.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

@end
