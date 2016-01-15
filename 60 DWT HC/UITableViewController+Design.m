//
//  UITableViewController+Design.m
//  90 DWT 2
//
//  Created by Grant, Jared on 11/17/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import "UITableViewController+Design.h"
#import "60DWTHCIAPHelper.h"

@implementation UITableViewController (Design)

- (void)configureAccessoryIconNonWorkoutList:(NSArray*)tableViewCellArray :(NSArray*)needsAccessoryIcon {

    // Accessory view icon
    UIImage* accessoryArrow = [UIImage imageNamed:@"nav_r_arrow_grey"];
    UITableViewCell *cell;
    UIImageView* accessoryView;
    
    for (int i = 0; i < tableViewCellArray.count; i++) {
        
        cell = tableViewCellArray[i];
        
        // Label and Subtitle Font Size
        //UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        UIFont *labelFont = [UIFont systemFontOfSize:18];
        [cell.textLabel setFont:labelFont];
        
        //UIFont *detailFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        UIFont *detailFont = [UIFont systemFontOfSize:17];
        [cell.detailTextLabel setFont:detailFont];
        
        // Accessory view icon
        if ([needsAccessoryIcon[i] boolValue]) {
            
            accessoryView = [[UIImageView alloc] initWithImage:accessoryArrow];
            cell.accessoryView = accessoryView;
        }
    }
}

- (void)configureAccessoryIconWorkoutList:(NSArray*)tableViewCellArray {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSString *routine = ((DataNavController *)self.parentViewController).routine;
    NSArray *workoutNameList;
    NSArray *workoutIndexList;
    
    if ([routine isEqualToString:@"60 - Normal"]) {
        
        // 60 - Normal
        for (int i = 0; i < appDelegate._60_Normal_WorkoutNameArray.count; i++) {
            
            //
            NSString *tempWeek = [NSString stringWithFormat:@"Week %d", i + 1];
            
            if ([week isEqualToString:tempWeek]) {
                
                workoutNameList = appDelegate._60_Normal_WorkoutNameArray[i];
                workoutIndexList = appDelegate._60_Normal_WorkoutIndexArray[i];
            }
        }
    }

    else if ([routine isEqualToString:@"30 - Bulk"]) {
        
        // 30 - Bulk
        for (int i = 0; i < appDelegate._30_Bulk_WorkoutNameArray.count; i++) {
            
            //
            NSString *tempWeek = [NSString stringWithFormat:@"Week %d", i + 1];
            
            if ([week isEqualToString:tempWeek]) {
                
                workoutNameList = appDelegate._30_Bulk_WorkoutNameArray[i];
                workoutIndexList = appDelegate._30_Bulk_WorkoutIndexArray[i];
            }
        }
    }
    
    else {
        
        // 30 - Tone
        for (int i = 0; i < appDelegate._30_Tone_WorkoutNameArray.count; i++) {
            
            //
            NSString *tempWeek = [NSString stringWithFormat:@"Week %d", i + 1];
            
            if ([week isEqualToString:tempWeek]) {
                
                workoutNameList = appDelegate._30_Tone_WorkoutNameArray[i];
                workoutIndexList = appDelegate._30_Tone_WorkoutIndexArray[i];
            }
        }
    }
    
    UITableViewCell *cell;
    
    for (int i = 0; i < tableViewCellArray.count; i++) {
        
        cell = tableViewCellArray[i];
        
        // Label and Subtitle Font Size
        //UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        UIFont *labelFont = [UIFont systemFontOfSize:18];
        [cell.textLabel setFont:labelFont];
        
        //UIFont *detailFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        UIFont *detailFont = [UIFont systemFontOfSize:17];
        [cell.detailTextLabel setFont:detailFont];
        
        BOOL tempWorkoutCompleted = [self workoutCompletedWithArguments:workoutIndexList[i] :routine :workoutNameList[i]];
        
        // Accessory view icon
        if (tempWorkoutCompleted == YES) {
            
            
            UIImage* accessoryCheckMark = [UIImage imageNamed:@"checkMark_orange_22"];
            UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryCheckMark];
            cell.accessoryView = accessoryView;
            
            
            /*
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
             */
        }
        
        else {

            UIImage* accessoryArrow = [UIImage imageNamed:@"nav_r_arrow_grey"];
            UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryArrow];
            cell.accessoryView = accessoryView;
        }
    }
}

