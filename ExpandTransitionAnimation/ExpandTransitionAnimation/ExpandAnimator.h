//
//  ExpandAnimator.h
//  ExpandTransitionAnimation
//
//  Created by David Perkins on 5/27/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExpandAnimator : NSObject <UIViewControllerAnimatedTransitioning>

typedef NS_ENUM(NSInteger, ExpandTransitionMode) {
    ExpandTransitionModePresent,
    ExpandTransitionModeDismiss
};

+(ExpandAnimator *)animator;
@property (nonatomic) float presentDuration;
@property (nonatomic) float dismissDuration;
@property (nonatomic) CGRect openingFrame;
@property (nonatomic) ExpandTransitionMode transitionMode;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;


@end
