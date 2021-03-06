//
//  Candy.h
//  UISearchController
//
//  Created by David Perkins on 5/22/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject

+(id)sharedInstance; // Our singleton
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *arrayOfCandy;

@end