- (void)configureCellBox:(NSArray*)cellBoxArray {
    
    UITextField *tempTextBox;
    
    for (int i = 0; i < cellBoxArray.count; i++) {
        
        tempTextBox = cellBoxArray[i];
        
        tempTextBox.layer.borderWidth = 1.0f;
        //tempTextBox.layer.borderColor = [lightGreen CGColor];
        tempTextBox.layer.cornerRadius = 15.0f;
        tempTextBox.clipsToBounds = YES;
        
        //UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        UIFont *font = [UIFont systemFontOfSize:18];
        [tempTextBox setFont:font];
        
    }
}

- (void)configureWorkoutLabels:(NSArray*)tableViewLabelArray :(NSArray*)tableViewDetailArray {
    
    UILabel *tempLabel;
    UILabel *tempDetail;
    
    //UIColor *orange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:1.0f];
    UIColor *gold = [UIColor colorWithRed:199/255.0f green:151/255.0f blue:6/255.0f alpha:1.0f];
    
    //UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    //UIFont *detailFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    
    UIFont *labelFont = [UIFont systemFontOfSize:18];
    UIFont *detailFont = [UIFont systemFontOfSize:17];
    
    // Label
    for (int i = 0; i < tableViewLabelArray.count; i++) {
        
        tempLabel = tableViewLabelArray[i];
        [tempLabel setFont:labelFont];
    }
    
    // Detail
    for (int i = 0; i < tableViewDetailArray.count; i++) {
        
        tempDetail = tableViewDetailArray[i];
        [tempDetail setFont:detailFont];
        tempDetail.textColor = gold;
    }
}

