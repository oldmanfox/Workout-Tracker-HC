//
//  UITableViewController+Design.h
//  90 DWT 2
//
//  Created by Grant, Jared on 11/17/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseCell.h"
#import "UITableViewController+Database.h"
#import "DataNavController.h"
#import "AppDelegate.h"

@interface UITableViewController (Design)

- (void)configureAccessoryIconNonWorkoutList:(NSArray*)tableViewCellArray :(NSArray*)needsAccessoryIcon;
- (void)configureAccessoryIconWorkoutList:(NSArray*)tableViewCellArray;
- (void)configureCellBox:(NSArray*)cellBoxArray;
- (void)configureWorkoutLabels:(NSArray*)tableViewLabelArray :(NSArray*)tableViewDetailArray;
- (void)configureExerciseCell:(NSArray*)tableCell :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)exerciseLabelsArray :(NSArray*)repsLabelArray :(NSArray*)prevNotesArray :(NSArray*)curNotesArray : (NSArray*)graphBtnArray;
//- (UIView*)configureSectionHeader:(NSArray*)tvHeaderStrings :(int)tvWidth :(int)tvSection;
- (void)configureStoreTableView:(NSArray*)tableCell :(NSArray*)needAccessoryIcon :(NSArray*)needCellColor;
- (void)configureDateCell:(UITableViewCell*)dateCell :(UIButton*)deleteButton :(UIButton*)todayButton :(UIButton*)previousButton :(UILabel*)dateLabel;
@end
