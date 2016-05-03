//
//  ViewController.h
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 

-(void)onPostsLoaded:(id)notif;

@end

