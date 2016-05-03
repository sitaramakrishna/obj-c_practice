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

+ (id)sharedService {
    
    static DataService *sharedDataService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataService = [[self alloc]init];
    });
    
    return sharedDataService;
}

- (id)init {
    if (self = [super init]) {
        
        _loadedPosts = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}

-(void)savePosts {
    
    NSData *postsData = [NSKeyedArchiver archivedDataWithRootObject:_loadedPosts];
    [[NSUserDefaults standardUserDefaults]setObject:postsData forKey:@"posts"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(void)loadPosts {
    
    NSData *postsData = [[NSUserDefaults standardUserDefaults]objectForKey:@"posts"];
    if (postsData) {
        NSMutableArray *postsArray = [NSKeyedUnarchiver unarchiveObjectWithData:postsData];
        if (postsArray) {
            _loadedPosts = postsArray;
            
        } else {
            NSLog(@"We have no posts array");
        }
    } else {
        NSLog(@"We have no posts data");
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postsLoaded" object:nil];
    
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
    
    [_loadedPosts addObject:post];
    NSLog(@"addPost: %@", _loadedPosts.debugDescription);
    NSLog(@"addPost2: %@", _loadedPosts.debugDescription);
    [self savePosts];
    [self loadPosts];
    
}

-(NSString *)documentsPathForFileName:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *fullPath = paths[0];
    return [fullPath stringByAppendingPathComponent:name];
    
}

@end







