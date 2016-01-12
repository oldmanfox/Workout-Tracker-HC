//
//  UITableViewController+Email.m
//  60 DWT HC
//
//  Created by Grant, Jared on 3/4/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "UITableViewController+Email.h"
#import "CoreDataHelper.h"

@implementation UITableViewController (Email)

- (NSString*)stringForEmail:(NSArray*)allTitleArray {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get workout data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (index = %d)",
                         currentSessionString,
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [fetchRequest setPredicate:pred];
    Workout *matches = nil;
    NSError *error;
    NSArray *fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    NSString *session;
    NSString *routine;
    NSString *month;
    NSString *week;
    NSString *workout;
    NSDate  *date;
    NSString *dateString;
    
    // Create the Header info
    if ([fetchedOjectsArray count] != 0)
    {
        
        //  Add the column headers for Routine, Month, Week, Workout, and Date to the string
        [writeString appendString:[NSString stringWithFormat:@"Session,Routine,Month,Week,Workout,Date\n"]];
        
        for (int i = 0; i < 1; i++)
        {
            matches = fetchedOjectsArray[i];
            
            session = matches.session;
            routine = matches.routine;
            month = matches.month;
            week = matches.week;
            workout = matches.workout;
            date = matches.date;
            /*
            routine =     [matches valueForKey:@"routine"];
            month =       [matches valueForKey:@"month"];
            week  =       [matches valueForKey:@"week"];
            workout =     [matches valueForKey:@"workout"];
            date =        [matches valueForKey:@"date"];
            */
            dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@\n",
                                       session, routine, month, week, workout, dateString]];
        }
    }
    
    NSString *tempExerciseName;
    NSString *tempWeightData;
    NSString *tempRepData;
    NSNumber *workoutIndex = ((DataNavController *)self.parentViewController).index;
    NSNumber *roundConverted;
    int validRepFields;
    
    //  Add the workout name, reps and weight
    for (int i = 0; i < allTitleArray.count; i++) {
        
        tempExerciseName = allTitleArray[i];
        
        //  Add the title to the string
        [writeString appendString:[NSString stringWithFormat:@"%@\n", tempExerciseName]];
        validRepFields = 0;
        
        //  Add the reps to the string
        for (int round = 0; round < 6; round++) {
            
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                    currentSessionString,
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            if ([fetchedOjectsArray count] >= 1) {
                
                //  Match found
                //matches = [fetchedOjectsArray objectAtIndex:0];
                matches = fetchedOjectsArray[[fetchedOjectsArray count] - 1];
                
                tempRepData = matches.reps;
                //tempRepData = [matches valueForKey:@"reps"];
            }
            
            else {
                
                //  No match found
                
            }

            if (![tempRepData isEqualToString:@""]) {
                
                if (round != 5) {
                    
                    //  Add the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempRepData]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempRepData]];
                }
                
                validRepFields++;
            }
            
            else {
                
                if (round == 5) {
                    
                    [writeString appendString:[NSString stringWithFormat:@"\n"]];
                }
            }
        }
        
            
        //  Add the weight line from the database
        for (int round = 0; round < validRepFields; round++) {
            
            roundConverted = [NSNumber numberWithInt:round];
            
            pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %@)",
                    currentSessionString,
                    routine,
                    workout,
                    tempExerciseName,
                    roundConverted,
                    workoutIndex];
            [fetchRequest setPredicate:pred];
            matches = nil;
            fetchedOjectsArray = [context executeFetchRequest:fetchRequest error:&error];
            
            if ([fetchedOjectsArray count] >= 1) {
                
                //matches = [fetchedOjectsArray objectAtIndex:0];
                matches = fetchedOjectsArray[[fetchedOjectsArray count]-1];
                
                tempWeightData = matches.weight;
                //tempWeightData = [matches valueForKey:@"weight"];
                
                if (round != validRepFields -1) {
                    
                    //  Add  the data to the string with a "," after it
                    [writeString appendString:[NSString stringWithFormat:@"%@,", tempWeightData]];
                }
                
                else {
                    
                    //  Last entry for the line so "," is not needed
                    //  Add a line break to the end of the line
                    [writeString appendString:[NSString stringWithFormat:@"%@\n", tempWeightData]];
                }
            }
        }
    }
    
    //  Return the string
    return writeString;
}

- (void)sendEmail:(NSString*)csvString {
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];

    // Check to see if the device has at least 1 email account configured
    if ([MFMailComposeViewController canSendMail]) {

        NSData *csvData = [csvString dataUsingEncoding:NSASCIIStringEncoding];
        NSString *workoutName = ((DataNavController *)self.parentViewController).workout;
        workoutName = [workoutName stringByAppendingString:@".csv"];
        
        // Get the objects for the current session
        NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];

        // Fetch defaultEmail data.
        NSEntityDescription *entityDescEmail = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
        NSFetchRequest *requestEmail = [[NSFetchRequest alloc] init];
        [requestEmail setEntity:entityDescEmail];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:requestEmail error:&error];
        
        // Array to store the default email address.
        NSArray *emailAddresses;
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            
            // There is a default email address.
            emailAddresses = @[[matches valueForKey:@"defaultEmail"]];
        }
        else {
            
            // There is NOT a default email address.  Put an empty email address in the arrary.
            emailAddresses = @[@""];
        }

        [mailComposer setToRecipients:emailAddresses];
        
        [mailComposer setSubject:@"60 DWT HC Workout Data"];
        [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:workoutName];
        [self presentViewController:mailComposer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
