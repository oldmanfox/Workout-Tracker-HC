//
//  UITableViewController+Database.h
//  60 DWT HC
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Workout.h"
#import "WorkoutCompleteDate.h"

@interface UITableViewController (Database)

-(void)exerciseMatches:(NSArray*)exerciseTitlesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)prevNotesArray :(NSArray*)curNotesArray;
-(void)saveToDatabase:(NSArray*)exerciseNameArray :(NSArray*)repLabelArray :(NSArray*)currentTFArray :(NSArray*)curNotesArray;
-(void)saveWorkoutComplete:(NSDate*)useDate;
-(void)saveWorkoutCompleteWithArguments:(NSNumber*)workoutIndex :(NSString*)routine :(NSString*)workout;
-(void)deleteDate;
-(void)deleteDateWithArguments:(NSNumber*)workoutIndex :(NSString*)routine :(NSString*)workout;
-(BOOL)workoutCompleted;
-(BOOL)workoutCompletedWithArguments:(NSNumber*)workoutIndex :(NSString*)routine :(NSString*)workout;
-(NSString*)getWorkoutCompletedDate;
-(void)saveDataNavControllerToAppDelegate;
//-(void)saveTextFieldToDatabase:(NSArray)
@end
