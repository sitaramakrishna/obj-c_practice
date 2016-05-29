//
//  PopAnimator.h
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/28/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PopTransitionMode) {
    PopTransitionModePresent,
    PopTransitionModeDismiss
};

@interface PopAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) PopTransitionMode transitionMode;
@property (nonatomic, strong) UIView *circle;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic) CGPoint origin;
@property (nonatomic) float presentDuration;
@property (nonatomic) float dismissDuration;


@end

