//
//  PopAnimator.m
//  CustomTransitions
//
//  Created by David Perkins on 5/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "PopAnimator.h"

@implementation PopAnimator

-(id)init {
    
    if (self = [super init]) {
        
        _transitionMode = PopTransitionModePresent;
        _presentDuration = 0.3;
        _dismissDuration = 0.2;
        
    }
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Set transition duration based on whether it is a presenting transition or dismissing transition
    if (_transitionMode == PopTransitionModePresent) {
        return _presentDuration;
    } else {
        return _dismissDuration;
    }
    
}

-(CGRect)frameForCircle:(CGPoint)center size:(CGSize)size start:(CGPoint)start {
    
    double lengthX = fmax(start.x, size.width - start.x);
    double lengthY = fmax(start.y, size.height - start.y);
    double offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
    CGSize aSize = CGSizeMake(offset, offset);
    
    return CGRectMake(0, 0, aSize.width, aSize.height);
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    if (_transitionMode == PopTransitionModePresent) {
        
        // Get view of view controller being presented
        UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint originalCenter = presentedView.center;
        CGSize originalSize = presentedView.frame.size;
        
        // Get frame of circle
        _circle = [[UIView alloc] initWithFrame:[self frameForCircle:originalCenter size:originalSize start:_origin]];
        _circle.layer.cornerRadius = _circle.frame.size.height / 2;
        _circle.center = _origin;
        
        // Make it very small
        _circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
        // Set background color
        _circle.backgroundColor = _circleColor;
        
        // Add circle to container view
        [containerView addSubview:_circle];
        
        // Make presented view very small and transparent
        presentedView.center = _origin;
        presentedView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
        // Set background color
        presentedView.backgroundColor = _circleColor;
        
        // Add presented view to container view
        [containerView addSubview:presentedView];
        
        // Animate both views
        [UIView animateWithDuration:_presentDuration animations:^{
            self.circle.transform = CGAffineTransformMakeScale(1.0, 1.0);
            presentedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            presentedView.center = originalCenter;
        } completion:^(BOOL finished) {
            // On completion, complete the transition
            [transitionContext completeTransition:YES];
        }];
    } else {
        
        // Doing the same thing, but in reverse
        UIView *returningControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        CGPoint originalCenter = returningControllerView.center;
        CGSize originalSize = returningControllerView.frame.size;
        
        _circle.frame = [self frameForCircle:originalCenter size:originalSize start:_origin];
        _circle.layer.cornerRadius = _circle.frame.size.height / 2;
        _circle.center = _origin;
        
        [UIView animateWithDuration:_dismissDuration animations:^{
            self.circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningControllerView.center = self.origin;
            returningControllerView.alpha = 0;
        } completion:^(BOOL finished) {
            [returningControllerView removeFromSuperview];
            [self.circle removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

@end








