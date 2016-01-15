//
//  ExerciseChartViewController.h
//  90 DWT BB
//
//  Created by Grant, Jared on 1/16/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataNavController.h"
#import "Workout.h"

@interface ExerciseChartViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSEntityDescription *entityDesc;
@property (strong, nonatomic) NSFetchRequest *request;
@property (strong, nonatomic) NSPredicate *pred;
@property (strong, nonatomic) Workout *matches;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSArray *objects;
@end
