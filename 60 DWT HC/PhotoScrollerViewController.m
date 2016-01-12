//
//  PhotoScrollerViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "PhotoScrollerViewController.h"
#import "AppDelegate.h"

@interface PhotoScrollerViewController ()

@property (strong, nonatomic) NSString *actionButtonType;
@property (strong, nonatomic) NSString *whereToGetPhoto;
@property (strong, nonatomic) NSString *selectedPhotoTitle;

@property CGRect selectedImageRect;
@property NSInteger selectedPhotoIndex;

@end

@implementation PhotoScrollerViewController

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
    
    self.arrayOfImages = [[NSMutableArray alloc] init];

    [self getPhotosFromDatabase];
    
    // Respond to changes in underlying store
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"SomethingChanged"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)emailPhotos
{
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
    // Check to see if the device has at least 1 email account configured.
    if ([MFMailComposeViewController canSendMail]) {
        
        // Get the objects for the current session
        NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
        AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        // Fetch current session data.
        NSString *currentSessionString = [mainAppDelegate getCurrentSession];
        
        // Fetch defaultEmail data.
        NSEntityDescription *entityDescEmail = [NSEntityDescription entityForName:@"Email" inManagedObjectContext:context];
        NSFetchRequest *requestEmail = [[NSFetchRequest alloc] init];
        [requestEmail setEntity:entityDescEmail];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:requestEmail error:&error];
        
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
        
        NSArray *monthArray = @[@"Start Month 1", @"Start Month 2", @"Final"];
        NSArray *picAngle = @[@"Front", @"Side", @"Back", @"3/4 Turn"];
        
        for (int i = 0; i < monthArray.count; i++) {
            
            if ([self.navigationItem.title isEqualToString:monthArray[i]]) {
                
                // Prepare string for the Subject of the email
                NSString *subjectTitle = @"";
                subjectTitle = [subjectTitle stringByAppendingFormat:@"60 DWT HC %@ Photos - Session %@", monthArray[i], currentSessionString];
                
                [mailComposer setSubject:subjectTitle];
                //NSLog(@"%@", subjectTitle);
                
                for (int b = 0; b < picAngle.count; b++) {
                    
                    if (self.arrayOfImages[b] != [UIImage imageNamed:@"PhotoPlaceHolder.png"]) {
                        
                        // Don't attach photos that just use the placeholder image.
                        
                        NSData *imageData = UIImageJPEGRepresentation(self.arrayOfImages[b], 1.0); //convert image into .JPG format.
                        NSString *photoAttachmentFileName = @"";
                        
                        photoAttachmentFileName = [photoAttachmentFileName stringByAppendingFormat:@"%@ %@ - Session %@.jpg", monthArray[i], picAngle[b], currentSessionString];
                        
                        //NSLog(@"Image = %@", self.arrayOfImages[b]);
                        //NSLog(@"File name = %@", photoAttachmentFileName);
                        
                        [mailComposer addAttachmentData:imageData mimeType:@"image/jpg" fileName:photoAttachmentFileName];
                    }
                }
            }
        }
        
        [self presentViewController:mailComposer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configureViewForIOSVersion {
    
    // Colors
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    //UIColor *midGrey = [UIColor colorWithRed:219/255.0f green:218/255.0f blue:218/255.0f alpha:1.0f];
    //UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    //UIColor* blueColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
    
    // Apply Text Colors
    
    // Apply Background Colors
    
    //self.view.backgroundColor = [UIColor blackColor];
    self.collectionView.backgroundColor = lightGrey;
    
    // Apply Keyboard Color
}

- (IBAction)shareActionSheet:(UIBarButtonItem *)sender {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Facebook", @"Twitter", nil];
    
    self.actionButtonType = @"Share";
    [action showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([self.actionButtonType isEqualToString:@"Share"]) {
        
        if (buttonIndex == 0) {
            [self emailPhotos];
        }
        
        if (buttonIndex == 1) {
            [self facebook];
        }
        
        if (buttonIndex == 2) {
            [self twitter];
        }
    }
    
    else
    {
        // Photo
        
        if (buttonIndex == 0) {
            
            self.whereToGetPhoto = @"Camera";
        }
        
        if (buttonIndex == 1) {
            
            self.whereToGetPhoto = @"Photo Library";
        }
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (![self.actionButtonType isEqualToString:@"Share"]) {
        [self cameraOrPhotoLibrary];
    }
}

#pragma mark - UICollectionView Datasource

// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //NSString *searchTerm = self.searches[section];
    
    return [self.arrayOfImages count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView {
    
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UIColor* blueColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
    
    photoCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    cell.myImage.image = [self.arrayOfImages objectAtIndex:indexPath.item];
    
    NSArray *photoAngle = @[@"Front",
                            @"Side",
                            @"Back",
                            @"3/4 Turn"];
    
    cell.myLabel.text = photoAngle[indexPath.item];
    cell.myLabel.backgroundColor = [UIColor blackColor];
    //cell.myLabel.textColor = blueColor;
    cell.myLabel.textColor = [UIColor whiteColor];
    cell.myLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)getPhotosFromDatabase {
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get photo data with the current session
    NSArray *photoAngle = @[@"Front",
                            @"Side",
                            @"Back",
                            @"3/4 Turn"];
    
    for (int i = 0; i < photoAngle.count; i++) {
        
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (month = %@) AND (angle = %@)",
                             currentSessionString,
                             ((PhotoNavController *)self.parentViewController).photoMonthSelected,
                             photoAngle[i]];
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            UIImage *image = [UIImage imageWithData:[matches valueForKey:@"image"]];
            
            // Add image to array.
            [self.arrayOfImages addObject:image];
            
        } else {
            
            // Load a placeholder image.
            [self.arrayOfImages addObject:[UIImage imageNamed:@"PhotoPlaceHolder.png"]];
        }
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Select Item
    
    UIActionSheet *photoAction = [[UIActionSheet alloc] initWithTitle:@"Set Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    
    self.actionButtonType = @"Photo";
    
    NSArray *photoAngle = @[@" Front",
                            @" Side",
                            @" Back",
                            @" 3/4 Turn"];
    
    // Check to see what device you are using iPad or iPhone.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // Get the position of the image so the popover arrow can point to it.
        static NSString *CellIdentifier = @"Cell";
        photoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        self.selectedImageRect = [collectionView convertRect:cell.frame toView:self.view];
    }
    
    self.selectedPhotoTitle = [self.navigationItem.title stringByAppendingString:photoAngle[indexPath.item]];
    self.selectedPhotoIndex = indexPath.item;
    
    self.whereToGetPhoto = @"";
    [photoAction showFromRect:self.selectedImageRect inView:self.view animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    // Size cell for iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return CGSizeMake(152.f, 204.f);
    }
    
    // Size cell for iPad
    else {
        
        return CGSizeMake(304.f, 408.f);
    }
}


- (void)cameraOrPhotoLibrary {
    UIImagePickerController *imagePicker;
    imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    
    if ([self.whereToGetPhoto isEqualToString:@"Camera"]) {
        
        // Use Camera
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            // Camera is available.  Use Camera
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        else {
            
            // No camera detected.  Use Photo Library
            UIAlertView *alert;
            
            alert = [[UIAlertView alloc] initWithTitle:@"Camera Not Found"
                                               message:@"No camera was detected.  Using photo library instead."
                                              delegate:self
                                     cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil, nil];
            
            [alert show];
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
    }
    
    else if ([self.whereToGetPhoto isEqualToString:@"Photo Library"]) {
        
        // Use Photo Library
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    else {
        
        // User Canceled the action sheet.
        return;
    }
    
    // Check to see what device you are using iPad or iPhone.
    
    // If your device is iPad then show the imagePicker in a popover.
    // If not iPad then show the imagePicker modally.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && ![self.whereToGetPhoto isEqualToString:@""]) {
        
        self.myPopoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.myPopoverController.delegate = self;
        [self.myPopoverController presentPopoverFromRect:self.selectedImageRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //[[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.arrayOfImages replaceObjectAtIndex:self.selectedPhotoIndex withObject:image];
    
    NSString *selectedAngle;
    
    if (self.selectedPhotoIndex == 0) {
        selectedAngle = @"Front";
    }
    
    if (self.selectedPhotoIndex == 1) {
        selectedAngle = @"Side";
    }
    
    if (self.selectedPhotoIndex == 2) {
        selectedAngle = @"Back";
    }
    
    if (self.selectedPhotoIndex == 3) {
        selectedAngle = @"3/4 Turn";
    }
    
    NSDate *todaysDate = [NSDate date];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Fetch current session data.
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Save the image data with the current session
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (month = %@) AND (angle = %@)",
                         currentSessionString,
                         ((PhotoNavController *)self.parentViewController).photoMonthSelected,
                         selectedAngle];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //NSLog(@"submitEntry = No matches - create new record and save");
        
        NSManagedObject *newExercise;
        newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        [newExercise setValue:currentSessionString forKey:@"session"];
        [newExercise setValue:((PhotoNavController *)self.parentViewController).photoMonthSelected forKey:@"month"];
        [newExercise setValue:selectedAngle forKey:@"angle"];
        [newExercise setValue:todaysDate forKey:@"date"];
        [newExercise setValue:imageData forKey:@"image"];
        
    } else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        matches = objects[[objects count]-1];
        
        // Only update the fields that have been changed.
        [matches setValue:imageData forKey:@"image"];
        [matches setValue:todaysDate forKey:@"date"];
    }
    
    //[context save:&error];
    [[CoreDataHelper sharedHelper] backgroundSaveContext];
    
    [self.collectionView reloadData];
    
    picker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    /*
     UIAlertView *alert;
     
     // Unable to save the image
     if (error) {
     alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Unable to save image to Photo Library."
     delegate:self
     cancelButtonTitle:@"Ok"
     otherButtonTitles:nil, nil];
     } else { // All is well
     alert = [[UIAlertView alloc] initWithTitle:@"Success"
     message:@"Image saved to Photo Library."
     delegate:self
     cancelButtonTitle:@"Ok"
     otherButtonTitles:nil, nil];
     }
     
     [alert show];
     */
}

- (void)updateUI {
    
    if ([CoreDataHelper sharedHelper].iCloudStore) {
        [self.arrayOfImages removeAllObjects];
        [self getPhotosFromDatabase];
        [self.collectionView reloadData];
    }
}
@end
