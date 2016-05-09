//
//  Groceries.m
//  Singletons
//
//  Created by David Perkins on 5/8/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Groceries.h"

@implementation Groceries

+(id)sharedInstance {
    
    static Groceries *instance = nil;
    
    @synchronized (self) {
        
        if (instance == nil) {
            instance = [[self alloc]init];
        }
        
    }
    
    return instance;
}

-(id)init {
    
    if (self = [super init]) {
        
        self.groceryList = [NSMutableArray arrayWithObjects:@"Protein Powder", @"Milk", @"Bananas", @"More Protein Powder", @"Peanut Butter", nil];
        
    }
    
    return self;
}

@end
