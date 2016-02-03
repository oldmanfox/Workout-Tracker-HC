//
//  SettingsTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "SettingsTVC.h"

@interface SettingsTVC ()

@end

@implementation SettingsTVC

#define debug 0

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Respond to changes in underlying store
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"SomethingChanged"
                                               object:nil];
    
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"cogs_selected"];
    
    // Configure tableview.
    NSArray *tableCell = @[self.cell1,   // email
                           self.cell2,   // version
                           self.cell4,   // website
                           self.cell6,   // workout level
                           self.cell7,   // current session
                           self.cell8,   // disable autolcok
                           self.cell9,   // reset
                           self.cell10,  // icloud account status
                           self.cell11]; // icloud app status
    
    NSArray *accessoryIcon = @[@YES,
                               @NO,
                               @YES,
                               @NO,
                               @NO,
                               @NO,
                               @NO,
                               @NO,
                               @NO];
    
    [self configureAccessoryIconNonWorkoutList:tableCell :accessoryIcon];
    [self configureButtonBorder];
    
    // Fetch currentSession objects
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.currentSessionLabel.text = [mainAppDelegate getCurrentSession];
    
    [self findEmailSetting];
    [self findRoutineSetting];
    [self findUseAutoLockSetting];
}
  
- (void)viewDidAppear:(BOOL)animated {
    
    // Fetch currentSession objects
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.currentSessionLabel.text = [mainAppDelegate getCurrentSession];
    
    [self findEmailSetting];
    
    if ([((SettingsNavController *)self.parentViewController).emailAddress isEqualToString:@""]) {
        self.emailDetail.text = @"youremail@abc.com";
    }
    else {
        self.emailDetail.text = ((SettingsNavController *)self.parentViewController).emailAddress;
    }
    
    [self findiCloudStatus];
    [self findRoutineSetting];
    [self findUseAutoLockSetting];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 4;
    }
    
    else if (section == 1)
        return 1;
    
    else if (section == 2)
        return 2;
    
    else {
        return 2;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...*/
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:emailviewcontroller animated:YES];
     
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"email"]) {
        ((SettingsNavController *)self.parentViewController).emailAddress = self.emailDetail.text;
    }
}

- (IBAction)selectDefaultWorkout:(id)sender {
    
    NSDate *todaysDate = [NSDate date];
    
    // Fetch defaultRoutine objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Routine" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        // Object has already been created.
        matches = objects[[objects count] - 1];
        
        [matches setValue:[self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex] forKey:@"defaultRoutine"];
        [matches setValue:todaysDate forKey:@"date"];
    }
    else {
        
        // No matches.  Create record and save.
        if (debug==1) {
            NSLog(@"No match found.  Create new record and save - Routine");
        }
        
        NSManagedObject *newRoutine;
        newRoutine = [NSEntityDescription insertNewObjectForEntityForName:@"Routine" inManagedObjectContext:context];
        [newRoutine setValue:[self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex] forKey:@"defaultRoutine"];
        [newRoutine setValue:todaysDate forKey:@"date"];
    }
    
    // Save to core data
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
    
    // Save default workout to SettingsNavController
    ((SettingsNavController *)self.parentViewController).defaultWorkout = [self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex];
    
    // Default workout changed
    ((MainTBC *)self.parentViewController.parentViewController).workoutChanged = YES;}

- (IBAction)toggleBands:(id)sender {
    
    NSString *localBandSetting;
    
    if ([sender isOn]) {
        // User wants to use bands so turn on alphanumeric keyboard for weight fields.
        localBandSetting = @"ON";
    }
    
    else {
        // User doesn't want to use bands so turn on numberpad keyboard for weight fields.
        localBandSetting = @"OFF";
    }
    
    NSDate *todaysDate = [NSDate date];
    
    // Fetch useBands objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Bands" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        // Object has already been created. Get value of bands from it.
        matches = objects[[objects count] - 1];
        
        [matches setValue:localBandSetting forKey:@"useBands"];
        [matches setValue:todaysDate forKey:@"date"];
        
        [[CoreDataHelper sharedHelper] backgroundSaveContext];
    }
    
    else {
        
        // No matches.  Create record and save.
        if (debug==1) {
            NSLog(@"No match found.  Create new record and save - Bands");
        }
        
        NSManagedObject *newBands;
        newBands = [NSEntityDescription insertNewObjectForEntityForName:@"Bands" inManagedObjectContext:context];
        [newBands setValue:localBandSetting forKey:@"useBands"];
        [newBands setValue:todaysDate forKey:@"date"];
        
        [[CoreDataHelper sharedHelper] backgroundSaveContext];
    }
}

