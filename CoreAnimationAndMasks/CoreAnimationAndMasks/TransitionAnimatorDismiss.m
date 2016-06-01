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
{
    UIView *circle;
    ViewController *vc;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    NSLog(@"animateTransitionDismiss");
    
    // Doing the same thing, but in reverse
    UIView *returningControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    CGPoint originalCenter = returningControllerView.center;
    CGSize originalSize = returningControllerView.frame.size;
    
    circle.frame = [self frameForCircle:originalCenter size:originalSize start:vc.micButton.center];
    circle.layer.cornerRadius = circle.frame.size.height / 2;
    circle.center = self.origin;
    circle.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
        returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        returningControllerView.center = self.origin;
        returningControllerView.alpha = 0;
    } completion:^(BOOL finished) {
        [returningControllerView removeFromSuperview];
        [circle removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
    
    
//    ViewController *destinationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    UIView *containerView = (UIView *)[transitionContext containerView];
//    destinationController.view.alpha = 0.0;
//    [containerView addSubview:destinationController.view];
//    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        
//        destinationController.view.alpha = 1.0;
//        
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
}

-(CGRect)frameForCircle:(CGPoint)center size:(CGSize)size start:(CGPoint)start {
    
    double lengthX = fmax(start.x, size.width - start.x);
    double lengthY = fmax(start.y, size.height - start.y);
    double offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
    CGSize aSize = CGSizeMake(offset, offset);
    
    return CGRectMake(0, 0, aSize.width, aSize.height);
}

@end