- (void)configureExerciseCell:(NSArray*)tableCell :(NSArray*)repNamesArray :(NSArray*)exerciseNamesArray :(NSArray*)previousTFArray :(NSArray*)currentTFArray :(NSArray*)exerciseLabelsArray :(NSArray*)repsLabelArray :(NSArray*)prevNotesArray :(NSArray*)curNotesArray : (NSArray*)graphBtnArray {
    
    UILabel *tempExerciseLabel;
    UIButton *tempGraphButton;
    UITextField *tempPreviousNotes;
    UITextField *tempCurrentNotes;
    UILabel *tempRepLabel;
    UITextField *tempPreviousTF;
    UITextField *tempCurrentTF;
    
    //UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    //UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:.75f];
    //UIColor *orange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:1.0f];
    
    //UIColor *gold = [UIColor colorWithRed:199/255.0f green:151/255.0f blue:6/255.0f alpha:1.0f];
    UIColor *lightGold = [UIColor colorWithRed:199/255.0f green:151/255.0f blue:6/255.0f alpha:0.75f];
    UIColor* redColor = [UIColor colorWithRed:204/255.0f green:76/255.0f blue:45/255.0f alpha:1.0f];
    UIColor* testBlueColor = [UIColor colorWithRed:47/255.0f green:120/255.0f blue:145/255.0f alpha:1.0f];
    
    //  Configure the Exercise Label, Graph Button, Previous Notes, and Current Notes
    for (int i = 0; i < tableCell.count; i++) {
        
        // Exercise Label
        tempExerciseLabel = exerciseLabelsArray[i];
        tempExerciseLabel.text = exerciseNamesArray[i];
        tempExerciseLabel.textColor = redColor;
        //UIFont *exerciseLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        UIFont *exerciseLabelFont = [UIFont systemFontOfSize:17];
        [tempExerciseLabel setFont:exerciseLabelFont];
        
        // Graph Button
        tempGraphButton = graphBtnArray[i];
        //UIFont *graphButtonFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        UIFont *graphButtonFont = [UIFont systemFontOfSize:17];
        tempGraphButton.titleLabel.font = graphButtonFont;
        //[tempGraphButton.titleLabel sizeToFit];
        tempGraphButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        tempGraphButton.layer.borderWidth = 1.0f;
        tempGraphButton.layer.borderColor = [testBlueColor CGColor];
        tempGraphButton.layer.cornerRadius = 5;
        tempGraphButton.clipsToBounds = YES;
        
        // Uncomment Only For Testing the Graph Button
        //tempGraphButton.hidden = NO;
        
        
        
        
        
        // Show or Hide Graph Button
        if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.graphview"]) {
            
            // User purchased the Graph View in-app purchase so show the Graph Button
            tempGraphButton.hidden = NO;
            
        } else {
            
            // Hide the Graph Button
            tempGraphButton.hidden = YES;
        }
        
        
        
         
        // Previous Notes
        tempPreviousNotes = prevNotesArray[i];
        tempPreviousNotes.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tempPreviousNotes.userInteractionEnabled = NO;
        tempPreviousNotes.textColor = [UIColor lightGrayColor];
        UIFont *previousNotesFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [tempPreviousNotes setFont:previousNotesFont];
        
        tempPreviousNotes.layer.borderWidth = 1.0f;
        tempPreviousNotes.layer.borderColor = [lightGold CGColor];
        tempPreviousNotes.layer.cornerRadius = 5;
        
        // Current Notes
        tempCurrentNotes = curNotesArray[i];
        tempCurrentNotes.textColor = [UIColor whiteColor];
        tempCurrentNotes.backgroundColor = lightGold;
        tempCurrentNotes.clearButtonMode = UITextFieldViewModeWhileEditing;
        tempCurrentNotes.keyboardAppearance = UIKeyboardAppearanceDark;
        UIFont *currentNotesFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [tempCurrentNotes setFont:currentNotesFont];
        
        tempCurrentNotes.layer.borderWidth = 1.0f;
        tempCurrentNotes.layer.borderColor = [lightGold CGColor];
        tempCurrentNotes.layer.cornerRadius = 5;
        
        tempCurrentNotes.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Notes" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} ];
    }
    
    for (int i = 0; i < repsLabelArray.count; i++) {
        
        tempRepLabel = repsLabelArray[i];
        tempPreviousTF = previousTFArray[i];
        tempCurrentTF = currentTFArray[i];
        
        tempRepLabel.text = repNamesArray[i];
        
        //  Hide the reps label, current textfield, and previous textfield if the reps label is an empty string
        if ([tempRepLabel.text isEqualToString:@""]) {
            
            tempRepLabel.hidden = YES;
            tempPreviousTF.hidden = YES;
            tempCurrentTF.hidden = YES;
        }
        
        //  Configure TextField Keyboard
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // IPHONE - Set the keyboard type of the Weight text box to DECIMAL NUMBER PAD.
            tempCurrentTF = currentTFArray[i];
            tempCurrentTF.keyboardType = UIKeyboardTypeDecimalPad;
            tempCurrentTF.keyboardAppearance = UIKeyboardAppearanceDark;
        }
        
        else {
            
            // IPAD - No decimal pad on ipad so set it to numbers and punctuation.
            tempCurrentTF = currentTFArray[i];
            tempCurrentTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            tempCurrentTF.keyboardAppearance = UIKeyboardAppearanceDark;
        }
        
        //  Labels
        tempRepLabel.textColor = [UIColor darkGrayColor];
        UIFont *repLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [tempRepLabel setFont:repLabelFont];
        
        //  Current textfields
        tempCurrentTF.textColor = [UIColor whiteColor];
        tempCurrentTF.layer.borderWidth = 1.0f;
        tempCurrentTF.layer.borderColor = [lightGold CGColor];
        tempCurrentTF.layer.cornerRadius = 5;
        tempCurrentTF.clipsToBounds = YES;
        tempCurrentTF.backgroundColor = lightGold;
        tempCurrentTF.clearsOnBeginEditing = YES;
        tempCurrentTF.textAlignment = NSTextAlignmentCenter;
        tempCurrentTF.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
        //  Previous textfields
        tempPreviousTF.layer.borderWidth = 1.0f;
        tempPreviousTF.layer.borderColor = [lightGold CGColor];
        tempPreviousTF.layer.cornerRadius = 5;
        tempPreviousTF.clipsToBounds = YES;
        tempPreviousTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tempPreviousTF.userInteractionEnabled = NO;
        tempPreviousTF.textAlignment = NSTextAlignmentCenter;
        tempPreviousTF.textColor = [UIColor lightGrayColor];
    }
    
    //NSLog(@"Section = %d", [section intValue]);
}

