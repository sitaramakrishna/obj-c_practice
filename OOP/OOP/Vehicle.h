//
//  Vehicle.h
//  OOP
//
//  Created by David Perkins on 4/29/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject
@property (nonatomic, strong) NSString *make;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *engineSize;
-(void)drive;
@end
