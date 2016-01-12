//
//  MeasurementsViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UIViewController+Social.h"
#import "CoreDataHelper.h"
#import "MeasurementsNavController.h"

@interface MeasurementsViewController : UIViewController<MFMailComposeViewControllerDelegate, UIActionSheetDelegate>

// Text Fields
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *chest;
@property (weak, nonatomic) IBOutlet UITextField *leftArm;
@property (weak, nonatomic) IBOutlet UITextField *rightArm;
@property (weak, nonatomic) IBOutlet UITextField *waist;
@property (weak, nonatomic) IBOutlet UITextField *hips;
@property (weak, nonatomic) IBOutlet UITextField *leftThigh;
@property (weak, nonatomic) IBOutlet UITextField *rightThigh;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *chestLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftArmLabel;
@property (weak, nonatomic) IBOutlet UILabel *waistLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightArmLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftThighLabel;
@property (weak, nonatomic) IBOutlet UILabel *hipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightThighLabel;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;

@property (strong, nonatomic) NSDictionary *measurementsDictonary;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)actionSheet:(UIBarButtonItem *)sender;
- (IBAction)saveAction:(UIButton *)sender;

@end
