//
//  Person.m
//  Initializers
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Person.h"

@implementation Person

-(id)initWIthFirstName:(NSString *)first lastName:(NSString *)last {
    
    self.firstName = first;
    self.lastName = last;
    
    self = [super init];
    
    return [self initWithAge:54];
    
}

-(id)initWithAge:(NSInteger)age {
    
    self = [super init];
    
    return self;
    
}

-(void)printName {
    NSLog(@"%@ %@", self.firstName, self.lastName);
}

@end
