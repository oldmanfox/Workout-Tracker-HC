//
//  MeasurementsReportViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "MeasurementsReportViewController.h"
#import "AppDelegate.h"

@interface MeasurementsReportViewController ()

@end

@implementation MeasurementsReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Respond to changes in underlying store
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"SomethingChanged"
                                               object:nil];

    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    self.view.backgroundColor = lightGrey;
    
    [self loadMeasurements];
    [self.htmlView loadHTMLString:[self createHTML] baseURL:nil];
    self.htmlView.backgroundColor = [UIColor clearColor];
    self.htmlView.opaque = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)emailSummary {

    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
    // Check to see if the device has at least 1 email account configured
    if ([MFMailComposeViewController canSendMail]) {
        
        AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        // Create an array of measurements to iterate thru when building the table rows.
        NSArray *measurementsArray = @[self.month1Array, self.month2Array, self.finalArray];
        NSArray *measurementsMonth = @[@"Start Month 1", @"Start Month 2", @"Final"];
        
        NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
        [writeString appendString:[NSString stringWithFormat:@"Session,Month,Weight,Chest,Left Arm,Right Arm,Waist,Hips,Left Thigh,Right Thigh\n"]];
        
        for (int i = 0; i < measurementsMonth.count; i++) {
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@", [mainAppDelegate getCurrentSession], measurementsMonth[i]]];
            
            for (int j = 0; j < self.month1Array.count; j++) {
                
                [writeString appendString:[NSString stringWithFormat:@",%@", measurementsArray[i][j]]];
            }
            
            [writeString appendString:@"\n"];
        }
        
        NSData *csvData = [writeString dataUsingEncoding:NSASCIIStringEncoding];
        NSString *fileName = [self.navigationItem.title stringByAppendingFormat:@" Measurements - Session %@.csv", [mainAppDelegate getCurrentSession]];
        
        // Fetch defaultEmail data.
        NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
        
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        // Array to store the default email address.
        NSArray *emailAddresses;
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            
            // There is a default email address.
            emailAddresses = @[[matches valueForKey:@"defaultEmail"]];
        }
        else {
            
            // There is NOT a default email address.  Put an empty email address in the arrary.
            emailAddresses = @[@""];
        }
        
        [mailComposer setToRecipients:emailAddresses];
        
        NSString *subject = @"60 DWT HC";
        subject = [subject stringByAppendingFormat:@" %@ Measurements - Session %@", self.navigationItem.title, [mainAppDelegate getCurrentSession]];
        [mailComposer setSubject:subject];
        [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:fileName];
        [self presentViewController:mailComposer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}

- (IBAction)actionSheet:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Facebook", @"Twitter", nil];
    [action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self emailSummary];
    }
    
    if (buttonIndex == 1) {
        [self facebook];
    }
    
    if (buttonIndex == 2) {
        [self twitter];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadMeasurements {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    NSArray *monthArray = @[@"1",
                            @"2",
                            @"3"];
    
    self.month1Array = [[NSMutableArray alloc] init];
    self.month2Array = [[NSMutableArray alloc] init];
    self.finalArray = [[NSMutableArray alloc] init];
    
    // Get workout data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Measurement" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    for (int i = 0 ; i < monthArray.count; i++) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (month = %@)", currentSessionString, monthArray[i]];
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects count] >= 1) {
            matches = objects[[objects count]-1];
            
            if ([monthArray[i] isEqualToString:@"1"]) {
                
                // Weight
                if ([[matches valueForKey:@"weight"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"weight"]];
                }
                
                // Chest
                if ([[matches valueForKey:@"chest"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"chest"]];
                }
                
                // Left Arm
                if ([[matches valueForKey:@"leftArm"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"leftArm"]];
                }
                
                // Right Arm
                if ([[matches valueForKey:@"rightArm"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"rightArm"]];
                }
                
                // Waist
                if ([[matches valueForKey:@"waist"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"waist"]];
                }
                
                // Hips
                if ([[matches valueForKey:@"hips"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"hips"]];
                }
                
                // Left Thigh
                if ([[matches valueForKey:@"leftThigh"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"leftThigh"]];
                }
                
                // Right Thigh
                if ([[matches valueForKey:@"rightThigh"] isEqualToString:@""]) {
                    [self.month1Array addObject:@"0"];
                } else {
                    [self.month1Array addObject:[matches valueForKey:@"rightThigh"]];
                }
            }
            
            if ([monthArray[i] isEqualToString:@"2"]) {
                
                // Weight
                if ([[matches valueForKey:@"weight"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"weight"]];
                }
                
                // Chest
                if ([[matches valueForKey:@"chest"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"chest"]];
                }
                
                // Left Arm
                if ([[matches valueForKey:@"leftArm"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"leftArm"]];
                }
                
                // Right Arm
                if ([[matches valueForKey:@"rightArm"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"rightArm"]];
                }
                
                // Waist
                if ([[matches valueForKey:@"waist"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"waist"]];
                }
                
                // Hips
                if ([[matches valueForKey:@"hips"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"hips"]];
                }
                
                // Left Thigh
                if ([[matches valueForKey:@"leftThigh"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"leftThigh"]];
                }
                
                // Right Thigh
                if ([[matches valueForKey:@"rightThigh"] isEqualToString:@""]) {
                    [self.month2Array addObject:@"0"];
                } else {
                    [self.month2Array addObject:[matches valueForKey:@"rightThigh"]];
                }
            }
            
            if ([monthArray[i] isEqualToString:@"3"]) {
                
                // Weight
                if ([[matches valueForKey:@"weight"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"weight"]];
                }
                
                // Chest
                if ([[matches valueForKey:@"chest"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"chest"]];
                }
                
                // Left Arm
                if ([[matches valueForKey:@"leftArm"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"leftArm"]];
                }
                
                // Right Arm
                if ([[matches valueForKey:@"rightArm"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"rightArm"]];
                }
                
                // Waist
                if ([[matches valueForKey:@"waist"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"waist"]];
                }
                
                // Hips
                if ([[matches valueForKey:@"hips"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"hips"]];
                }
                
                // Left Thigh
                if ([[matches valueForKey:@"leftThigh"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"leftThigh"]];
                }
                
                // Right Thigh
                if ([[matches valueForKey:@"rightThigh"] isEqualToString:@""]) {
                    [self.finalArray addObject:@"0"];
                } else {
                    [self.finalArray addObject:[matches valueForKey:@"rightThigh"]];
                }
            }
        }
        else {
            
            if ([monthArray[i] isEqualToString:@"1"]) {
                
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
                [self.month1Array addObject:@"0"];
            }
            
            if ([monthArray[i] isEqualToString:@"2"]) {
                
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
                [self.month2Array addObject:@"0"];
            }
            
            if ([monthArray[i] isEqualToString:@"3"]) {
                
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
                [self.finalArray addObject:@"0"];
            }
        }
    }
}

