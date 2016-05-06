//
//  Movies.m
//  TableViews
//
//  Created by David Perkins on 5/6/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Movies.h"

@implementation Movies

-(id)init {
    
    if (self = [super init]) {
        
        self.favoriteMovies = [NSArray arrayWithObjects:@"Dodgeball", @"Field Of Dreams", @"The Shawshank Redemption", @"Step Brothers", @"I Love You, Man", nil];
        
    }
    
    return self;
}

@end
