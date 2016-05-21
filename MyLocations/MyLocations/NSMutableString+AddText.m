//
//  NSMutableString+AddText.m
//  MyLocations
//
//  Created by David Perkins on 5/20/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "NSMutableString+AddText.h"

@implementation NSMutableString (AddText)

- (void)addText:(NSString *)text withSeparator:(NSString *)separator
{
    if (text != nil) {
        if ([self length] > 0) {
            [self appendString:separator];
        }
        [self appendString:text];
    }
}

@end
