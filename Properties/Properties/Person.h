//
//  Person.h
//  Properties
//
//  Created by David Perkins on 4/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    // define instance variables here. These are only accessible to the class.
    BOOL isInsecure;
}

// Things we want publicly available to all classes that want to interact with Person
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end