- (NSString*)createHTML {

    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Create an array of measurements to iterate thru when building the table rows.
    NSArray *measurementsArray = @[self.month1Array, self.month2Array, self.finalArray];
    NSArray *measurementsNameArray = @[@"Weight", @"Chest", @"Left Arm", @"Right Arm", @"Waist", @"Hips", @"Left Thigh", @"Right Thigh"];
    
    NSString *myHTML = @"<html><head>";
    
    // Table Style
    myHTML = [myHTML stringByAppendingFormat:@"<STYLE TYPE='text/css'><!--TD{font-family: Arial; font-size: 12pt;}TH{font-family: Arial; font-size: 14pt;}---></STYLE></head><body><table border='1' bordercolor='#3399FF' style='background-color:#CCCCCC' width='%f' cellpadding='2' cellspacing='1'>", (self.htmlView.frame.size.width - 15)];
    
    // Table Headers
    myHTML = [myHTML stringByAppendingFormat:@"<tr><th style='background-color:#999999'>Session %@</th><th style='background-color:#999999'>1</th><th style='background-color:#999999'>2</th><th style='background-color:#999999'>Final</th></tr>", [mainAppDelegate getCurrentSession]];
    
    // Table Data
    for (int i = 0; i < measurementsNameArray.count; i++) {
        myHTML = [myHTML stringByAppendingFormat:@"<tr><td style='background-color:#999999'>%@</td>", measurementsNameArray[i]];
        
        for (int a = 0; a < measurementsArray.count; a++) {
            myHTML = [myHTML stringByAppendingFormat:@"<td>%@</td>",
                      measurementsArray[a][i]];
        }
        
        myHTML = [myHTML stringByAppendingString:@"</tr>"];
    }
    
    // HTML closing tags
    myHTML = [myHTML stringByAppendingString:@"</table></body></html>"];
    
    return myHTML;
}

- (void)updateUI {
    
    if ([CoreDataHelper sharedHelper].iCloudStore) {
        
        [self loadMeasurements];
        [self.htmlView loadHTMLString:[self createHTML] baseURL:nil];
    }
}
@end
