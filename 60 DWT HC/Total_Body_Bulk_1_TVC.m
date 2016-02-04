//
//  Build_Shoulders_1_TVC.m
//  90 DWT BB
//
//  Created by Jared Grant on 2/27/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Total_Body_Bulk_1_TVC.h"
#import "UITableViewController+Database.h"
#import "UITableViewController+Design.h"
#import "DataNavController.h"
#import "60DWTHCIAPHelper.h"
#import "DatePickerViewController.h"
#import <iAd/iAd.h>

@interface Total_Body_Bulk_1_TVC ()

@end

@implementation Total_Body_Bulk_1_TVC

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
    
    [self loadArrays];
    
    [self saveDataNavControllerToAppDelegate];
    
    [self configureDateCell:self.dateCell :self.deleteDateButton :self.todayDateButton :self.previousDateButton :self.dateLabel];
    
    [self addAccessoryToolBar];
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iPhone
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"0c100c8b79754d7588f0e550a800e9ba"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"fa2d861291b34c5aaaaf93d0849c4818"
                                                        size:MOPUB_LEADERBOARD_SIZE];
            self.bannerSize = MOPUB_LEADERBOARD_SIZE;
            
        }
        
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        
        [self.headerView addSubview:self.adView];
        
        [self.adView loadAd];
    }
    
    self.navigationItem.title = ((DataNavController *)self.parentViewController).workout;
    
    //  Configure the cell...
    [self configureExerciseCell:self.CellArray :self.Reps :self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.exerciseLabelArray :self.repLabelArray :self.previousNotesArray :self.currentNotesArray :self.graphButtonArray];
    
    //  Configure roundBackgroundColorViews
    [self configureRoundBackgroundColor:self.roundBackgroundColorViewsArray :@"Blue"];
    
    //  Get data from the database
    [self exerciseMatches:self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.previousNotesArray :self.currentNotesArray];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.hidden = YES;
    }
}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [self updateWorkoutCompleteCell];
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    //} else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        self.adView.hidden = NO;
    }
}

