//
//  EmailViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/12/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsNavController.h"

@interface EmailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *defaultEmail;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)saveEmail:(id)sender;
@end
