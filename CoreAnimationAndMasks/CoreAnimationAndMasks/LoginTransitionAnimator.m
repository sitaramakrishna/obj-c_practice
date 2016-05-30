//
//  LoginTransitionAnimator.m
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "LoginTransitionAnimator.h"
#import "ViewController.h"

@implementation LoginTransitionAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    ViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *destinationView = destinationController.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:destinationController.view];
    
    CGRect buttonFrame = fromViewController.micButton.frame;
    CGRect endFrame = CGRectMake(-CGRectGetWidth(destinationView.frame)/2, -CGRectGetHeight(destinationView.frame)/2, CGRectGetWidth(destinationView.frame)*2, CGRectGetHeight(destinationView.frame)*2);
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:destinationView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:buttonFrame];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = destinationView.frame;
    maskLayer.path = maskPath.CGPath;
    destinationController.view.layer.mask = maskLayer;
    
    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:endFrame];
    
    CABasicAnimation *pathAnimation = [[CABasicAnimation alloc]init];
    pathAnimation.keyPath = @"path";
    pathAnimation.delegate = self;
    pathAnimation.fromValue = (__bridge id _Nullable)(maskPath.CGPath);
    pathAnimation.toValue = bigCirclePath;
    pathAnimation.duration = [self transitionDuration:transitionContext];
    maskLayer.path = bigCirclePath.CGPath;
    [maskLayer addAnimation:pathAnimation forKey:@"pathAnimation"];

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.transitionContext != nil) {
        
        BOOL wasCancelled = [_transitionContext transitionWasCancelled];
        
//        [self.transitionContext completeTransition:[_transitionContext transitionWasCancelled]];
    }
    
}

@end




