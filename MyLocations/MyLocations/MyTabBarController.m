//
//  MyTabBarController.m
//  MyLocations
//
//  Created by David Perkins on 5/21/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    
    return nil;
}



@end
