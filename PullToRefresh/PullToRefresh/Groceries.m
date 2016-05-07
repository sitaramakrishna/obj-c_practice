//
//  Groceries.m
//  PullToRefresh
//
//  Created by David Perkins on 5/6/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Groceries.h"

@implementation Groceries

-(id)init {
    
    if (self = [super init]) {
        
        self.groceryList = [NSMutableArray arrayWithObjects:@"Protein Powder", @"Milk", @"Bananas", @"More Protein Powder", @"Peanut Butter", nil];
        
    }
    
    return self;
}

@end
