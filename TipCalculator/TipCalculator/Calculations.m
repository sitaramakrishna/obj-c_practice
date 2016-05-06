//
//  Calculations.m
//  TipCalculator
//
//  Created by David Perkins on 5/5/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "Calculations.h"

@implementation Calculations


// Tip amount label
-(float)findTipFromSubtotal:(float)subtotal andTipPercent:(float)tipPercent {
    
    return [[NSString stringWithFormat:@"%.2f", (subtotal) * (tipPercent / 100)]floatValue];
}

// Total label
-(float)findTotalFromSubtotal:(float)subtotal andTipPercent:(float)tipPercent {
    
    return [[NSString stringWithFormat:@"%.2f", (subtotal + (subtotal * (tipPercent/100)))]floatValue];
    
}


@end
