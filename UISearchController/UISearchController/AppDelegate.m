//
//  AppDelegate.m
//  UISearchController
//
//  Created by David Perkins on 5/22/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "UIColor+ColorExtensions.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UISplitViewController *splitViewController = (UISplitViewController *)_window.rootViewController;
    UINavigationController *navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    
    [[UISearchBar appearance]setBarTintColor:[UIColor candyGreen]];
    [[UISearchBar appearance]setTintColor:[UIColor whiteColor]];
//    [[UITextField appearanceWhenContainedInInstancesOfClasses:(UISearchBar.self)] setTintColor:[UIColor candyGreen]];
    
    return YES;
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    UINavigationController *secondaryAsNavController = (UINavigationController *)secondaryViewController;
    if (!secondaryAsNavController) {
        return false;
    }
    
    DetailViewController *topAsDetailController = (DetailViewController *)secondaryAsNavController.topViewController;
    if (!topAsDetailController) {
        return false;
    }
    
    if (!topAsDetailController.detailCandy) {
        // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return true;
    }
    
    return false;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