- (void)loadArrays {
    
    self.Titles = @[@"Bench Press",
                    @"Squat",
                    @"Reverse Grip Row",
                    @"Incline Fly",
                    @"Reverse Lunge",
                    @"Wide Pull-Up",
                    @"Military Press",
                    @"Split Squat",
                    @"Post Delt Fly"];
    
    self.Reps = @[@"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 2
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 3
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 4
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 5
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 6
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 7
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 8
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6",
                  //  Cell 9
                  @"10",
                  @"8",
                  @"6",
                  @"10",
                  @"8",
                  @"6"];
    
    self.CellArray = @[self.cell_1,
                       self.cell_2,
                       self.cell_3,
                       self.cell_4,
                       self.cell_5,
                       self.cell_6,
                       self.cell_7,
                       self.cell_8,
                       self.cell_9];
    
    self.exerciseLabelArray = @[self.exerciseLabel_1,
                                self.exerciseLabel_2,
                                self.exerciseLabel_3,
                                self.exerciseLabel_4,
                                self.exerciseLabel_5,
                                self.exerciseLabel_6,
                                self.exerciseLabel_7,
                                self.exerciseLabel_8,
                                self.exerciseLabel_9];
    
    self.repLabelArray = @[self.rep_1,
                           self.rep_2,
                           self.rep_3,
                           self.rep_4,
                           self.rep_5,
                           self.rep_6,
                           self.rep_7,
                           self.rep_8,
                           self.rep_9,
                           self.rep_10,
                           self.rep_11,
                           self.rep_12,
                           self.rep_13,
                           self.rep_14,
                           self.rep_15,
                           self.rep_16,
                           self.rep_17,
                           self.rep_18,
                           self.rep_19,
                           self.rep_20,
                           self.rep_21,
                           self.rep_22,
                           self.rep_23,
                           self.rep_24,
                           self.rep_25,
                           self.rep_26,
                           self.rep_27,
                           self.rep_28,
                           self.rep_29,
                           self.rep_30,
                           self.rep_31,
                           self.rep_32,
                           self.rep_33,
                           self.rep_34,
                           self.rep_35,
                           self.rep_36,
                           self.rep_37,
                           self.rep_38,
                           self.rep_39,
                           self.rep_40,
                           self.rep_41,
                           self.rep_42,
                           self.rep_43,
                           self.rep_44,
                           self.rep_45,
                           self.rep_46,
                           self.rep_47,
                           self.rep_48,
                           self.rep_49,
                           self.rep_50,
                           self.rep_51,
                           self.rep_52,
                           self.rep_53,
                           self.rep_54];
    
    self.currentTextFieldArray = @[self.currentWeight_1,
                                   self.currentWeight_2,
                                   self.currentWeight_3,
                                   self.currentWeight_4,
                                   self.currentWeight_5,
                                   self.currentWeight_6,
                                   self.currentWeight_7,
                                   self.currentWeight_8,
                                   self.currentWeight_9,
                                   self.currentWeight_10,
                                   self.currentWeight_11,
                                   self.currentWeight_12,
                                   self.currentWeight_13,
                                   self.currentWeight_14,
                                   self.currentWeight_15,
                                   self.currentWeight_16,
                                   self.currentWeight_17,
                                   self.currentWeight_18,
                                   self.currentWeight_19,
                                   self.currentWeight_20,
                                   self.currentWeight_21,
                                   self.currentWeight_22,
                                   self.currentWeight_23,
                                   self.currentWeight_24,
                                   self.currentWeight_25,
                                   self.currentWeight_26,
                                   self.currentWeight_27,
                                   self.currentWeight_28,
                                   self.currentWeight_29,
                                   self.currentWeight_30,
                                   self.currentWeight_31,
                                   self.currentWeight_32,
                                   self.currentWeight_33,
                                   self.currentWeight_34,
                                   self.currentWeight_35,
                                   self.currentWeight_36,
                                   self.currentWeight_37,
                                   self.currentWeight_38,
                                   self.currentWeight_39,
                                   self.currentWeight_40,
                                   self.currentWeight_41,
                                   self.currentWeight_42,
                                   self.currentWeight_43,
                                   self.currentWeight_44,
                                   self.currentWeight_45,
                                   self.currentWeight_46,
                                   self.currentWeight_47,
                                   self.currentWeight_48,
                                   self.currentWeight_49,
                                   self.currentWeight_50,
                                   self.currentWeight_51,
                                   self.currentWeight_52,
                                   self.currentWeight_53,
                                   self.currentWeight_54];
    
    self.previousTextFieldArray = @[self.previousWeight_1,
                                    self.previousWeight_2,
                                    self.previousWeight_3,
                                    self.previousWeight_4,
                                    self.previousWeight_5,
                                    self.previousWeight_6,
                                    self.previousWeight_7,
                                    self.previousWeight_8,
                                    self.previousWeight_9,
                                    self.previousWeight_10,
                                    self.previousWeight_11,
                                    self.previousWeight_12,
                                    self.previousWeight_13,
                                    self.previousWeight_14,
                                    self.previousWeight_15,
                                    self.previousWeight_16,
                                    self.previousWeight_17,
                                    self.previousWeight_18,
                                    self.previousWeight_19,
                                    self.previousWeight_20,
                                    self.previousWeight_21,
                                    self.previousWeight_22,
                                    self.previousWeight_23,
                                    self.previousWeight_24,
                                    self.previousWeight_25,
                                    self.previousWeight_26,
                                    self.previousWeight_27,
                                    self.previousWeight_28,
                                    self.previousWeight_29,
                                    self.previousWeight_30,
                                    self.previousWeight_31,
                                    self.previousWeight_32,
                                    self.previousWeight_33,
                                    self.previousWeight_34,
                                    self.previousWeight_35,
                                    self.previousWeight_36,
                                    self.previousWeight_37,
                                    self.previousWeight_38,
                                    self.previousWeight_39,
                                    self.previousWeight_40,
                                    self.previousWeight_41,
                                    self.previousWeight_42,
                                    self.previousWeight_43,
                                    self.previousWeight_44,
                                    self.previousWeight_45,
                                    self.previousWeight_46,
                                    self.previousWeight_47,
                                    self.previousWeight_48,
                                    self.previousWeight_49,
                                    self.previousWeight_50,
                                    self.previousWeight_51,
                                    self.previousWeight_52,
                                    self.previousWeight_53,
                                    self.previousWeight_54];
    
    self.currentNotesArray = @[self.currentNotes_1,
                               self.currentNotes_2,
                               self.currentNotes_3,
                               self.currentNotes_4,
                               self.currentNotes_5,
                               self.currentNotes_6,
                               self.currentNotes_7,
                               self.currentNotes_8,
                               self.currentNotes_9];
    
    self.previousNotesArray = @[self.previousNotes_1,
                                self.previousNotes_2,
                                self.previousNotes_3,
                                self.previousNotes_4,
                                self.previousNotes_5,
                                self.previousNotes_6,
                                self.previousNotes_7,
                                self.previousNotes_8,
                                self.previousNotes_9];
    
    self.graphButtonArray = @[self.graphButton_1,
                              self.graphButton_2,
                              self.graphButton_3,
                              self.graphButton_4,
                              self.graphButton_5,
                              self.graphButton_6,
                              self.graphButton_7,
                              self.graphButton_8,
                              self.graphButton_9];
    
    self.roundBackgroundColorViewsArray = @[self.roundBackgroundColorView_1,
                                            self.roundBackgroundColorView_2,
                                            self.roundBackgroundColorView_3,
                                            self.roundBackgroundColorView_4,
                                            self.roundBackgroundColorView_5,
                                            self.roundBackgroundColorView_6,
                                            self.roundBackgroundColorView_7,
                                            self.roundBackgroundColorView_8,
                                            self.roundBackgroundColorView_9];
}