- (void)configureStoreTableView:(NSArray*)tableCell :(NSArray*)needAccessoryIcon :(NSArray*)needCellColor {
    
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    //UIColor *midGrey = [UIColor colorWithRed:219/255.0f green:218/255.0f blue:218/255.0f alpha:1.0f];
    //UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    
    // TableView background color
    //self.tableView.backgroundColor = midGrey;
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"nav_r_arrow_grey"];
    
    for (int i = 0; i < tableCell.count; i++) {
        
        UITableViewCell *cell = tableCell[i];
        
        // Label backgrounds
        UIColor* detailTextColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
        cell.detailTextLabel.textColor = detailTextColor;
        
        // Label and Subtitle Font Size
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        //cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // Accessory view icon
        if ([needAccessoryIcon[i] boolValue]) {
            UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessory];
            cell.accessoryView = accessoryView;
        }
        
        // Cell background color
        if ([needCellColor[i] boolValue]) {
            cell.backgroundColor = lightGrey;
        }
    }
}

- (void)configureDateCell:(UITableViewCell *)dateCell :(UIButton *)deleteButton :(UIButton *)todayButton :(UIButton *)previousButton :(UILabel *)dateLabel {
    
    UIColor *orange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:1.0f];
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *red = [UIColor colorWithRed:178/255.0f green:42/255.0f blue:9/255.0f alpha:1.0f];
    
    UIColor *lightOrange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:0.75f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:0.75f];
    UIColor *lightRed = [UIColor colorWithRed:178/255.0f green:42/255.0f blue:9/255.0f alpha:0.75f];
    
    BOOL tempWorkoutCompleted = [self workoutCompleted];
    
    if (tempWorkoutCompleted == YES) {
        
        //  Workout Completed
        
        // Cell
        dateCell.backgroundColor = [UIColor darkGrayColor];
        
        // Label
        dateLabel.text = [NSString stringWithFormat:@"Workout Completed: %@", [self getWorkoutCompletedDate]];
        dateLabel.textColor = [UIColor whiteColor];
    }
    else {
        
        // Workout Not Completed
        
        // Cell
        dateCell.backgroundColor = [UIColor whiteColor];
        
        // Label
        dateLabel.text = @"Workout Completed: __/__/__";
        dateLabel.textColor = [UIColor blackColor];
    }
    
    // Delete Button
    deleteButton.tintColor = [UIColor whiteColor];
    deleteButton.backgroundColor = lightRed;
    deleteButton.layer.borderWidth = 1.0f;
    deleteButton.layer.borderColor = [red CGColor];
    deleteButton.layer.cornerRadius = 5;
    deleteButton.clipsToBounds = YES;
    
    // Today Button
    todayButton.tintColor = [UIColor whiteColor];
    todayButton.backgroundColor = lightGreen;
    todayButton.layer.borderWidth = 1.0f;
    todayButton.layer.borderColor = [green CGColor];
    todayButton.layer.cornerRadius = 5;
    todayButton.clipsToBounds = YES;
    
    // Previous Button
    previousButton.tintColor = [UIColor whiteColor];
    previousButton.backgroundColor = lightOrange;
    previousButton.layer.borderWidth = 1.0f;
    previousButton.layer.borderColor = [orange CGColor];
    previousButton.layer.cornerRadius = 5;
    previousButton.clipsToBounds = YES;
}

/*
- (UIView*)configureSectionHeader:(NSArray*)tvHeaderStrings :(int)tvWidth :(int)tvSection {
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectZero];
    hView.backgroundColor=[UIColor clearColor];
    
    int x;
    int fontSize;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        // iPad
        x = 55;
        fontSize = 22;
    }
    else {
        // iPhone
        x = 20;
        fontSize = 19;
    }
    
    UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, tvWidth, 22)];
    
    hLabel.backgroundColor = [UIColor clearColor];
    hLabel.shadowColor = [UIColor darkTextColor];
    hLabel.shadowOffset = CGSizeMake(0, -1);  // closest as far as I could tell
    hLabel.textColor = [UIColor whiteColor];  // or whatever you want
    hLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
    hLabel.text = tvHeaderStrings[tvSection];
    
    [hView addSubview:hLabel];
    
    return hView;
}
 */
@end
