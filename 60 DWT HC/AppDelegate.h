//
//  AppDelegate.h
//  60 DWT HC
//
//  Created by Grant, Jared on 1/5/16.
//  Copyright © 2016 Grant, Luana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *month;          // Current month.
@property (strong, nonatomic) NSString *routine;        // Current workout routine (Normal, 2-A-Days, or Tone).
@property (strong, nonatomic) NSString *week;           // Current week of workout.
@property (strong, nonatomic) NSString *workout;        // Full name of an individual workout.
@property (strong, nonatomic) NSNumber *index;          // The number of times this workout has been done.
@property (strong, nonatomic) NSString *exerciseName;   // Full name of an individual exercise.
@property (strong, nonatomic) NSString *exerciseRound;  // Round of an individual exercise (1 or 2).

@property BOOL purchasedAdRemoveBeforeAppLaunch;

@property NSInteger weekArrayPositionValue;             // Current week as a number.
@property NSInteger selectedWorkoutArrayPositionValue;  // Selected workout in the tableview as a number.
@property (strong, nonatomic) NSString *request;        // Checkmark request (Completed) or (Not Completed).

@property (strong, nonatomic) NSString *graphRoutine;
@property (strong, nonatomic) NSString *graphWorkout;
@property (strong, nonatomic) NSString *graphTitle;     // Name of exercise that will be used for the graph.
@property (strong, nonatomic) NSMutableArray *graphDataPoints;

@property (strong, nonatomic) NSArray *_60_Normal_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Bulk_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Tone_WorkoutNameArray;

@property (strong, nonatomic) NSArray *_60_Normal_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Bulk_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Tone_WorkoutIndexArray;

// 60 - Normal Weeks
// Month 1
@property (strong, nonatomic) NSArray *_60_Normal_Week1_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week2_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week3_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week4_WorkoutNameArray;

@property (strong, nonatomic) NSArray *_60_Normal_Week1_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week2_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week3_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week4_WorkoutIndexArray;

// Month 2
@property (strong, nonatomic) NSArray *_60_Normal_Week5_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week6_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week7_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week8_WorkoutNameArray;

@property (strong, nonatomic) NSArray *_60_Normal_Week5_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week6_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week7_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_60_Normal_Week8_WorkoutIndexArray;


// 30 - Bulk Weeks
// Month 1
@property (strong, nonatomic) NSArray *_30_Bulk_Week1_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Bulk_Week2_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Bulk_Week3_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Bulk_Week4_WorkoutNameArray;

@property (strong, nonatomic) NSArray *_30_Bulk_Week1_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Bulk_Week2_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Bulk_Week3_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Bulk_Week4_WorkoutIndexArray;


// 30 - Tone Weeks
// Month 1
@property (strong, nonatomic) NSArray *_30_Tone_Week1_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Tone_Week2_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Tone_Week3_WorkoutNameArray;
@property (strong, nonatomic) NSArray *_30_Tone_Week4_WorkoutNameArray;

@property (strong, nonatomic) NSArray *_30_Tone_Week1_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Tone_Week2_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Tone_Week3_WorkoutIndexArray;
@property (strong, nonatomic) NSArray *_30_Tone_Week4_WorkoutIndexArray;

- (NSString *)getCurrentSession;
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;
@end

