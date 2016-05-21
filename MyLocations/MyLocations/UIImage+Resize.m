//
//  UIImage+Resize.m
//  MyLocations
//
//  Created by David Perkins on 5/20/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

// First calculates how big the image can be in order to fit inside the bounds rectangle, then creates a new image context and draws the image into that
-(UIImage *)resizedImageWithBounds:(CGSize)bounds {
    
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio = MIN(horizontalRatio, verticalRatio);
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);

    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
     
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

@end
