//
//  Groceries.h
//  Singletons
//
//  Created by David Perkins on 5/8/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Groceries : NSObject

+(id)sharedInstance; // Our singleton
@property (nonatomic, strong) NSMutableArray *groceryList;

@end
