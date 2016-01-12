//
//  DatePickerViewController.h
//  60 DWT HC
//
//  Created by Jared Grant on 3/8/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CoreData.h"

@interface DatePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) NSDate *chosenDate;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
@end
