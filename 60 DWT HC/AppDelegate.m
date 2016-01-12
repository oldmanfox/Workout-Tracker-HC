//
//  AppDelegate.m
//  60 DWT HC
//
//  Created by Grant, Jared on 1/5/16.
//  Copyright © 2016 Grant, Luana. All rights reserved.
//

#import "AppDelegate.h"
//#import "60DWTHCIAPHelper.h"
#import "CoreDataHelper.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

#define debug 0

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // For In App Purchases - check to see if any transactions were purchased but not completed due to network loss or somethign similar.
    //[_0DWTHCIAPHelper sharedInstance];

    //UIColor *gold = [UIColor colorWithRed:200/255.0f green:152/255.0f blue:4/255.0f alpha:1.0f];
    UIColor *gold = [UIColor colorWithRed:199/255.0f green:151/255.0f blue:6/255.0f alpha:1.0f];
    
    [[UINavigationBar appearance] setBarTintColor:gold];
    
    // Make the navigation bar text white
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // Make the tab bar tint color
    [[UITabBar appearance] setTintColor: gold];
    
    //[UIViewController prepareInterstitialAds];
    
//    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantsoftware.60DWTHC.removeads"]) {
//        
//        self.purchasedAdRemoveBeforeAppLaunch = YES;
//    }
    
    [[ CoreDataHelper sharedHelper] iCloudAccountIsSignedIn];
    
    [self loadArrays];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [[ CoreDataHelper sharedHelper] backgroundSaveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [[ CoreDataHelper sharedHelper] ensureAppropriateStoreIsLoaded];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    //[self saveContext];
    [[ CoreDataHelper sharedHelper] backgroundSaveContext];
}

- (NSString *)getCurrentSession {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSEntityDescription *entityDescSession = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:context];
    NSFetchRequest *requestSession = [[NSFetchRequest alloc] init];
    [requestSession setEntity:entityDescSession];
    
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:requestSession error:&error];
    NSString *currentSessionString;
    
    if ([objects count] == 0) {
        
        // No matches.
        currentSessionString = @"1";
    }
    
    else {
        
        // Multiple session matches.
        matches = objects[[objects count] - 1];
        
        currentSessionString = [matches valueForKey:@"currentSession"];
    }
    
    return currentSessionString;
}

