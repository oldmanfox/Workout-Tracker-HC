//
//  SettingsTVC.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsNavController.h"
#import "DataNavController.h"
#import "MainTBC.h"
#import "EmailViewController.h"
#import "UITableViewController+Design.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"

@interface SettingsTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;  // Email.  Default is youremail@abc.com.
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;  // Version
@property (weak, nonatomic) IBOutlet UITableViewCell *cell3;  // Author
@property (weak, nonatomic) IBOutlet UITableViewCell *cell4;  // Website
@property (weak, nonatomic) IBOutlet UITableViewCell *cell5;  // Bands
@property (weak, nonatomic) IBOutlet UITableViewCell *cell6;  // Workout level
@property (weak, nonatomic) IBOutlet UITableViewCell *cell7;  // Current Session
@property (weak, nonatomic) IBOutlet UITableViewCell *cell8;  // Disable AutoLock
@property (weak, nonatomic) IBOutlet UITableViewCell *cell9;  // Reset
@property (weak, nonatomic) IBOutlet UITableViewCell *cell10; // iCloud Account status
@property (weak, nonatomic) IBOutlet UITableViewCell *cell11; // iCloud App status

@property (weak, nonatomic) IBOutlet UILabel *emailDetail;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultWorkout; // Bulk or Tone.  Default is Bulk.
@property (weak, nonatomic) IBOutlet UISwitch *bandsSwitch; // Using bands instead of free weights?
@property (weak, nonatomic) IBOutlet UISwitch *autoLockSwitch; // Disable autolock while using the app.
@property (weak, nonatomic) IBOutlet UILabel *currentSessionLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetAllDataButton;
@property (weak, nonatomic) IBOutlet UIButton *resetCurrentSessionDataButton;
@property (weak, nonatomic) IBOutlet UIButton *decreaseSessionButton;
@property (weak, nonatomic) IBOutlet UIButton *increaseSessionButton;
@property (weak, nonatomic) IBOutlet UILabel *iCloudAccountStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *iCloudAppStatusLabel;

- (IBAction)selectDefaultWorkout:(id)sender;
- (IBAction)toggleBands:(id)sender;
- (IBAction)decreaseSession:(id)sender;
- (IBAction)increaseSession:(id)sender;
- (IBAction)resetAllData:(id)sender;
- (IBAction)resetCurrentSessionData:(id)sender;
- (IBAction)toggleAutoLock:(id)sender;
@end
