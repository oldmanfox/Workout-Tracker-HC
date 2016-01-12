//
//  UITableViewController+Database.m
//  60 DWT HC
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "UITableViewController+Database.h"
#import "DataNavController.h"
#import "CoreDataHelper.h"

@implementation UITableViewController (Database)

-(void)exerciseMatches:(NSArray*)exerciseTitlesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)prevNotesArray :(NSArray*)curNotesArray{
    
    // Get Data from the database.
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get workout data using the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    NSError *error;
    NSArray *fetchedOjectsArray;
    Workout *matches;
    
    NSString *tempExerciseName;
    UITextField *tempPreviousTF;
    UITextField *tempCurrentTF;
    UITextField *tempPreviousNotes;
    UITextField *tempCurrentNotes;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSNumber *previousWorkoutIndex = @([workoutIndex integerValue] - 1);
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    mainAppDelegate.index = workoutIndex;
    
    for (int i = 0; i < exerciseTitlesArray.count; i++) {
        
        tempExerciseName = exerciseTitlesArray[i];
        tempPreviousNotes = prevNotesArray[i];
        tempCurrentNotes = curNotesArray[i];
        
        // Get data for previousTF and currentTF and Previous Notes and Current Notes.
        for (int round = 0; round < 6; round++) {
            
            tempPreviousTF = previousTFArray[textFieldCount];
            tempCurrentTF = currentTFArray[textFieldCount];
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine == %@) AND (workout == %@) AND (exercise == %@) AND (round == %@) AND (index == %@)",
                    currentSessionString,
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            // 1st time exercise is done only.
            if ([workoutIndex integerValue] == 1) {
                // The workout has not been done before.
                // Do NOT get previous workout data.
                // Set the current placeholders to defaults/nil.
                
                if ([fetchedOjectsArray count] == 0) {
                    //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
                    
                    tempCurrentTF.text = @"0.0";
                    tempPreviousTF.text = @"0.0";
                }
                
                // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
                // Only use the current 1st week workout data when the user comes back to this screen.
                
                else {
                    //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
                    
                    matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                    //matches = [fetchedOjectsArray objectAtIndex:0];
                    
                    tempCurrentTF.text = matches.weight;
                    tempPreviousTF.text = matches.weight;
                    
                    tempCurrentNotes.text = matches.notes;
                    tempPreviousNotes.text = matches.notes;
                }
            }
            
            // 2nd time exercise has been done and beyond.
            else {
                
                // This workout with this index has been done before.
                // User came back to look at his results so display this weeks results in the current results section.
                if ([fetchedOjectsArray count] >= 1) {
                    
                    matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                    //matches = [fetchedOjectsArray objectAtIndex:0];
                    
                    tempCurrentTF.text = matches.weight;
                    tempCurrentNotes.text = matches.notes;
                    
                    pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                            currentSessionString,
                            routine,
                            workout,
                            tempExerciseName,
                            roundConverted,
                            previousWorkoutIndex];  // Previous workout index.
                    [fetchRequest setPredicate:pred];
                    matches = nil;
                    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if ([fetchedOjectsArray count] >= 1) {
                        
                        matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                        //matches = [fetchedOjectsArray objectAtIndex:0];
                        
                        tempPreviousTF.text = matches.weight;
                        tempPreviousNotes.text = matches.notes;
                    }
                    
                    //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                    else {
                        
                        tempPreviousTF.text = @"0.0";
                    }
                }
                
                // This workout with this index has NOT been done before.
                // Set the current placeholders to defaults/nil.
                else {
                    
                    tempCurrentTF.text = @"0.0";
                    
                    pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                            currentSessionString,
                            routine,
                            workout,
                            tempExerciseName,
                            roundConverted,
                            previousWorkoutIndex];  // Previous workout index.
                    [fetchRequest setPredicate:pred];
                    matches = nil;
                    fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    if ([fetchedOjectsArray count] >= 1) {
                        
                        matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                        //matches = [fetchedOjectsArray objectAtIndex:0];
                        
                        tempPreviousTF.text = matches.weight;
                        tempPreviousNotes.text = matches.notes;
                    }
                    
                    //  The user did not do the last workout so there are no records to display in the previous secition.  Set it to 0.0.
                    else {
                        
                        tempPreviousTF.text = @"0.0";
                    }
                }
            }
            
            // End of the round "if statement"
            textFieldCount++;
        }
    }
}