- (void)loadArrays {
    
    // 60 - Normal
    self._60_Normal_Week1_WorkoutNameArray = @[@"Tone Balance",
                                               @"Bulk Plyometrics",
                                               @"Total Cardio",
                                               @"Iso Strength Tone",
                                               @"Rest",
                                               @"Iso Speed Bulk",
                                               @"Tone Endurance",
                                               @"Total Body Bulk",
                                               @"Ab Bulk"];         // 9
    
    self._60_Normal_Week2_WorkoutNameArray = @[@"Tone Cardio",
                                               @"Max Bulk Strength",
                                               @"Bulk Build Up",
                                               @"Tone Agility",
                                               @"Total Cardio",
                                               @"Glute Tone",
                                               @"Rest",
                                               @"Bulk Power",
                                               @"Tone Balance",
                                               @"Power Tone",
                                               @"Ab Tone",
                                               @"Bulk Conditioning",
                                               @"Leg Bulk"];        // 13
    
    self._60_Normal_Week3_WorkoutNameArray = @[@"Total Body Bulk",
                                               @"Leg Bulk",
                                               @"Tone Agility",
                                               @"Total Cardio",
                                               @"Max Bulk Strength",
                                               @"Ab Bulk",
                                               @"Rest",
                                               @"Total Body Tone",
                                               @"Ab Tone",
                                               @"Bulk Plyometrics",
                                               @"Total Cardio",
                                               @"Iso Strength Tone",
                                               @"Glute Tone"];      // 13
    
    self._60_Normal_Week4_WorkoutNameArray = @[@"Tone Balance",
                                               @"Power Tone",
                                               @"Ab Tone",
                                               @"Max Bulk Strength",
                                               @"Tone Cardio",
                                               @"Glute Tone",
                                               @"Rest",
                                               @"Iso Speed Bulk",
                                               @"Bulk Build Up",
                                               @"Leg Bulk",
                                               @"Tone Agility",
                                               @"Total Cardio",
                                               @"Bulk Power",
                                               @"Ab Bulk"];         // 14
    
    self._60_Normal_Week5_WorkoutNameArray = @[@"Total Body Tone",
                                               @"Ab Tone",
                                               @"Bulk Power",
                                               @"Ab Bulk",
                                               @"Tone Balance",
                                               @"Glute Tone",
                                               @"Rest",
                                               @"Iso Speed Bulk",
                                               @"Leg Bulk",
                                               @"Tone Endurance",
                                               @"Power Tone",
                                               @"Total Body Bulk",
                                               @"Bulk Build Up"];   // 13
    
    self._60_Normal_Week6_WorkoutNameArray = @[@"Tone Agility",
                                               @"Total Cardio",
                                               @"Glute Tone",
                                               @"Bulk Conditioning",
                                               @"Ab Bulk",
                                               @"Tone Cardio",
                                               @"Power Tone",
                                               @"Rest",
                                               @"Bulk Power",
                                               @"Tone Balance",
                                               @"Ab Tone",
                                               @"Max Bulk Strength",
                                               @"Bulk Build Up",
                                               @"Leg Bulk"];        // 14
    
    self._60_Normal_Week7_WorkoutNameArray = @[@"Total Body Tone",
                                               @"Ab Tone",
                                               @"Iso Speed Bulk",
                                               @"Leg Bulk",
                                               @"Iso Strength Tone",
                                               @"Rest",
                                               @"Bulk Conditioning",
                                               @"Tone Cardio",
                                               @"Glute Tone",
                                               @"Total Body Bulk",
                                               @"Ab Bulk"];         // 11
    
    self._60_Normal_Week8_WorkoutNameArray = @[@"Tone Endurance",
                                               @"Ab Tone",
                                               @"Max Bulk Strength",
                                               @"Bulk Build Up",
                                               @"Leg Bulk",
                                               @"Tone Cardio",
                                               @"Glute Tone",
                                               @"Rest",
                                               @"Bulk Plyometrics",
                                               @"Total Cardio",
                                               @"Leg Bulk",
                                               @"Total Body Tone",
                                               @"Power Tone",
                                               @"Glute Tone",
                                               @"Bulk Power",
                                               @"Ab Bulk"];         // 16
    
    self._60_Normal_WorkoutNameArray = @[self._60_Normal_Week1_WorkoutNameArray,
                                         self._60_Normal_Week2_WorkoutNameArray,
                                         self._60_Normal_Week3_WorkoutNameArray,
                                         self._60_Normal_Week4_WorkoutNameArray,
                                         self._60_Normal_Week5_WorkoutNameArray,
                                         self._60_Normal_Week6_WorkoutNameArray,
                                         self._60_Normal_Week7_WorkoutNameArray,
                                         self._60_Normal_Week8_WorkoutNameArray];
    
    
    // 30 - Bulk
    self._30_Bulk_Week1_WorkoutNameArray = @[@"Max Bulk Strength",
                                             @"Bulk Conditioning",
                                             @"Leg Bulk",
                                             @"Bulk Power",
                                             @"Rest",
                                             @"Bulk Plyometrics",
                                             @"Total Cardio",
                                             @"Total Body Bulk",
                                             @"Bulk Build Up",
                                             @"Iso Speed Bulk"];    // 10
    
    self._30_Bulk_Week2_WorkoutNameArray = @[@"Bulk Power",
                                             @"Ab Bulk",
                                             @"Total Body Bulk",
                                             @"Bulk Build Up",
                                             @"Max Bulk Strength",
                                             @"Rest",
                                             @"Iso Speed Bulk",
                                             @"Ab Bulk",
                                             @"Bulk Conditioning",
                                             @"Bulk Plyometrics",
                                             @"Total Cardio",
                                             @"Leg Bulk"];          // 12
    
    self._30_Bulk_Week3_WorkoutNameArray = @[@"Max Bulk Strength",
                                             @"Iso Speed Bulk",
                                             @"Bulk Build Up",
                                             @"Bulk Plyometrics",
                                             @"Ab Bulk",
                                             @"Rest",
                                             @"Bulk Power",
                                             @"Bulk Conditioning",
                                             @"Leg Bulk",
                                             @"Total Body Bulk",
                                             @"Ab Bulk"];           // 11
    
    self._30_Bulk_Week4_WorkoutNameArray = @[@"Iso Speed Bulk",
                                             @"Leg Bulk",
                                             @"Bulk Conditioning",
                                             @"Ab Bulk",
                                             @"Bulk Power",
                                             @"Rest",
                                             @"Bulk Plyometrics",
                                             @"Ab Bulk",
                                             @"Total Body Bulk",
                                             @"Max Bulk Strength",
                                             @"Bulk Build Up",
                                             @"Ab Bulk"];           // 12
    
    self._30_Bulk_WorkoutNameArray = @[self._30_Bulk_Week1_WorkoutNameArray,
                                       self._30_Bulk_Week2_WorkoutNameArray,
                                       self._30_Bulk_Week3_WorkoutNameArray,
                                       self._30_Bulk_Week4_WorkoutNameArray];
    
    
    // 30 - Tone
    self._30_Tone_Week1_WorkoutNameArray = @[@"Tone Endurance",
                                             @"Iso Strength Tone",
                                             @"Tone Agility",
                                             @"Power Tone",
                                             @"Rest",
                                             @"Total Body Tone",
                                             @"Tone Cardio",
                                             @"Glute Tone",
                                             @"Tone Balance"];      // 9
    
    self._30_Tone_Week2_WorkoutNameArray = @[@"Total Body Tone",
                                             @"Ab Tone",
                                             @"Tone Agility",
                                             @"Total Cardio",
                                             @"Iso Strength Tone",
                                             @"Ab Tone",
                                             @"Rest",
                                             @"Tone Balance",
                                             @"Glute Tone",
                                             @"Tone Endurance",
                                             @"Power Tone",
                                             @"Tone Cardio"];       // 12
    
    self._30_Tone_Week3_WorkoutNameArray = @[@"Tone Balance",
                                             @"Ab Tone",
                                             @"Tone Cardio",
                                             @"Tone Endurance",
                                             @"Rest",
                                             @"Iso Strength Tone",
                                             @"Power Tone",
                                             @"Tone Agility",
                                             @"Ab Tone",
                                             @"Total Body Tone",
                                             @"Glute Tone"];        // 11
    
    self._30_Tone_Week4_WorkoutNameArray = @[@"Iso Strength Tone",
                                             @"Ab Tone",
                                             @"Tone Agility",
                                             @"Total Cardio",
                                             @"Glute Tone",
                                             @"Total Body Tone",
                                             @"Power Tone",
                                             @"Ab Tone",
                                             @"Rest",
                                             @"Tone Endurance",
                                             @"Tone Balance",
                                             @"Ab Tone",
                                             @"Tone Cardio"];       // 13

    self._30_Tone_WorkoutNameArray = @[self._30_Tone_Week1_WorkoutNameArray,
                                       self._30_Tone_Week2_WorkoutNameArray,
                                       self._30_Tone_Week3_WorkoutNameArray,
                                       self._30_Tone_Week4_WorkoutNameArray];

    
    self._60_Normal_Week1_WorkoutIndexArray = @[@1,
                                                @1,
                                                @1,
                                                @1,
                                                @1,
                                                @1,
                                                @1,
                                                @1,
                                                @1];
    
    self._60_Normal_Week2_WorkoutIndexArray = @[@1,
                                                @1,
                                                @1,
                                                @1,
                                                @2,
                                                @1,
                                                @2,
                                                @1,
                                                @2,
                                                @1,
                                                @1,
                                                @1,
                                                @1];
    
    self._60_Normal_Week3_WorkoutIndexArray = @[@2,
                                                @2,
                                                @2,
                                                @3,
                                                @2,
                                                @2,
                                                @3,
                                                @1,
                                                @2,
                                                @2,
                                                @4,
                                                @2,
                                                @2];
    
    self._60_Normal_Week4_WorkoutIndexArray = @[@3,
                                                @2,
                                                @3,
                                                @3,
                                                @2,
                                                @3,
                                                @4,
                                                @2,
                                                @2,
                                                @3,
                                                @3,
                                                @5,
                                                @2,
                                                @3];
    
    self._60_Normal_Week5_WorkoutIndexArray = @[@2,
                                                @4,
                                                @3,
                                                @4,
                                                @4,
                                                @4,
                                                @5,
                                                @3,
                                                @4,
                                                @2,
                                                @3,
                                                @3,
                                                @3];
    
    self._60_Normal_Week6_WorkoutIndexArray = @[@4,
                                                @6,
                                                @5,
                                                @2,
                                                @5,
                                                @3,
                                                @4,
                                                @6,
                                                @4,
                                                @5,
                                                @5,
                                                @4,
                                                @4,
                                                @5];
    
    self._60_Normal_Week7_WorkoutIndexArray = @[@3,
                                                @6,
                                                @4,
                                                @6,
                                                @3,
                                                @7,
                                                @3,
                                                @4,
                                                @6,
                                                @4,
                                                @6];
    
    self._60_Normal_Week8_WorkoutIndexArray = @[@3,
                                                @7,
                                                @5,
                                                @5,
                                                @7,
                                                @5,
                                                @7,
                                                @8,
                                                @3,
                                                @7,
                                                @8,
                                                @4,
                                                @5,
                                                @8,
                                                @5,
                                                @7];
    
    self._60_Normal_WorkoutIndexArray = @[self._60_Normal_Week1_WorkoutIndexArray,
                                          self._60_Normal_Week2_WorkoutIndexArray,
                                          self._60_Normal_Week3_WorkoutIndexArray,
                                          self._60_Normal_Week4_WorkoutIndexArray,
                                          self._60_Normal_Week5_WorkoutIndexArray,
                                          self._60_Normal_Week6_WorkoutIndexArray,
                                          self._60_Normal_Week7_WorkoutIndexArray,
                                          self._60_Normal_Week8_WorkoutIndexArray];
    
    
    
    self._30_Bulk_Week1_WorkoutIndexArray = @[@1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1];
    
    self._30_Bulk_Week2_WorkoutIndexArray = @[@2,
                                              @1,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2];
    
    self._30_Bulk_Week3_WorkoutIndexArray = @[@3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @4];
    
    self._30_Bulk_Week4_WorkoutIndexArray = @[@4,
                                              @4,
                                              @4,
                                              @5,
                                              @4,
                                              @4,
                                              @4,
                                              @6,
                                              @4,
                                              @4,
                                              @4,
                                              @7];
    
    self._30_Bulk_WorkoutIndexArray = @[self._30_Bulk_Week1_WorkoutIndexArray,
                                        self._30_Bulk_Week2_WorkoutIndexArray,
                                        self._30_Bulk_Week3_WorkoutIndexArray,
                                        self._30_Bulk_Week4_WorkoutIndexArray];
    
    
    self._30_Tone_Week1_WorkoutIndexArray = @[@1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1,
                                              @1];
    
    self._30_Tone_Week2_WorkoutIndexArray = @[@2,
                                              @1,
                                              @2,
                                              @1,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2,
                                              @2];
        
    self._30_Tone_Week3_WorkoutIndexArray = @[@3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @3,
                                              @4,
                                              @3,
                                              @3];
    
    self._30_Tone_Week4_WorkoutIndexArray = @[@4,
                                              @5,
                                              @4,
                                              @2,
                                              @4,
                                              @4,
                                              @4,
                                              @6,
                                              @4,
                                              @4,
                                              @4,
                                              @7,
                                              @4];
    
    self._30_Tone_WorkoutIndexArray = @[self._30_Tone_Week1_WorkoutIndexArray,
                                        self._30_Tone_Week2_WorkoutIndexArray,
                                        self._30_Tone_Week3_WorkoutIndexArray,
                                        self._30_Tone_Week4_WorkoutIndexArray];
}
@end
