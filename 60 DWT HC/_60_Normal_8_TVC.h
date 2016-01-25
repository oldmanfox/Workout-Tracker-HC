//
//  Bulk_8_TVC.h
//  90 DWT BB
//
//  Created by Grant, Jared on 2/11/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataNavController.h"
#import "UITableViewController+Design.h"
#import "UITableViewController+CheckMarkStatus.h"
//#import "MPAdView.h"

@interface _60_Normal_8_TVC : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell4;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell5;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell6;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell7;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell8;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell9;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell10;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell11;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell12;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell13;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell14;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell15;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell16;

@property (weak, nonatomic) IBOutlet UITextField *cell1Box;
@property (weak, nonatomic) IBOutlet UITextField *cell2Box;
@property (weak, nonatomic) IBOutlet UITextField *cell3Box;
@property (weak, nonatomic) IBOutlet UITextField *cell4Box;
@property (weak, nonatomic) IBOutlet UITextField *cell5Box;
@property (weak, nonatomic) IBOutlet UITextField *cell6Box;
@property (weak, nonatomic) IBOutlet UITextField *cell7Box;
@property (weak, nonatomic) IBOutlet UITextField *cell8Box;
@property (weak, nonatomic) IBOutlet UITextField *cell9Box;
@property (weak, nonatomic) IBOutlet UITextField *cell10Box;
@property (weak, nonatomic) IBOutlet UITextField *cell11Box;
@property (weak, nonatomic) IBOutlet UITextField *cell12Box;
@property (weak, nonatomic) IBOutlet UITextField *cell13Box;
@property (weak, nonatomic) IBOutlet UITextField *cell14Box;
@property (weak, nonatomic) IBOutlet UITextField *cell15Box;
@property (weak, nonatomic) IBOutlet UITextField *cell16Box;

@property (weak, nonatomic) IBOutlet UILabel *cell1Label;
@property (weak, nonatomic) IBOutlet UILabel *cell2Label;
@property (weak, nonatomic) IBOutlet UILabel *cell3Label;
@property (weak, nonatomic) IBOutlet UILabel *cell4Label;
@property (weak, nonatomic) IBOutlet UILabel *cell5Label;
@property (weak, nonatomic) IBOutlet UILabel *cell6Label;
@property (weak, nonatomic) IBOutlet UILabel *cell7Label;
@property (weak, nonatomic) IBOutlet UILabel *cell8Label;
@property (weak, nonatomic) IBOutlet UILabel *cell9Label;
@property (weak, nonatomic) IBOutlet UILabel *cell10Label;
@property (weak, nonatomic) IBOutlet UILabel *cell11Label;
@property (weak, nonatomic) IBOutlet UILabel *cell12Label;
@property (weak, nonatomic) IBOutlet UILabel *cell13Label;
@property (weak, nonatomic) IBOutlet UILabel *cell14Label;
@property (weak, nonatomic) IBOutlet UILabel *cell15Label;
@property (weak, nonatomic) IBOutlet UILabel *cell16Label;

@property (weak, nonatomic) IBOutlet UILabel *cell3Detail;
@property (weak, nonatomic) IBOutlet UILabel *cell4Detail;
@property (weak, nonatomic) IBOutlet UILabel *cell9Detail;
@property (weak, nonatomic) IBOutlet UILabel *cell10Detail;
@property (weak, nonatomic) IBOutlet UILabel *cell12Detail;
@property (weak, nonatomic) IBOutlet UILabel *cell13Detail;

@property (strong, nonatomic) NSArray *cellBoxArray;
@property (strong, nonatomic) NSArray *tableCellArray;
@property (strong, nonatomic) NSArray *accessoryIconArray;
@property (strong, nonatomic) NSArray *tableLabelArray;
@property (strong, nonatomic) NSArray *tableDetailArray;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UITableViewCell *argCell;
@property (strong, nonatomic) NSString *cellTitle;
@end