- (void)addAccessoryToolBar
{
    // Create the toolbar to go above the keyboard.
    UIToolbar *accessoryToolBar = [[UIToolbar alloc] init];
    accessoryToolBar.barTintColor = [UIColor darkGrayColor];
    
    // Create buttons for the toolbar.
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)];
    
    UIBarButtonItem *flexableSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveWithNumberPad)];
    
    // Add buttons to the toolbar.
    accessoryToolBar.items = [NSArray arrayWithObjects:cancel, flexableSpace, save, nil];
    
    [accessoryToolBar sizeToFit];
    
    //  Change color of the toolbar and buttons.
    accessoryToolBar.barTintColor = [UIColor darkGrayColor];
    cancel.tintColor = [UIColor whiteColor];
    save.tintColor = [UIColor whiteColor];
    
    // Set the toolbar to show for all the textfields.
    for (int i = 0; i < self.currentTextFieldArray.count; i++) {
        
        UITextField *tempTextField = self.currentTextFieldArray[i];
        tempTextField.inputAccessoryView = accessoryToolBar;
    }
}

- (void)cancelNumberPad {
    
    //  Dismiss the keyboard.
    [self.view endEditing:YES];
}


- (void)saveWithNumberPad {
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    [self saveData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3 + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
}

/*
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 // Return the number of rows in the section.
 
 NSArray *tempSectionTitleArray = self.Titles[section];
 
 return tempSectionTitleArray.count;
 }
 */

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 ExerciseCell *cell;
 
 NSString *cellIdentifier = @"ExerciseCell";
 //cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", indexPath.section + 1];
 //cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", [self findCurrentRow:indexPath]];
 
 cellIdentifier = [NSString stringWithFormat:@"%@_%d_%d", cellIdentifier, indexPath.section, indexPath.row];
 NSLog(@"%@", cellIdentifier);
 
 cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
 
 cell.weightField1.delegate = self;
 cell.weightField2.delegate = self;
 cell.weightField3.delegate = self;
 cell.weightField4.delegate = self;
 cell.weightField5.delegate = self;
 cell.weightField6.delegate = self;
 
 //  Configure the cell...
 [self configureExerciseCell:cell :indexPath :self.Reps[indexPath.section] :self.Titles[indexPath.section]];
 
 //  Get data from the database
 //NSInteger section = [indexPath section];
 [self exerciseMatches:cell :indexPath];
 
 
 //  Only save cells in the current section so that you can access them later when you need to save to database.
 if (indexPath.section == 0 && self.CellArray.count < self.Titles.count) {
 [self.CellArray addObject:cell];
 }
 
 
 [self.CellArray addObject:cell];
 
 return cell;
 }
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == [self numberOfSectionsInTableView:self.tableView] - 1) {
        
        return @"Finished";
    }
    else {
        
        NSNumber *headerSection = [NSNumber numberWithInteger:section +1];
        NSNumber *numberOfSections = [NSNumber numberWithInteger:self.tableView.numberOfSections - 1];
        NSString *headerTitle = @"";
        headerTitle = [headerTitle stringByAppendingFormat:@"Set %@ of %@", headerSection, numberOfSections];
        
        return headerTitle;
    }
}

- (IBAction)submitEntries:(id)sender {
    
    //  Save to the database
    [self saveData];
    
    [self shareActionSheet];
}

