//
//  UIViewController+CoreData.h
//  90 DWT 1
//
//  Created by Jared Grant on 5/8/13.
//  Copyright (c) 2013 Grant, Jared. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Workout.h"
#import "WorkoutCompleteDate.h"

@interface UIViewController (CoreData)

- (NSArray *)databaseMatches;
-(void)saveWorkoutComplete:(NSDate*)useDate;
-(void)deleteDate;
-(void)saveDataNavControllerToAppDelegate;
-(BOOL)workoutCompleted;
-(NSString*)getWorkoutCompletedDate;
@end
