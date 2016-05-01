//
//  main.m
//  Protocols
//
//  Created by David Perkins on 4/30/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bicycle.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Bicycle *bike = [[Bicycle alloc] init];
        [bike startPedaling];
        [bike signalLeftTurn];
        [bike signalStop];
        [bike lockToStructure:nil];
        
    }
    
    return 0;
}
