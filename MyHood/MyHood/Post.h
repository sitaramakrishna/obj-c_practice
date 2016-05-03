//
//  Post.h
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject <NSCoding>

@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *postDesc;

- (id)initWithImagePath:(NSString *)imagePath title:(NSString *)title description:(NSString *)description;

- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
