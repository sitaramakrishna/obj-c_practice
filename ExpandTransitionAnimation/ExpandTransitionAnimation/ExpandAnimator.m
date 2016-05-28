//
//  ExpandAnimator.m
//  ExpandTransitionAnimation
//
//  Created by David Perkins on 5/27/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ExpandAnimator.h"

@implementation ExpandAnimator

-(id)init {
    
    if (self = [super init]) {
        
        _presentDuration = 0.4;
        _dismissDuration = 0.15;
        _transitionMode = ExpandTransitionModePresent;
        
    }
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (_transitionMode == ExpandTransitionModePresent) {
        return _presentDuration;
    } else {
        return _dismissDuration;
    }
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // From view controller
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect fromViewFrame = fromViewController.view.frame;
    
    // To view controller
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Container view
    UIView *containerView = [transitionContext containerView];
    
    if (_transitionMode == ExpandTransitionModePresent) {
        
        // Get top view using resizableSnapshotViewFromRect
        _topView = [fromViewController.view resizableSnapshotViewFromRect:fromViewFrame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsMake(_openingFrame.origin.y, 0, 0, 0)];
        _topView.frame = CGRectMake(0, 0, fromViewFrame.size.width, _openingFrame.origin.y);
        
        // Add top view to container
        [containerView addSubview:_topView];
        
        // Get bottom view using resizableSnapshotViewFromRect
        _bottomView = [fromViewController.view resizableSnapshotViewFromRect:fromViewFrame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsMake(0, 0, fromViewFrame.size.height - _openingFrame.origin.y - _openingFrame.size.height, 0)];
        _bottomView.frame = CGRectMake(0, _openingFrame.origin.y + _openingFrame.size.height, fromViewFrame.size.width, fromViewFrame.size.height = _openingFrame.origin.y = _openingFrame.size.height);
        
        // Add bottom view to container
        [containerView addSubview:_bottomView];
        
        // Take a snapshot of the to view controller and change its frame to opening frame
        UIView *snapshotView = [toViewController.view resizableSnapshotViewFromRect:fromViewFrame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
        snapshotView.frame = _openingFrame;
        [containerView addSubview:snapshotView];
        
        toViewController.view.alpha = 0.0;
        [containerView addSubview:toViewController.view];
        
        [UIView animateWithDuration:_presentDuration animations:^{
            
            // Move top and bottom views out of the screen
            self.topView.frame = CGRectMake(0, -self.topView.frame.size.height, self.topView.frame.size.width, self.topView.frame.size.height);
            self.bottomView.frame = CGRectMake(0, fromViewFrame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.width);
            
            // Expand snapshot view to fill entire frame
            snapshotView.frame = toViewController.view.frame;
            
        } completion:^(BOOL finished) {
            
            // Remove snapshot view from container view
            [snapshotView removeFromSuperview];
            
            // Make to view controller visible
            toViewController.view.alpha = 1.0;
            
            // Complete transition
            [transitionContext completeTransition:finished];
        }];
    } else {
        
        UIView *snapshotView = [fromViewController.view resizableSnapshotViewFromRect:fromViewController.view.bounds afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
        [containerView addSubview:snapshotView];
        
        fromViewController.view.alpha = 0.0;
        
        [UIView animateWithDuration:_dismissDuration animations:^{
            
            self.topView.frame = CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height);
            self.bottomView.frame = CGRectMake(0, fromViewController.view.frame.size.height - self.bottomView.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
            snapshotView.frame = self.openingFrame;
            
        } completion:^(BOOL finished) {
            
            // Remove snapshot view from container view
            [snapshotView removeFromSuperview];
            
            // Make to view controller visible
            toViewController.view.alpha = 0.0;
            
            // Complete transition
            [transitionContext completeTransition:finished];
            
        }];
        
    }
}

@end






