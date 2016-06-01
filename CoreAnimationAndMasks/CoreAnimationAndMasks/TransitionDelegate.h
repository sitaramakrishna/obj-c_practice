//
//  TransitionDelegate.h
//  CoreAnimationAndMasks
//
//  Created by David Perkins on 5/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) CGPoint origin;

@end
