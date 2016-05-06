//
//  Calculations.h
//  TipCalculator
//
//  Created by David Perkins on 5/5/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject

-(float)findTipFromSubtotal:(float)subtotal andTipPercent:(float)tipPercent;
-(float)findTotalFromSubtotal:(float)subtotal andTipPercent:(float)tipPercent;

@end
