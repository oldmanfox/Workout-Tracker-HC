//
//  DataNavController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "DataNavController.h"
#import "60DWTHCIAPHelper.h"
#import "AppDelegate.h"

@interface DataNavController ()

@end

@implementation DataNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (((MainTBC *)self.parentViewController).workoutChanged) {
        
        [self popToRootViewControllerAnimated:YES];
        ((MainTBC *)self.parentViewController).workoutChanged = NO;
    }
    
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if (appDelegate.purchasedAdRemoveBeforeAppLaunch) {
            
            // Do nothing.  No need to pop to root view controller.
            
        } else {
            
            [self popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Populate the Arrays with their workouts.  Some workouts have more than one round (like chestBack).
    // I added the round at the end of each exercise to distinguish it from the previous round when storing.
    
    
self.negativeLower = @[@"Squat Round 1",
                       @"Lunge Round 1",
                       @"Wide Squat Round 1",
                       @"1 Leg Squat Round 1",
                       @"Side High Knee Kick Round 1",
                       @"Front High Knee Kick Round 1",
                       @"1 Leg Lunge Round 1",
                       @"Side Lunge Raise Round 1",
                       @"1 Leg Squat Punch Round 1",
                       @"Side Sphinx Leg Lift Round 1",
                       @"Laying Heel Raise Round 1",
                       @"Pommel Horse V Round 1",
                       @"Downward Dog Calf Extension Round 1"];
                    
self.negativeUpper = @[@"Push-Ups Round 1",
                       @"Pull-Ups Round 1",
                       @"Shoulder Press Round 1",
                       @"Military Push-Ups Round 1",
                       @"Underhand Pull-Ups Round 1",
                       @"Bicep Curl to Shoulder Press Round 1",
                       @"Wide Push-Ups Round 1",
                       @"Side to Side Pull-Ups Round 1",
                       @"Upright Row to Hammer Round 1",
                       @"Offset Push-Ups Round 1",
                       @"Leaning Row Round 1",
                       @"2 Way Shoulder Raise Round 1",
                       @"Plyometric Push-Ups Round 1",
                       @"Opposite Grip Pull-Ups Round 1",
                       @"Leaning Shoulder Flys Round 1",
                       @"Leaning Tricep Extension Round 1",
                       @"2 Way Bicep Curl Round 1",
                       @"Tricep Pelvis Raise Round 1",
                       @"Leaning Preacher Curl Round 1",
                       
                       //Bonus
                       @"BONUS Military Push-Ups Round 1",
                       @"BONUS Wide Pull-Ups Round 1"];
    
self.agilityUpper = @[@"Slow Underhand Pull-Ups Round 1",
                      @"Rotating Plyometric Push-Ups Round 1",
                      @"Plyometric Lunge Press Round 1",
                      @"3 Way Pull-Ups Round 1",
                      @"Push-Up Plank Cross Crunch Round 1",
                      
                      // 2
                      @"Slow Underhand Pull-Ups Round 2",
                      @"Rotating Plyometric Push-Ups Round 2",
                      @"Plyometric Lunge Press Round 2",
                      @"3 Way Pull-Ups Round 2",
                      @"Push-Up Plank Cross Crunch Round 2",
                      
                      //3
                      @"Slow Underhand Pull-Ups Round 3",
                      @"Rotating Plyometric Push-Ups Round 3",
                      @"Plyometric Lunge Press Round 3",
                      @"3 Way Pull-Ups Round 3",
                      @"Push-Up Plank Cross Crunch Round 3",
                      
                      // 4
                      @"Slow Underhand Pull-Ups Round 4",
                      @"Rotating Plyometric Push-Ups Round 4",
                      @"Plyometric Lunge Press Round 4",
                      @"3 Way Pull-Ups Round 4",
                      @"Push-Up Plank Cross Crunch Round 4",
                      
                      // Bonus - 5
                      @"BONUS Slow Underhand Pull-Ups Round 5",
                      @"BONUS Rotating Plyometric Push-Ups Round 5",
                      @"BONUS Plyometric Lunge Press Round 5",
                      @"BONUS 3 Way Pull-Ups Round 5",
                      @"BONUS Push-Up Plank Cross Crunch Round 5"];
    
self.agilityLower = @[@"1 Leg Squat Round 1",
                      @"Plyometric Lunge Press Round 1",
                      @"Side Jump Hops Round 1",
                      @"Dead Squat Lunge Round 1",
                      @"Alt Side Sphinx Leg Raise Round 1",
                      
                      // 2
                      @"1 Leg Squat Round 2",
                      @"Plyometric Lunge Press Round 2",
                      @"Side Jump Hops Round 2",
                      @"Dead Squat Lunge Round 2",
                      @"Alt Side Sphinx Leg Raise Round 2",
                      
                      // 3
                      @"1 Leg Squat Round 3",
                      @"Plyometric Lunge Press Round 3",
                      @"Side Jump Hops Round 3",
                      @"Dead Squat Lunge Round 3",
                      @"Alt Side Sphinx Leg Raise Round 3",
                      
                      // 4
                      @"1 Leg Squat Round 4",
                      @"Plyometric Lunge Press Round 4",
                      @"Side Jump Hops Round 4",
                      @"Dead Squat Lunge Round 4",
                      @"Alt Side Sphinx Leg Raise Round 4"];
                          
self.devastator = @[@"Plank Row Round 1",
                    @"Pull-Ups Round 1",
                    @"Laying Chest Flys Round 1",
                    @"Push-Ups Round 1",
                    @"Leaning Row Round 1",
                    @"Underhand Pull-Ups Round 1",
                    @"Laying Chest Press Round 1",
                    @"Military Push-Ups Round 1",
                    @"3 Way Shoulder Round 1",
                    @"Decline Shoulder Press Round 1",
                    @"Leaning Shoulder Flys Round 1",
                    @"Sphinx to A Round 1",
                    @"Hammer Curls Round 1",
                    @"Leaning Curls Round 1",
                    @"Laying Cross Tricep Extension Round 1",
                    @"Tricep Pelvis Raise Round 1",
                    @"2 Way Curl Round 1",
                    @"Leaning Tricep Extension Round 1",
                    
                    // Bonus
                    @"BONUS Push-Ups Plank Sphinx Round 1"];
    
self.completeFitness = @[@"Push-Up to Arm Balance Round 1",
                         @"Crescent to Chair Round 1",
                         @"Pull-Up Crunch Round 1",
                         @"Side Sphinx Crunch Round 1",
                         @"Plyometric Runner Push-Ups Round 1",
                         @"Wide Squat on Toes Round 1",
                         @"Underhand Pull-Up Crunch Round 1",
                         @"V to Plow Round 1",
                         @"Balance Circle Press Round 1",
                         @"Lateral Jump Press Round 1",
                         @"Balance 2 Way Hammer Round 1",
                         @"V Crunch Round 1",
                         @"Balance 2 Way Arm Raise Round 1",
                         @"Squat Front Back Round 1",
                         @"Laying Tricep Extension Punch Round 1",
                         @"3 Way Warrior Round 1"];
    
self.theGoal = @[@"Wide Pull-Up Round 1",
                 @"Push-Up Round 1",
                 @"Wide Pull-Up Round 2",
                 @"Push-Up Round 2",
                 
                 @"Underhand Pull-Up Round 1",
                 @"Military Push-Up Round 1",
                 @"Underhand Pull-Up Round 2",
                 @"Military Push-Up Round 2",
                 
                 @"Narrow Pull-Up Round 1",
                 @"Wide Push-Up Round 1",
                 @"Narrow Pull-Up Round 2",
                 @"Wide Push-Up Round 2",
                 
                 @"Opposite Grip Pull-Up Round 1",
                 @"Offset Push-Up Round 1",
                 @"Opposite Grip Pull-Up Round 2",
                 @"Offset Push-Up Round 2",
                 
                 @"BONUS Pull-Up Push-Up Round 1"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // This just says I only support the portriat mode orientation.  If I wanted to support landscape
    // I would put that here.
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
