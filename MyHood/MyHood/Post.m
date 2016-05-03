//
//  Post.m
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Post.h"

@implementation Post

- (id)initWithImagePath:(NSString *)imagePath title:(NSString *)title description:(NSString *)description {
    
    if (self = [super init]) {
        self.imagePath = imagePath;
        self.title = title;
        self.postDesc = description;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.imagePath = [aDecoder decodeObjectForKey:@"imagePath"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.postDesc = [aDecoder decodeObjectForKey:@"description"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.imagePath forKey:@"imagePath"];
    [aCoder encodeObject:self.postDesc forKey:@"description"];
    [aCoder encodeObject:self.title forKey:@"title"];
    
}

@end

     
     
     
     
     
     
