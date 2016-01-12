//
//  MeasurementsTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "MeasurementsTVC.h"

@interface MeasurementsTVC ()

@end

@implementation MeasurementsTVC

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
    
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"ruler_selected"];
    
    // Configure tableview.
    NSArray *tableCell = @[self.cell1,
                            self.cell2,
                            self.cellFinal,
                            self.cellAll];
    NSArray *accessoryIcon = @[@YES,
                                @YES,
                                @YES,
                                @YES];
    
    [self configureAccessoryIconNonWorkoutList:tableCell :accessoryIcon];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        return 1;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            ((MeasurementsNavController *)self.parentViewController).monthString = @"1";
        }
        
        if (indexPath.row == 1) {
            ((MeasurementsNavController *)self.parentViewController).monthString = @"2";
        }
        
        if (indexPath.row == 2) {
            ((MeasurementsNavController *)self.parentViewController).monthString = @"3";
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set navigation bar title
    ((MeasurementsNavController *)self.parentViewController).month = segue.identifier;
    MeasurementsViewController *mvc = (MeasurementsViewController *)segue.destinationViewController;
    MeasurementsReportViewController *mrvc = (MeasurementsReportViewController *)segue.destinationViewController;
    mvc.navigationItem.title = segue.identifier;
    mrvc.navigationItem.title = segue.identifier;    
}
@end
