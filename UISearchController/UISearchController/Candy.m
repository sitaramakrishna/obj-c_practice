//
//  Candy.m
//  UISearchController
//
//  Created by David Perkins on 5/22/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Candy.h"

@implementation Candy

-(id)initWithCategory:(NSString *)category andName:(NSString *)name {
    
    if (self == [super init]) {
        
        self.category = category;
        self.name = name;
        
    }
    
    return self;
}

@end
