//
//  NotesViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <iAd/iAd.h>
#import <MessageUI/MessageUI.h>
#import "DataNavController.h"
#import "AppDelegate.h"
//#import "Workout_AbRipper_ResultsViewController.h"
#import "UIViewController+Social.h"
#import "Workout.h"
#import "UIViewController+CoreData.h"
//#import "MPAdView.h"

@interface NotesViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextViewDelegate, UIActionSheetDelegate, UIPopoverPresentationControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *currentNotes;
@property (weak, nonatomic) IBOutlet UILabel *round;
@property (weak, nonatomic) IBOutlet UITextView *previousNotes;

@property (weak, nonatomic) IBOutlet UILabel *currentNotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *previousNotesLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareActionButton;

@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteDateButton;
@property (weak, nonatomic) IBOutlet UIButton *todayDateButton;
@property (weak, nonatomic) IBOutlet UIButton *previousDateButton;

- (IBAction)submitEntry:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)shareActionSheet:(UIBarButtonItem *)sender;
- (IBAction)workoutCompletedDelete:(UIButton *)sender;
- (IBAction)workoutCompletedToday:(UIButton *)sender;
- (IBAction)workoutCompletedPrevious:(UIButton *)sender;

@end