- (IBAction)showGraph:(UIButton *)sender {
    
    [self saveData];

    int minRange = 0;
    int maxRange = 0;
    NSMutableArray *tempArray;
    tempArray = [[NSMutableArray alloc] init];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (int i = 0; i < self.graphButtonArray.count; i++) {
        
        if (self.graphButtonArray[i] == sender) {
            
            // Get name of exercise for this cell
            UILabel *tempLabel = self.exerciseLabelArray[i];
            //NSLog(@"Button = graphButton_%d", i + 1);
            
            mainAppDelegate.graphTitle = tempLabel.text;
            mainAppDelegate.graphRoutine = ((DataNavController *)self.parentViewController).routine;
            mainAppDelegate.graphWorkout = ((DataNavController *)self.parentViewController).workout;
            //NSLog(@"GraphTitle = %@", mainAppDelegate.graphTitle);
            //NSLog(@"GraphRoutine = %@", mainAppDelegate.graphRoutine);
            //NSLog(@"GraphWorkout = %@", mainAppDelegate.graphWorkout)
            
            // Get the beginning and end range for the reps labels in the cell
            minRange = i * 6;
            maxRange = (i * 6) + 6;
        }
    }
    
    // Get the number of reps labels in the cell that aren't ""
    for (int j = minRange; j < maxRange; j++) {
        
        if (![self.Reps[j] isEqualToString:@""]) {
            
            NSString *tempString = self.Reps[j];
            [tempArray addObject:tempString];
        }
    }
    
    mainAppDelegate.graphDataPoints = tempArray;
    
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        [self performSegueWithIdentifier:@"showPopover" sender:sender];
        
    }
}

- (void)shareActionSheet {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Data saved successfully.  Share your progress!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email .csv File", @"Facebook", @"Twitter", nil];
    
    [action showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
    
    self.actionSheetType = @"Share";
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([self.actionSheetType isEqualToString:@"Share"]) {
        
        if (buttonIndex == 0) {
            
            //  Get the csvstring and then send the email
            [self sendEmail:[self stringForEmail:self.Titles] ];
        }
        
        if (buttonIndex == 1) {
            
            [self facebook];
        }
        
        if (buttonIndex == 2) {
            
            [self twitter];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //  Save to the database
    [self saveData];
}

- (void)saveData {
    
    //  Save to the database
    [self saveToDatabase:self.Titles :self.Reps :self.currentTextFieldArray :self.currentNotesArray];
}

#pragma mark - Popover methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *destNav = segue.destinationViewController;
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        
        // This is the important part
        UIPopoverPresentationController *popPC = destNav.popoverPresentationController;
        popPC.delegate = self;
        popPC.sourceView = sender;
        //popPC.sourceRect = sender.bounds;
        popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    [self updateWorkoutCompleteCell];
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    [self updateWorkoutCompleteCell];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
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
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (IBAction)workoutCompletedToday:(UIButton *)sender {
    
    [self saveData];
    
    [self saveWorkoutComplete:[NSDate date]];
    
    [self updateWorkoutCompleteCell];
}

- (IBAction)workoutCompletedPrevious:(UIButton *)sender {
    
    [self saveData];
    
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        [self performSegueWithIdentifier:@"iOS8_PopoverDatePicker" sender:sender];
        
    }
}

- (IBAction)workoutCompletedDelete:(UIButton *)sender {
    
    [self saveData];
    
    [self deleteDate];
    
    [self updateWorkoutCompleteCell];
}

- (void)updateWorkoutCompleteCell {
    
    [self configureDateCell:self.dateCell :self.deleteDateButton :self.todayDateButton :self.previousDateButton :self.dateLabel];
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.bannerSize.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    if (self.headerView.frame.size.height == 0) {
        
        // No ads shown yet.  Animate showing the ad.
        CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.bannerSize.height);
        
        [UIView animateWithDuration:0.25 animations:^{ self.headerView.frame = headerViewFrame;
            self.tableView.tableHeaderView = self.headerView;
            self.adView.hidden = YES;}
         
                         completion:^(BOOL finished) {self.adView.hidden = NO;
                         }];
        
    } else {
        
        // Ad is already showing.
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    self.adView.hidden = YES;
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize size = [self.adView adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.headerView.bounds.size.height - size.height;
    self.adView.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    self.adView.hidden = NO;
}
@end
