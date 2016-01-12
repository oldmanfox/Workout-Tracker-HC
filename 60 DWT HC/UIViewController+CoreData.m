//
//  UIViewController+CoreData.m
//  90 DWT 1
//
//  Created by Jared Grant on 5/8/13.
//  Copyright (c) 2013 Grant, Jared. All rights reserved.
//

#import "UIViewController+CoreData.h"
#import "DataNavController.h"
#import "CoreDataHelper.h"

@implementation UIViewController (CoreData)

- (NSArray *)databaseMatches {
    
    // Get Data from the database.
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get workout data using the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@)",
                         currentSessionString,
                         mainAppDelegate.routine,
                         mainAppDelegate.workout,
                         mainAppDelegate.exerciseName,
                         mainAppDelegate.exerciseRound];
    [request setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    //NSLog(@"Objects = %lu", (unsigned long)[objects count]);
    
    // Get a list of sorted unique indexes
    NSArray *sortedArray = [self findSortedIndexes:objects];
    
    // Get the last object per index.  That would be the most recently inserted record.
    NSArray *lastObjectForIndexArray = [self findLastObjectForIndex:sortedArray];
    
    return lastObjectForIndexArray;
}

-(void)saveWorkoutComplete:(NSDate*)useDate {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = mainAppDelegate.index;
    NSString *routine = mainAppDelegate.routine;
    NSString *workout = mainAppDelegate.workout;
    
    pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine == %@) AND (workout == %@) AND (index == %@)",
            currentSessionString,
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedOjectsArray count] == 0) {
        
        //NSLog(@"submitEntry = No matches - create new record and save");
        insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
        
        insertWorkoutInfo.session = currentSessionString,
        insertWorkoutInfo.routine = routine;
        insertWorkoutInfo.workout = workout;
        insertWorkoutInfo.index = workoutIndex;
        insertWorkoutInfo.workoutCompleted = [NSNumber numberWithBool:YES];
        insertWorkoutInfo.date = useDate;
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        matches.workoutCompleted = [NSNumber numberWithBool:YES];
        matches.date = useDate;
    }
    
    // Save the object to persistent store
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
}

-(void)deleteDate {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine == %@) AND (workout == %@) AND (index == %@)",
            currentSessionString,
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedOjectsArray count] == 0) {
        //NSLog(@"submitEntry = No matches - create new record and save");
        
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        matches.workoutCompleted = [NSNumber numberWithBool:NO];
        matches.date = nil;
        
        //NSLog(@"Date = %@", matches.date);
        
        // Save the object to persistent store
        [[CoreDataHelper sharedHelper] backgroundSaveContext];
    }
    
    //NSLog(@"Exercise Completed = %@", matches.exerciseCompleted);
    //NSLog(@"Exercise Completed = %@", insertWorkoutInfo.exerciseCompleted);
}

-(void)saveDataNavControllerToAppDelegate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.index = ((DataNavController *)self.parentViewController).index;
    appDelegate.routine = ((DataNavController *)self.parentViewController).routine;
    appDelegate.workout = ((DataNavController *)self.parentViewController).workout;
}

-(BOOL)workoutCompleted {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];

    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    //WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine == %@) AND (workout == %@) AND (index == %@)",
            currentSessionString,
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    BOOL tempWorkoutCompleted = false;
    
    if ([fetchedOjectsArray count] == 0) {
        
        //NSLog(@"submitEntry = No matches - create new record and save");
        tempWorkoutCompleted = NO;
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        tempWorkoutCompleted = [matches.workoutCompleted boolValue];
    }
    
    return tempWorkoutCompleted;
}

-(NSString*)getWorkoutCompletedDate {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    //WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine == %@) AND (workout == %@) AND (index == %@)",
            currentSessionString,
            routine,
            workout,
            workoutIndex];
    [fetchRequest setPredicate:pred];
    matches = nil;
    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    
    NSDate *myDate;
    NSString *getDate;
    
    if ([fetchedOjectsArray count] == 0) {
        
        //NSLog(@"submitEntry = No matches - create new record and save");
        getDate = nil;
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        myDate = matches.date;
        
        //NSLog(@"Date = %@", matches.date);
        getDate = [NSDateFormatter localizedStringFromDate:myDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    }
    
    return getDate;
}

- (NSArray *)findSortedIndexes:(NSArray *)objectArray {
    
    NSArray *tempObjectArray = objectArray;
    
    NSArray* uniqueValues = [tempObjectArray valueForKeyPath:[NSString stringWithFormat:@"@distinctUnionOfObjects.%@", @"index"]];
    //NSLog(@"%@", uniqueValues);
    
    NSArray *sortedIndex = [uniqueValues sortedArrayUsingComparator:
                            ^NSComparisonResult(id obj1, id obj2) {
                                if ([obj1 integerValue] < [obj2 integerValue]) {
                                    return NSOrderedAscending;
                                } else if ([obj1 integerValue] > [obj2 integerValue]) {
                                    return NSOrderedDescending;
                                } else {
                                    return NSOrderedSame;
                                }
                            }];
    //NSLog(@"%@", sortedIndex);
    
    return sortedIndex;
}

- (NSArray *)findLastObjectForIndex:(NSArray *)indexArray {
    
    NSArray *tempIndexArray = indexArray;
    NSMutableArray *lastObjectForIndexArray = [[NSMutableArray alloc] init];
    
    // Get Data from the database.
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get workout data using the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    for (int i = 0; i < tempIndexArray.count; i++) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                             currentSessionString,
                             mainAppDelegate.routine,
                             mainAppDelegate.workout,
                             mainAppDelegate.exerciseName,
                             mainAppDelegate.exerciseRound,
                             [tempIndexArray[i] integerValue] ];
        [request setPredicate:pred];
        
        NSManagedObject *lastObject = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        lastObject = [objects lastObject];
        [lastObjectForIndexArray addObject:lastObject];
    }
    
    //NSLog(@"Objects = %lu", (unsigned long)[lastObjectForIndexArray count]);
    
    NSArray *objects = lastObjectForIndexArray;
    return objects;
}
@end
