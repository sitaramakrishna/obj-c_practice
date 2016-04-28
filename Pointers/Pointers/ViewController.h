//
//  ViewController.h
//  Pointers
//
//  Created by David Perkins on 4/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSString *name; // this is a pointer variable, USE IT ON CLASS OBJECTS
@property (nonatomic) int age; // not a pointer variable, this is a native C type
@property (nonatomic) NSInteger debt;
@property (nonatomic) NSNumber *bankBalance;

@end

