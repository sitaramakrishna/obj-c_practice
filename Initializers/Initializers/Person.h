//
//  Person.h
//  Initializers
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
-(void)printName;
-(id)initWIthFirstName:(NSString *)first lastName:(NSString *)last;

@end
