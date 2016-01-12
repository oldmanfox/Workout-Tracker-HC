//
//  MeasurementsTVC.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeasurementsViewController.h"
#import "MeasurementsReportViewController.h"
#import "MeasurementsNavController.h"
#import "UITableViewController+Design.h"

@interface MeasurementsTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFinal;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellAll;

@end