- (IBAction)decreaseSession:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"WARNING - Start Previous Session"
                                  message:@"Starting a previous session means you will only be able to edit the previous session.  To get to a different session click the \"+\" or \"-\" button after selecting Proceed."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* proceed = [UIAlertAction
                              actionWithTitle:@"Proceed"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSDate *todaysDate = [NSDate date];
                                  
                                  NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
                                  NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:context];
                                  NSFetchRequest *request = [[NSFetchRequest alloc] init];
                                  [request setEntity:entityDesc];
                                  
                                  NSManagedObject *matches = nil;
                                  NSError *error;
                                  NSArray *objects = [context executeFetchRequest:request error:&error];
                                  
                                  //NSLog(@"Session Objects = %lu", (unsigned long)[objects count]);
                                  
                                  NSString *incrementedCurrentSessionString = nil;
                                  
                                  if ([objects count] == 0) {
                                      
                                      // No matches.  Default session is 1, so subtract 1 from that to give you 0.  Can't have 0 session so do nothing.
                                  }
                                  else {
                                      
                                      // 1 or more matches.
                                      matches = objects[[objects count] - 1];
                                      int intSessionValue = [[matches valueForKey:@"currentSession"] intValue];
                                      
                                      if (intSessionValue == 1) {
                                          
                                          // Default session is 1, so subtract 1 from that to give you 0.  Can't have 0 session so do nothing.
                                      }
                                      else {
                                          
                                          intSessionValue--;
                                          incrementedCurrentSessionString = [NSString stringWithFormat:@"%d", intSessionValue];
                                          
                                          // Update object
                                          matches = objects[[objects count] - 1];
                                          [matches setValue:incrementedCurrentSessionString forKey:@"currentSession"];
                                          [matches setValue:todaysDate forKey:@"date"];
                                          
                                          [[CoreDataHelper sharedHelper] backgroundSaveContext];
                                          self.currentSessionLabel.text = incrementedCurrentSessionString;
                                      }
                                  }
                                  
                                  //NSLog(@"CurrentSession = %@", incrementedCurrentSessionString);
                                  
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:proceed];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)increaseSession:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"WARNING - Start New Session"
                                  message:@"Starting a new session means you will only be able to edit the new session.  To get to a different session click the \"+\" or \"-\" button after selecting Proceed."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* proceed = [UIAlertAction
                              actionWithTitle:@"Proceed"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSDate *todaysDate = [NSDate date];
                                  
                                  NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
                                  NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:context];
                                  NSFetchRequest *request = [[NSFetchRequest alloc] init];
                                  [request setEntity:entityDesc];
                                  
                                  NSManagedObject *matches = nil;
                                  NSError *error;
                                  NSArray *objects = [context executeFetchRequest:request error:&error];
                                  
                                  //NSLog(@"Session Objects = %lu", (unsigned long)[objects count]);
                                  
                                  NSString *incrementedCurrentSessionString = nil;
                                  
                                  if ([objects count] == 0) {
                                      
                                      // No matches.  Default session is 1, so add 1 to that to give you 2
                                      incrementedCurrentSessionString = @"2";
                                      
                                      // Insert new object
                                      NSManagedObject *newBands;
                                      newBands = [NSEntityDescription insertNewObjectForEntityForName:@"Session" inManagedObjectContext:context];
                                      [newBands setValue:incrementedCurrentSessionString forKey:@"currentSession"];
                                      [newBands setValue:todaysDate forKey:@"date"];
                                  }
                                  else {
                                      
                                      // 1 or more matches.
                                      matches = objects[[objects count] - 1];
                                      int intSessionValue = [[matches valueForKey:@"currentSession"] intValue];
                                      
                                      intSessionValue++;
                                      incrementedCurrentSessionString = [NSString stringWithFormat:@"%d", intSessionValue];
                                      
                                      // Update object
                                      matches = objects[[objects count] - 1];
                                      [matches setValue:incrementedCurrentSessionString forKey:@"currentSession"];
                                      [matches setValue:todaysDate forKey:@"date"];
                                  }
                                  
                                  [[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  self.currentSessionLabel.text = incrementedCurrentSessionString;
                                  //NSLog(@"CurrentSession = %@", incrementedCurrentSessionString);
                                  
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:proceed];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)resetAllData:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"WARNING - Delete All Data"
                                  message:@"You are about to delete ALL data in the app and start fresh.  If you are signed into iCloud this will delete the data there as well."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* proceed = [UIAlertAction
                              actionWithTitle:@"Proceed"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
                                  NSDate *todaysDate = [NSDate date];
                                  
                                  // DELETE all from entity - Workout
                                  NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
                                  NSFetchRequest *request = [[NSFetchRequest alloc] init];
                                  [request setEntity:entityDesc];
                                  NSError *error = nil;
                                  NSArray *objects = [context executeFetchRequest:request error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] saveContext];
                                  
                                  
                                  // DELETE all from entity - WorkoutCompleteDate
                                  entityDesc = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
                                  [request setEntity:entityDesc];
                                  error = nil;
                                  objects = [context executeFetchRequest:request error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] saveContext];

                                  
                                  // DELETE all from entity - Session
                                  entityDesc = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:context];
                                  [request setEntity:entityDesc];
                                  error = nil;
                                  objects = [context executeFetchRequest:request error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] saveContext];
                                  
                                  // Set session to default - 1
                                  self.currentSessionLabel.text = @"1";
                                  //NSLog(@"CurrentSession = %@", self.currentSessionLabel.text);
                                  
                                  objects = [context executeFetchRequest:request error:&error];
                                  
                                  if ([objects count] == 0) {
                                      
                                      NSManagedObject *insertSession;
                                      insertSession = [NSEntityDescription insertNewObjectForEntityForName:@"Session" inManagedObjectContext:context];
                                      [insertSession setValue:@"1" forKey:@"currentSession"];
                                      [insertSession setValue:todaysDate forKey:@"date"];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  
                                  // DELETE all from entity - Photo
                                  NSEntityDescription *entityDescPhoto = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
                                  NSFetchRequest *requestPhoto = [[NSFetchRequest alloc] init];
                                  [requestPhoto setEntity:entityDescPhoto];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestPhoto error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  
                                  // DELETE all from entity - Measurement
                                  NSEntityDescription *entityDescMeasurement = [NSEntityDescription entityForName:@"Measurement" inManagedObjectContext:context];
                                  NSFetchRequest *requestMeasurement = [[NSFetchRequest alloc] init];
                                  [requestMeasurement setEntity:entityDescMeasurement];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestMeasurement error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  
                                  // DELETE all from entity - Routine
                                  NSEntityDescription *entityDescRoutine = [NSEntityDescription entityForName:@"Routine" inManagedObjectContext:context];
                                  NSFetchRequest *requestRoutine = [[NSFetchRequest alloc] init];
                                  [requestRoutine setEntity:entityDescRoutine];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestRoutine error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  // Set routine to default - Normal
                                  self.defaultWorkout.selectedSegmentIndex = 1;
                                  //NSLog(@"Current Routine = %@", [self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex]);
                                  
                                  objects = [context executeFetchRequest:requestRoutine error:&error];
                                  
                                  if ([objects count] == 0) {
                                      
                                      NSManagedObject *newRoutine;
                                      newRoutine = [NSEntityDescription insertNewObjectForEntityForName:@"Routine" inManagedObjectContext:context];
                                      [newRoutine setValue:@"Bulk" forKey:@"defaultRoutine"];
                                      [newRoutine setValue:todaysDate forKey:@"date"];
                                  }
                                  
                                  // Save to core data
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  // Save default workout to SettingsNavController
                                  ((SettingsNavController *)self.parentViewController).defaultWorkout = [self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex];
                                  
                                  // Default workout changed
                                  ((MainTBC *)self.parentViewController.parentViewController).workoutChanged = YES;
                                  
                                  
                                  // DELETE all from entity - Email
                                  NSEntityDescription *entityDescEmail = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
                                  NSFetchRequest *requestEmail = [[NSFetchRequest alloc] init];
                                  [requestEmail setEntity:entityDescEmail];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestEmail error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  // Set email to default
                                  self.emailDetail.text = @"youremail@abc.com";
                                  ((SettingsNavController *)self.parentViewController).emailAddress = @"";
                                  
                                  
//                                  // DELETE all from entity - Bands
//                                  NSEntityDescription *entityDescBands = [NSEntityDescription entityForName:@"Bands" inManagedObjectContext:context];
//                                  NSFetchRequest *requestBands = [[NSFetchRequest alloc] init];
//                                  [requestBands setEntity:entityDescBands];
//                                  
//                                  error = nil;
//                                  objects = [context executeFetchRequest:requestBands error:&error];
//                                  
//                                  for (NSManagedObject *info in objects) {
//                                      [context deleteObject:info];
//                                  }
//                                  
//                                  [[CoreDataHelper sharedHelper] backgroundSaveContext];
//                                  
//                                  // Set bands to default - OFF
//                                  [self.bandsSwitch setOn:NO animated:YES];
//                                  
//                                  
                                  // DELETE all from entity - AutoLock
                                  NSEntityDescription *entityDescAutoLock = [NSEntityDescription entityForName:@"AutoLock" inManagedObjectContext:context];
                                  NSFetchRequest *requestAutoLock = [[NSFetchRequest alloc] init];
                                  [requestAutoLock setEntity:entityDescAutoLock];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestAutoLock error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  // Set disable autolock to default - OFF
                                  [self.autoLockSwitch setOn:NO animated:YES];
                                  [UIApplication sharedApplication].idleTimerDisabled = NO;
                                  
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                  
                                  [[CoreDataHelper sharedHelper] backgroundSaveContext];
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:proceed];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)resetCurrentSessionData:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"WARNING - Delete Current Session Data"
                                  message:@"You are about to delete the data for the current session and start fresh for that session.  If you are signed into iCloud this will delete the data there as well."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* proceed = [UIAlertAction
                              actionWithTitle:@"Proceed"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  // Get the objects for the current session
                                  NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
                                  AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                  
                                  // Fetch current session data.
                                  NSString *currentSessionString = [mainAppDelegate getCurrentSession];
                                  
                                  // Fetch workout data.
                                  NSEntityDescription *entityDescWorkout = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
                                  NSFetchRequest *requestWorkout = [[NSFetchRequest alloc] init];
                                  [requestWorkout setEntity:entityDescWorkout];
                                  
                                  NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@)", currentSessionString];
                                  [requestWorkout setPredicate:pred];
                                  
                                  NSError *error = nil;
                                  NSArray *objects = [context executeFetchRequest:requestWorkout error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  
                                  // Fetch workout data.
                                  NSEntityDescription *entityDescWorkoutCompleteDate = [NSEntityDescription entityForName:@"WorkoutCompleteDate" inManagedObjectContext:context];
                                  NSFetchRequest *requestWorkoutCompleteDate = [[NSFetchRequest alloc] init];
                                  [requestWorkoutCompleteDate setEntity:entityDescWorkoutCompleteDate];
                                  
                                  NSPredicate *predWorkoutCompleteDate = [NSPredicate predicateWithFormat:@"(session = %@)", currentSessionString];
                                  [requestWorkoutCompleteDate setPredicate:predWorkoutCompleteDate];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestWorkoutCompleteDate error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];

                                  
                                  // Fetch Photo data.
                                  NSEntityDescription *entityDescPhoto = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
                                  NSFetchRequest *requestPhoto = [[NSFetchRequest alloc] init];
                                  [requestPhoto setEntity:entityDescPhoto];
                                  
                                  NSPredicate *predPhoto = [NSPredicate predicateWithFormat:@"(session = %@)", currentSessionString];
                                  [requestPhoto setPredicate:predPhoto];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestPhoto error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  //[[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  
                                  // Fetch Measurement data.
                                  NSEntityDescription *entityDescMeasurement = [NSEntityDescription entityForName:@"Measurement" inManagedObjectContext:context];
                                  NSFetchRequest *requestMeasurement = [[NSFetchRequest alloc] init];
                                  [requestMeasurement setEntity:entityDescMeasurement];
                                  
                                  NSPredicate *predMeasurement = [NSPredicate predicateWithFormat:@"(session = %@)", currentSessionString];
                                  [requestMeasurement setPredicate:predMeasurement];
                                  
                                  error = nil;
                                  objects = [context executeFetchRequest:requestMeasurement error:&error];
                                  
                                  for (NSManagedObject *info in objects) {
                                      [context deleteObject:info];
                                  }
                                  
                                  [[CoreDataHelper sharedHelper] backgroundSaveContext];
                                  
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:proceed];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)toggleAutoLock:(id)sender {
    
    NSString *localAutoLockSetting;
    
    if ([sender isOn]) {
        // User wants to disable the autolock timer.
        localAutoLockSetting = @"ON";
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    
    else {
        // User doesn't want to disable the autolock timer.
        localAutoLockSetting = @"OFF";
        [UIApplication sharedApplication].idleTimerDisabled = NO;
    }
    
    NSDate *todaysDate = [NSDate date];
    
    // Fetch useBands objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"AutoLock" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        // Object has already been created. Get value of autolock from it.
        matches = objects[[objects count] - 1];
        
        [matches setValue:localAutoLockSetting forKey:@"useAutoLock"];
        [matches setValue:todaysDate forKey:@"date"];
        
        [[CoreDataHelper sharedHelper] backgroundSaveContext];
    }
    
    else {
        
        // No matches.  Create record and save.
        if (debug==1) {
            NSLog(@"No match found.  Create new record and save - AutoLock");
        }
        
        NSManagedObject *newBands;
        newBands = [NSEntityDescription insertNewObjectForEntityForName:@"AutoLock" inManagedObjectContext:context];
        [newBands setValue:localAutoLockSetting forKey:@"useAutoLock"];
        [newBands setValue:todaysDate forKey:@"date"];
        
        [[CoreDataHelper sharedHelper] backgroundSaveContext];
    }
}

