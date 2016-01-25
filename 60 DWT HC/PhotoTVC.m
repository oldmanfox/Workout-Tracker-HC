//
//  PhotoTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "PhotoTVC.h"
#import "AppDelegate.h"
#import "CoreDataHelper.h"

@interface PhotoTVC ()

@end

@implementation PhotoTVC

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
    
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"pic_mountains_selected"];
    
    // Configure tableview.
    NSArray *tableCell = @[self.cell1,
                            self.cell2,
                            self.cellFinal,
                            self.cellAll,
                            self.cellFront,
                            self.cellSide,
                            self.cellBack,
                            self.cell3_4Turn];
    
    NSArray *accessoryIcon = @[@YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES];

    [self configureAccessoryIconNonWorkoutList:tableCell :accessoryIcon];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    }
    else {
        return 5;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            ((PhotoNavController *)self.parentViewController).photoMonthSelected = @"1";
        }
        
        if (indexPath.row == 1) {
            ((PhotoNavController *)self.parentViewController).photoMonthSelected = @"2";
        }
        
        if (indexPath.row == 2) {
            ((PhotoNavController *)self.parentViewController).photoMonthSelected = @"3";
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set navigation bar title
    ((PhotoNavController *)self.parentViewController).month = segue.identifier;
    PhotoScrollerViewController *psvc = (PhotoScrollerViewController *)segue.destinationViewController;
    PresentPhotosViewController *ppvc = (PresentPhotosViewController *)segue.destinationViewController;
    psvc.navigationItem.title = segue.identifier;
    ppvc.navigationItem.title = segue.identifier;
    
    // View Photos
    NSMutableArray *photosFromDatabase = [[NSMutableArray alloc] init];
    NSArray *photoAngle = [[NSMutableArray alloc] init];
    NSArray *photoMonth = [[NSMutableArray alloc] init];
    NSArray *photoTitles = [[NSArray alloc] init];
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *currentSessionString = [mainAppDelegate getCurrentSession];
    
    // Get the objects for the current session
    NSManagedObjectContext *context = [[CoreDataHelper sharedHelper] context];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];

    // ALL
    if ([segue.identifier isEqualToString:@"All"]) {
        
        photoAngle = @[@"Front",
                       @"Side",
                       @"Back",
                       @"3/4 Turn",
                       @"Front",
                       @"Side",
                       @"Back",
                       @"3/4 Turn",
                       @"Front",
                       @"Side",
                       @"Back",
                       @"3/4 Turn"];
        
        photoMonth = @[@"1",
                       @"1",
                       @"1",
                       @"1",
                       @"2",
                       @"2",
                       @"2",
                       @"2",
                       @"3",
                       @"3",
                       @"3",
                       @"3"];
        
        photoTitles = @[@"Start Month 1 Front",
                        @"Start Month 1 Side",
                        @"Start Month 1 Back",
                        @"Start Month 1 3/4 Turn",
                        @"Start Month 2 Front",
                        @"Start Month 2 Side",
                        @"Start Month 2 Back",
                        @"Start Month 2 3/4 Turn",
                        @"Final Front",
                        @"Final Side",
                        @"Final Back",
                        @"Final 3/4 Turn"];
    }
    
    // FRONT
    else if ([segue.identifier isEqualToString:@"Front"]) {
        
        photoAngle = @[@"Front",
                       @"Front",
                       @"Front"];
        
        photoMonth = @[@"1",
                       @"2",
                       @"3"];
        
        photoTitles = @[@"Start Month 1 Front",
                        @"Start Month 2 Front",
                        @"Final Front"];
    }
    
    // SIDE
    else if ([segue.identifier isEqualToString:@"Side"]) {
        
        photoAngle = @[@"Side",
                       @"Side",
                       @"Side"];
        
        photoMonth = @[@"1",
                       @"2",
                       @"3"];
        
        photoTitles = @[@"Start Month 1 Side",
                        @"Start Month 2 Side",
                        @"Final Side"];
    }
    
    // BACK
    else if ([segue.identifier isEqualToString:@"Back"]) {
        
        photoAngle = @[@"Back",
                       @"Back",
                       @"Back"];
        
        photoMonth = @[@"1",
                       @"2",
                       @"3"];
        
        photoTitles = @[@"Start Month 1 Back",
                        @"Start Month 2 Back",
                        @"Final Back"];
    }
    
    // 3/4 Turn
    else if ([segue.identifier isEqualToString:@"3/4 Turn"]) {
        
        photoAngle = @[@"3/4 Turn",
                       @"3/4 Turn",
                       @"3/4 Turn"];
        
        photoMonth = @[@"1",
                       @"2",
                       @"3"];
        
        photoTitles = @[@"Start Month 1 3/4 Turn",
                        @"Start Month 2 3/4 Turn",
                        @"Final 3/4 Turn"];
    }
    
    for (int i = 0; i < photoAngle.count; i++) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (month = %@) AND (angle = %@)",
                             currentSessionString,
                             photoMonth[i],
                             photoAngle[i]];
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error = nil;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects count] != 0) {
            
            matches = objects[[objects count] - 1];
            UIImage *image = [UIImage imageWithData:[matches valueForKey:@"image"]];
            
            // Add image to array.
            [photosFromDatabase addObject:image];
        }
        else {
            
            // Add a placeholder image.
            [photosFromDatabase addObject:[UIImage imageNamed:@"PhotoPlaceHolder.png"]];
        }
    }
    
    if (photosFromDatabase.count != 0) {
        
        ppvc.arrayOfImages = photosFromDatabase;
        ppvc.arrayOfImageTitles = photoTitles;
    }
}
@end
