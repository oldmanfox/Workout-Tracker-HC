//
//  MainTBC.h
//  90 DWT 1
//
//  Created by Grant, Jared on 12/10/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTBC : UITabBarController
@property BOOL workoutChanged;
@property (strong, nonatomic) NSString *bandSetting;  // Set weight fields to alphanumeric or numberpad.  Default = (Off) numberpad.

@end
