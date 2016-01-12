//
//  EmailViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/12/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "EmailViewController.h"
#import "CoreDataHelper.h"

@interface EmailViewController ()

@end

@implementation EmailViewController

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
    
    [self configureViewForIOSVersion];
    [self queryDatabase];
    
    // Respond to changes in underlying store
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"SomethingChanged"
                                               object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)hideKeyboard:(id)sender {
    [self.defaultEmail resignFirstResponder];
}

- (IBAction)saveEmail:(id)sender {
    
    NSDate *todaysDate = [NSDate date];
    
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    
    // Save defaultEmail data.
    NSEntityDescription *entityDescSession = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
    NSFetchRequest *requestSession = [[NSFetchRequest alloc] init];
    [requestSession setEntity:entityDescSession];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:requestSession error:&error];
    
    if ([objects count] != 0) {
        
        matches = objects[[objects count] - 1];
        [matches setValue:self.defaultEmail.text forKey:@"defaultEmail"];
        [matches setValue:todaysDate forKey:@"date"];
    }
    else {
        
        NSManagedObject *newDefaultEmail;
        newDefaultEmail = [NSEntityDescription insertNewObjectForEntityForName:@"Email" inManagedObjectContext:context];
        [newDefaultEmail setValue:self.defaultEmail.text forKey:@"defaultEmail"];
        [newDefaultEmail setValue:todaysDate forKey:@"date"];
    }
    
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
    
    ((SettingsNavController *)self.parentViewController).emailAddress = self.defaultEmail.text;
    
    // Clear the text field and show the placeholder text.
    self.defaultEmail.placeholder = self.defaultEmail.text;
    self.defaultEmail.text = @"";
}

- (void)configureViewForIOSVersion {
    
    // Colors
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    UIColor* blueColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
    //UIColor *green = [UIColor colorWithRed:133/255.0f green:187/255.0f blue:60/255.0f alpha:1.0f];
    
    UIColor* redColor = [UIColor colorWithRed:204/255.0f green:76/255.0f blue:45/255.0f alpha:1.0f];
    UIColor* lightRedColor = [UIColor colorWithRed:204/255.0f green:76/255.0f blue:45/255.0f alpha:0.75f];
    UIColor* testBlueColor = [UIColor colorWithRed:47/255.0f green:120/255.0f blue:145/255.0f alpha:1.0f];
    UIColor* lighttestBlueColor = [UIColor colorWithRed:47/255.0f green:120/255.0f blue:145/255.0f alpha:0.75f];
    
    // Apply Text Colors
    self.emailLabel.textColor = [UIColor blackColor];
    self.defaultEmail.textColor = redColor;
    
    // Apply Background Colors
    self.view.backgroundColor = lightGrey;
    
    // Apply Keyboard Color
    self.defaultEmail.keyboardAppearance = UIKeyboardAppearanceDark;
}

- (void)queryDatabase {
    
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch defaultEmail data.
    NSEntityDescription *entityDescSession = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
    NSFetchRequest *requestSession = [[NSFetchRequest alloc] init];
    [requestSession setEntity:entityDescSession];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:requestSession error:&error];
    
    if ([objects count] != 0) {
        
        matches = objects[[objects count] - 1];
        self.defaultEmail.text = [matches valueForKey:@"defaultEmail"];
    }
    else {
        
        self.defaultEmail.placeholder = ((SettingsNavController *)self.parentViewController).emailAddress;
    }
}

- (void)updateUI {
    
    if ([CoreDataHelper sharedHelper].iCloudStore) {
        [self queryDatabase];
    }
}
@end
