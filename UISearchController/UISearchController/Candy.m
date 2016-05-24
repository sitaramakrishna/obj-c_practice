//
//  Candy.m
//  UISearchController
//
//  Created by David Perkins on 5/22/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Candy.h"

@implementation Candy

+(id)sharedInstance {
    
    static Candy *instance = nil;
    
    @synchronized (self) {
        
        if (instance == nil) {
            instance = [[self alloc]init];
        }
        
    }
    
    return instance;
}

-(id)init {
    
    if (self = [super init]) {
        
        self.arrayOfCandy = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}


@end
