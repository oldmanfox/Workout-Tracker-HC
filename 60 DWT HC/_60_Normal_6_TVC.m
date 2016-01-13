//
//  Bulk_6_TVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 2/11/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "_60_Normal_6_TVC.h"
#import "60DWTHCIAPHelper.h"
//#import <iAd/iAd.h>

@interface _60_Normal_6_TVC ()

@end

@implementation _60_Normal_6_TVC

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
    
    [self LoadArray];
    
    [self configureCellBox:self.cellBoxArray];
    
    [self configureAccessoryIconWorkoutList:self.tableCellArray];
    
    [self configureWorkoutLabels:self.tableLabelArray :self.tableDetailArray];

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
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"4046208fc4a74de38212426cf30fc747"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"302f462a787f4f7fb4b9f1610af40697"
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
    
    // Add rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
    
    // Add a long press gesture recognizer
    UILongPressGestureRecognizer *longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGRAction:)];
    longPGR.minimumPressDuration = 1.0f;
    longPGR.allowableMovement = 10.0f;
    [self.tableView addGestureRecognizer:longPGR];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
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

    [self configureAccessoryIconWorkoutList:self.tableCellArray];
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
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

- (void)LoadArray {
    
    self.cellBoxArray = @[self.cell1Box,
                          self.cell2Box,
                          self.cell3Box,
                          self.cell4Box,
                          self.cell5Box,
                          self.cell6Box,
                          self.cell7Box,
                          self.cell8Box,
                          self.cell9Box,
                          self.cell10Box,
                          self.cell11Box,
                          self.cell12Box,
                          self.cell13Box,
                          self.cell14Box];
    
    self.tableCellArray = @[self.cell1,
                            self.cell2,
                            self.cell3,
                            self.cell4,
                            self.cell5,
                            self.cell6,
                            self.cell7,
                            self.cell8,
                            self.cell9,
                            self.cell10,
                            self.cell11,
                            self.cell12,
                            self.cell13,
                            self.cell14];
    
    self.tableLabelArray = @[self.cell1Label,
                             self.cell2Label,
                             self.cell3Label,
                             self.cell4Label,
                             self.cell5Label,
                             self.cell6Label,
                             self.cell7Label,
                             self.cell8Label,
                             self.cell9Label,
                             self.cell10Label,
                             self.cell11Label,
                             self.cell12Label,
                             self.cell13Label,
                             self.cell14Label];
    
    self.tableDetailArray = @[self.cell1Detail,
                              self.cell2Detail,
                              self.cell6Detail,
                              self.cell7Detail,
                              self.cell12Detail,
                              self.cell13Detail];
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
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedRoutine = ((DataNavController *)self.parentViewController).routine;
    NSString *week = ((DataNavController *)self.parentViewController).week;
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *workoutArray;
    workoutArray = appDelegate._60_Normal_Week6_WorkoutNameArray;
    
    ((DataNavController *)self.parentViewController).workout = workoutArray[selectedCell.tag - 1];
    
    // Normal routine
    if ([selectedRoutine isEqualToString:@"Bulk"]) {
        
        // Week 6
        if ([week isEqualToString:@"Week 6"]) {
            
            if (selectedCell.tag == 1) {
                
                // B2: Back
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (selectedCell.tag == 2) {
                
                // B2: Arms
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (selectedCell.tag == 3) {
                
                // B3: Ab Workout
                ((DataNavController *)self.parentViewController).index = @8;
            }
            
            else if (selectedCell.tag == 4) {
                
                // B2: Shoulders
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (selectedCell.tag == 5) {
                
                // Rest
                ((DataNavController *)self.parentViewController).index = @6;
            }
            
            else if (selectedCell.tag == 6) {
                
                // B2: Chest
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (selectedCell.tag == 7) {
                
                // B2: Legs
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (selectedCell.tag == 8) {
                
                // B2: Back
                ((DataNavController *)self.parentViewController).index = @4;
            }
        }
    }
    
    //NSLog(@"%@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSInteger rows = 0;
    
    if (section == 0) {
        rows = 3;
    }
    
    else if (section == 1) {
        
        rows = 2;
    }
    
    else if (section == 2) {
        
        rows = 2;
    }
    
    else if (section == 3) {
        
        rows = 2;
    }
    
    else if (section == 4) {
        
        rows = 2;
    }

    else if (section == 5) {
        
        rows = 3;
    }
    
    return rows;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
 
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        
        NSString *routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@", ((DataNavController *)self.parentViewController).week];
        return routineWeek;
    }
    
    else {
        
        return @"";
    }
}

- (void)longPressGRAction:(UILongPressGestureRecognizer*)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        
        AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        CGPoint p = [sender locationInView:self.tableView];
        
        self.indexPath = [self.tableView indexPathForRowAtPoint:p];
        
        //NSLog(@"long press on table view at Section %d Row %d", indexPath.section, indexPath.row);
        
        if (self.indexPath) {
            
            // get affected cell and label
            
            //UITableViewCell *cell;
            //NSString *cellTitle;
            
            //self.position = [self findArrayPosition:self.indexPath];
            mainAppDelegate.selectedWorkoutArrayPositionValue = [self findArrayPosition:self.indexPath];
            
            for (int i = 0; i < self.tableCellArray.count; i++) {
                
                if (mainAppDelegate.selectedWorkoutArrayPositionValue == i) {
                    
                    self.argCell = self.tableCellArray[i];
                    UILabel *cellLabel = self.tableLabelArray[i];
                    self.cellTitle = cellLabel.text;
                }
            }
            
            if (self.argCell.isHighlighted) {
                
                [self LPGR_PressedSuccessfully:self.argCell :self.cellTitle];
            }
        }
    }
}

- (void)editButtonPressed:(UIBarButtonItem *)sender {
    
    [self BBI_EditButtonPressed:sender :self.tableCellArray];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self actionSheetDisplay:actionSheet clickedButtonAtIndex:buttonIndex :(UITableViewCell*)self.argCell :(NSString*)self.cellTitle :self.tableCellArray];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self alertViewDisplay:alertView clickedButtonAtIndex:buttonIndex :self.argCell :self.tableCellArray];
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
