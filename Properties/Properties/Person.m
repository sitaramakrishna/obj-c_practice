//
//  Person.m
//  Properties
//
//  Created by David Perkins on 4/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void)test {
    self.firstName = @"Bob";
    
    _firstName = @"Jack";
    
    isInsecure = YES;
    
    [self setLastName:@"Davis"];
}

@end
