//
//  HudView.h
//  MyLocations
//
//  Created by David Perkins on 5/16/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView

+(instancetype)hudInView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic, strong) NSString *text;

@end
