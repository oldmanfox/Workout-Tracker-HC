//
//  90DWTBBIAPHelper.m
//  60 DWT HC
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "60DWTHCIAPHelper.h"

@implementation _0DWTHCIAPHelper

+ (_0DWTHCIAPHelper *)sharedInstance {
    
    static dispatch_once_t once;
    static _0DWTHCIAPHelper * sharedInstance;
    
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects: @"com.grantdevelopers.60DWTHC.removeads",
                                                            @"com.grantdevelopers.60DWTHC.graphview", nil];
        
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    
    return sharedInstance;
}

@end
