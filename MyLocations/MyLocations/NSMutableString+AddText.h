//
//  NSMutableString+AddText.h
//  MyLocations
//
//  Created by David Perkins on 5/20/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (AddText)

-(void)addText:(NSString *)text withSeparator:(NSString *)separator;

@end
