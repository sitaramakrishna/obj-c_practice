//
//  DataService.m
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataService.h"
#import "Post.h"

@implementation DataService

-(id)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
    
}

-(void)savePosts {
    
    NSLog(@"savePosts %@", _loadedPosts);
    NSData *postsData = [NSKeyedArchiver archivedDataWithRootObject:_loadedPosts];
    [[NSUserDefaults standardUserDefaults]setObject:postsData forKey:@"posts"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(void)loadPosts {
    
    NSData *postsData = [[NSUserDefaults standardUserDefaults]objectForKey:@"posts"];
    NSMutableArray *postsArray = [NSKeyedUnarchiver unarchiveObjectWithData:postsData];
    
    if (postsData) {
        if (postsArray) {
            _loadedPosts = postsArray;
        }
    }
    
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"postsLoaded" object:nil]];
}

-(NSString *)saveImageAndCreatePath : (UIImage *)image {
    
    NSData *imgData = UIImagePNGRepresentation(image);
    NSString *imgPath = [NSString stringWithFormat:@"image%f.png", [NSDate timeIntervalSinceReferenceDate]];
    NSString *fullPath = [self documentsPathForFileName:imgPath];
    [imgData writeToFile:fullPath atomically:true];
    return imgPath;
    
}

-(UIImage *)imageForPath : (NSString *)path {
    
    NSString *fullPath = [self documentsPathForFileName:path];
    UIImage *image = [UIImage imageNamed:fullPath];
    return image;
    
}

-(void)addPost:(Post *)post {
    
    
    NSLog(@"addPost %@", post.title);
    [_loadedPosts addObject:post];
    NSLog(@"addPost2 %@", _loadedPosts);
    [self savePosts];
    [self loadPosts];
    
}

-(NSString *)documentsPathForFileName:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *fullPath = paths[0];
    return [fullPath stringByAppendingPathComponent:name];
    
    
}

@end







