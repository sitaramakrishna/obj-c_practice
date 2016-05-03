//
//  DataService.h
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Post.h"

@interface DataService : NSObject

@property (nonatomic, strong) DataService *instance;
@property (nonatomic, strong) NSMutableArray *loadedPosts;

-(void)savePosts;
-(void)loadPosts;
-(NSString *)saveImageAndCreatePath : (UIImage *)image;
-(UIImage *)imageForPath : (NSString *)path;
-(void)addPost:(Post *)post;
-(NSString *)documentsPathForFileName:(NSString *)name;

@end