- (void)configureButtonBorder {
    
    //UIColor *orange = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:48/255.0f alpha:1.0f];
    //UIColor *lightOrange = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:48/255.0f alpha:0.75f];
    
    //UIColor* redColor = [UIColor colorWithRed:204/255.0f green:76/255.0f blue:45/255.0f alpha:1.0f];
    //UIColor* lightRedColor = [UIColor colorWithRed:204/255.0f green:76/255.0f blue:45/255.0f alpha:0.75f];
    UIColor* testBlueColor = [UIColor colorWithRed:47/255.0f green:120/255.0f blue:145/255.0f alpha:1.0f];
    UIColor* lighttestBlueColor = [UIColor colorWithRed:47/255.0f green:120/255.0f blue:145/255.0f alpha:0.75f];
    
    // decreaseSession Button
    self.decreaseSessionButton.tintColor = [UIColor whiteColor];
    self.decreaseSessionButton.backgroundColor = lighttestBlueColor;
    self.decreaseSessionButton.layer.borderWidth = 1.0f;
    self.decreaseSessionButton.layer.borderColor = [testBlueColor CGColor];
    self.decreaseSessionButton.layer.cornerRadius = 5;
    self.decreaseSessionButton.clipsToBounds = YES;
    
    // increaseSession Button
    self.increaseSessionButton.tintColor = [UIColor whiteColor];
    self.increaseSessionButton.backgroundColor = lighttestBlueColor;
    self.increaseSessionButton.layer.borderWidth = 1.0f;
    self.increaseSessionButton.layer.borderColor = [testBlueColor CGColor];
    self.increaseSessionButton.layer.cornerRadius = 5;
    self.increaseSessionButton.clipsToBounds = YES;
    
    // ResetAllData Button
    self.resetAllDataButton.tintColor = [UIColor whiteColor];
    self.resetAllDataButton.backgroundColor = lighttestBlueColor;
    self.resetAllDataButton.layer.borderWidth = 1.0f;
    self.resetAllDataButton.layer.borderColor = [testBlueColor CGColor];
    self.resetAllDataButton.layer.cornerRadius = 5;
    self.resetAllDataButton.clipsToBounds = YES;
    
    // ResetCurrentSessionData Button
    self.resetCurrentSessionDataButton.tintColor = [UIColor whiteColor];
    self.resetCurrentSessionDataButton.backgroundColor = lighttestBlueColor;
    self.resetCurrentSessionDataButton.layer.borderWidth = 1.0f;
    self.resetCurrentSessionDataButton.layer.borderColor = [testBlueColor CGColor];
    self.resetCurrentSessionDataButton.layer.cornerRadius = 5;
    self.resetCurrentSessionDataButton.clipsToBounds = YES;
}

