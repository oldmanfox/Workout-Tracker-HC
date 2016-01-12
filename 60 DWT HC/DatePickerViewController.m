//
//  DatePickerViewController.m
//  60 DWT HC
//
//  Created by Jared Grant on 3/8/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureButtons];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if ((sysVer >= 8.0) || (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
        
        // Grab the selected date on the date picker.
        // Datepicker was presented in a popover.
        // Save data when user touches outside the popover.
        NSDate *chosen = [self.datePicker date];
        //NSLog(@"Modal Date = %@", chosen);

        [self saveWorkoutComplete:chosen];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)hideIOS8PopOver {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self hideIOS8PopOver];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    // Grab the selected date on the date picker
    NSDate *chosen = [self.datePicker date];
    //NSLog(@"Modal Date = %@", chosen);
    
    [self saveWorkoutComplete:chosen];
    
    [self hideIOS8PopOver];
}

- (void)configureButtons {
    
    //UIColor *orange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:1.0f];
    UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    UIColor *red = [UIColor colorWithRed:178/255.0f green:42/255.0f blue:9/255.0f alpha:1.0f];
    
    //UIColor *lightOrange = [UIColor colorWithRed:251/255.0f green:105/255.0f blue:55/255.0f alpha:0.75f];
    UIColor *lightGreen = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:0.75f];
    UIColor *lightRed = [UIColor colorWithRed:178/255.0f green:42/255.0f blue:9/255.0f alpha:0.75f];
    
    // Cancel Button
    self.cancelButton.tintColor = [UIColor whiteColor];
    self.cancelButton.backgroundColor = lightRed;
    self.cancelButton.layer.borderWidth = 1.0f;
    self.cancelButton.layer.borderColor = [red CGColor];
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.clipsToBounds = YES;
    
    // Save Button
    self.saveButton.tintColor = [UIColor whiteColor];
    self.saveButton.backgroundColor = lightGreen;
    self.saveButton.layer.borderWidth = 1.0f;
    self.saveButton.layer.borderColor = [green CGColor];
    self.saveButton.layer.cornerRadius = 5;
    self.saveButton.clipsToBounds = YES;

}
@end
