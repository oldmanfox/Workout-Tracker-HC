//
//  UIViewController+Social.h
//  90 DWT 2
//
//  Created by Grant, Jared on 11/19/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <Social/Social.h>

@interface UIViewController (Social)
- (BOOL)connectedToNetwork;
- (void)facebook;
- (void)twitter;

@end