- (void)findiCloudStatus {
    
    // Check if the user is signed into an iCloud account on the device.
    if ([CoreDataHelper sharedHelper].iCloudAccountIsSignedIn) {
        
        self.iCloudAccountStatusLabel.text = @"SIGNED-IN";
    }
    else {
        
        self.iCloudAccountStatusLabel.text = @"SIGNED-OUT.  Change in Device Settings -> iCloud";
    }
    
    // Check if the app is allowed to use iCloud.
    if ([CoreDataHelper sharedHelper].iCloudEnabledByUser) {
        
        self.iCloudAppStatusLabel.text = @"YES";
    }
    else {
        
        self.iCloudAppStatusLabel.text = @"NO.  Change in Device Settings -> 60 DWT HC";
    }
}

- (void)findEmailSetting {
    
    // Fetch defaultEmail objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        matches = objects[[objects count] - 1];
        
        self.emailDetail.text = [matches valueForKey:@"defaultEmail"];
        ((SettingsNavController *)self.parentViewController).emailAddress = [matches valueForKey:@"defaultEmail"];
    }
    else {
        
        ((SettingsNavController *)self.parentViewController).emailAddress = @"";
    }
}

- (void)findRoutineSetting {
    
    // Fetch defaultRoutine objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Routine" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        matches = objects[[objects count] - 1];
        NSString *workoutTitle = [matches valueForKey:@"defaultRoutine"];
        
        for (int i = 0; i < 3; i++) {
            if ([[self.defaultWorkout titleForSegmentAtIndex:i] isEqualToString:workoutTitle]) {
                self.defaultWorkout.selectedSegmentIndex = i;
            }
        }
    }
}

- (void)findUseBandsSetting {
    
    // Fetch useBands objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Bands" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        // Match found
        matches = objects[[objects count] - 1];
        
        if ([[matches valueForKey:@"useBands"] isEqualToString:@"ON"]) {
            [self.bandsSwitch setOn:YES animated:NO];
        }
        else {
            [self.bandsSwitch setOn:NO animated:NO];
        }
    }
    else {
        
        // No match found.  Set toggle to off.
        [self.bandsSwitch setOn:NO animated:NO];
    }
}

- (void)findUseAutoLockSetting {
    
    // Fetch useAutoLock objects
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"AutoLock" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        
        // Match found
        matches = objects[[objects count] - 1];
        
        if ([[matches valueForKey:@"useAutoLock"] isEqualToString:@"ON"]) {
            [self.autoLockSwitch setOn:YES animated:NO];
        }
        else {
            [self.autoLockSwitch setOn:NO animated:NO];
        }
    }
    else {
        
        // No match found.  Set toggle to off.
        [self.autoLockSwitch setOn:NO animated:NO];
    }
}

- (void)updateUI {
    
    if ([CoreDataHelper sharedHelper].iCloudStore) {
        [self viewDidAppear:YES];
    }
}
@end
