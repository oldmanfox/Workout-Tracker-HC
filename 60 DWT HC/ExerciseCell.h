//
//  ExerciseCell.h
//  60 DWT HC
//
//  Created by Grant, Jared on 2/19/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel;

@property (weak, nonatomic) IBOutlet UILabel *repLabel1;
@property (weak, nonatomic) IBOutlet UILabel *repLabel2;
@property (weak, nonatomic) IBOutlet UILabel *repLabel3;
@property (weak, nonatomic) IBOutlet UILabel *repLabel4;
@property (weak, nonatomic) IBOutlet UILabel *repLabel5;
@property (weak, nonatomic) IBOutlet UILabel *repLabel6;

@property (weak, nonatomic) IBOutlet UITextField *weightField1;
@property (weak, nonatomic) IBOutlet UITextField *weightField2;
@property (weak, nonatomic) IBOutlet UITextField *weightField3;
@property (weak, nonatomic) IBOutlet UITextField *weightField4;
@property (weak, nonatomic) IBOutlet UITextField *weightField5;
@property (weak, nonatomic) IBOutlet UITextField *weightField6;

@property (weak, nonatomic) IBOutlet UITextField *previousWF1;
@property (weak, nonatomic) IBOutlet UITextField *previousWF2;
@property (weak, nonatomic) IBOutlet UITextField *previousWF3;
@property (weak, nonatomic) IBOutlet UITextField *previousWF4;
@property (weak, nonatomic) IBOutlet UITextField *previousWF5;
@property (weak, nonatomic) IBOutlet UITextField *previousWF6;

@end