-(void)saveToDatabase:(NSArray*)exerciseNameArray :(NSArray*)repLabelArray :(NSArray*)currentTFArray :(NSArray*)curNotesArray {
    
    NSDate *todaysDate = [NSDate date];
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get workout data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    Workout *matches;
    Workout *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
    NSString *tempExerciseName;
    NSString *tempRepName;
    UITextField *tempCurrentTF;
    UITextField *tempCurrentNotes;
    int textFieldCount = 0;
    NSNumber *roundConverted;
    
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSString *month = ((DataNavController *)self.parentViewController).month;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
    for (int i = 0; i < exerciseNameArray.count; i++) {
        
        tempExerciseName = exerciseNameArray[i];
        tempCurrentNotes = curNotesArray[i];
        
        // Save the Current Weight text field and Current Notes text field
        for (int round = 0; round < 6; round++) {
            
            tempRepName = repLabelArray[textFieldCount];
            tempCurrentTF = currentTFArray[textFieldCount];
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine == %@) AND (workout == %@) AND (exercise == %@) AND (round == %@) AND (index == %@)",
                    currentSessionString,
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            if ([fetchedOjectsArray count] == 0) {
                //NSLog(@"submitEntry = No matches - create new record and save");
                
                // Only update the fields that have been changed.
                
                if (tempCurrentTF.text.length != 0) {
                    
                    insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
                    
                    insertWorkoutInfo.session = currentSessionString;
                    insertWorkoutInfo.reps = tempRepName;
                    insertWorkoutInfo.weight = tempCurrentTF.text;
                    insertWorkoutInfo.notes = tempCurrentNotes.text;
                    insertWorkoutInfo.date = todaysDate;
                    insertWorkoutInfo.exercise = tempExerciseName;
                    insertWorkoutInfo.round = roundConverted;
                    insertWorkoutInfo.routine = routine;
                    insertWorkoutInfo.month = month;
                    insertWorkoutInfo.week = week;
                    insertWorkoutInfo.workout = workout;
                    insertWorkoutInfo.index = workoutIndex;
                }
            }
            
            else {
                //NSLog(@"submitEntry = Match found - update existing record and save");
                
                matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                //matches = [fetchedOjectsArray objectAtIndex:0];
                
                // Make sure the text field is not empty
                if (tempCurrentTF.text.length != 0) {
                    
                    if (![matches.weight isEqualToString: tempCurrentTF.text]) {
                        
                        // Only update the fields that have been changed
                        matches.weight = tempCurrentTF.text;
                        matches.date = todaysDate;
                    }
                }
                
                // Make sure the text field is not empty
                if (tempCurrentNotes.text.length != 0) {
                    
                    if (![matches.notes isEqualToString: tempCurrentNotes.text]) {
                        
                        // Only update the fields that have been changed
                        matches.notes = tempCurrentNotes.text;
                        matches.date = todaysDate;
                    }
                }
            }
            
//            // Save the object to persistent store
//            [[CoreDataHelper sharedHelper] backgroundSaveContext];
            
            // End of the round "if statement"
            textFieldCount++;
            
            [tempCurrentTF resignFirstResponder];
            [tempCurrentNotes resignFirstResponder];
        }
    }
    
    // Save the object to persistent store
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
}

-(void)saveWorkoutComplete:(NSDate*)useDate {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Save the workout data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    WorkoutCompleteDate *insertWorkoutInfo;
    
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
        insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
        
        insertWorkoutInfo.session = currentSessionString;
        insertWorkoutInfo.routine = routine;
        insertWorkoutInfo.workout = workout;
        insertWorkoutInfo.index = workoutIndex;
        insertWorkoutInfo.workoutCompleted = [NSNumber numberWithBool:YES];
        insertWorkoutInfo.date = [NSDate date];
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

-(void)saveWorkoutCompleteWithArguments:(NSNumber*)workoutIndex :(NSString*)routine :(NSString*)workout {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Save the workout data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred;
    WorkoutCompleteDate *matches;
    WorkoutCompleteDate *insertWorkoutInfo;
    
    NSError *error;
    NSArray *fetchedOjectsArray;
    
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
        
        insertWorkoutInfo.session = currentSessionString;
        insertWorkoutInfo.routine = routine;
        insertWorkoutInfo.workout = workout;
        insertWorkoutInfo.index = workoutIndex;
        insertWorkoutInfo.workoutCompleted = [NSNumber numberWithBool:YES];
        insertWorkoutInfo.date = [NSDate date];
    }
    
    else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        //matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
        // Mark the workout completed to the last object in the workout database which isn't used by anything else.
        matches = [fetchedOjectsArray objectAtIndex:[fetchedOjectsArray count] - 1];
        
        matches.workoutCompleted = [NSNumber numberWithBool:YES];
        // Today's date
        matches.date = [NSDate date];
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
    }
    
    // Save the object to persistent store
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
    
    //NSLog(@"Exercise Completed = %@", matches.exerciseCompleted);
    //NSLog(@"Exercise Completed = %@", insertWorkoutInfo.exerciseCompleted);
}

-(void)deleteDateWithArguments:(NSNumber*)workoutIndex :(NSString*)routine :(NSString*)workout {
    
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
    
    //NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    //NSString *routine = ((DataNavController *)self.parentViewController).routine;
    //NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
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
    }
    
    // Save the object to persistent store
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
    
    //NSLog(@"Exercise Completed = %@", matches.exerciseCompleted);
    //NSLog(@"Exercise Completed = %@", insertWorkoutInfo.exerciseCompleted);
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
        //insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
        
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

-(BOOL)workoutCompletedWithArguments:(NSNumber*)workoutIndex :(NSString*)routine :(NSString*)workout {
    
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
    
    //NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    //NSString *routine = ((DataNavController *)self.parentViewController).routine;
    //NSString *workout = ((DataNavController *)self.parentViewController).workout;
    
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
        //insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
        
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
        //insertWorkoutInfo = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
        
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

-(void)saveDataNavControllerToAppDelegate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.index = ((DataNavController *)self.parentViewController).index;
    appDelegate.routine = ((DataNavController *)self.parentViewController).routine;
    appDelegate.workout = ((DataNavController *)self.parentViewController).workout;
}

@end
