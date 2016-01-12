//
//  DataNavController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTBC.h"

@interface DataNavController : UINavigationController
@property (strong, nonatomic) NSString *month;      // Current month.
@property (strong, nonatomic) NSString *routine;    // Current workout routine (Normal, 2-A-Days, or Tone).
@property (strong, nonatomic) NSString *week;       // Current week of workout.
@property (strong, nonatomic) NSString *workout;    // Full name of an individual workout.
@property (strong, nonatomic) NSNumber *index;      // The number of times this workout has been done.

@property (strong, nonatomic) NSArray *negativeLower;    // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSArray *negativeUpper;  // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSArray *agilityUpper;  // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSArray *agilityLower;  // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSArray *devastator;  // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSArray *completeFitness;  // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSArray *theGoal;  // List of exercises for this workout with round added to it.
@property (strong, nonatomic) NSString *lightCell5;  // ((Week 8 or 13) AND routine = Lean) = Full on Cardio.  Else = Core Fitness.
@end
