//
//  ViewController.h
//  BlockDemo
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSString *(^blockOne)(NSString *);
-(void)testBlockStorageType;

@end

