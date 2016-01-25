//
//  Build_Shoulders_1_TVC.h
//  90 DWT BB
//
//  Created by Jared Grant on 2/27/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <iAd/iAd.h>
#import "UIViewController+Social.h"
#import "UITableViewController+Email.h"
#import "AppDelegate.h"
//#import "MPAdView.h"

@interface Max_Bulk_Strength_1_TVC : UITableViewController <UIActionSheetDelegate, UIPopoverPresentationControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) NSArray *Titles;
@property (strong, nonatomic) NSArray *Reps;
@property (strong, nonatomic) NSArray *currentTextFieldArray;
@property (strong, nonatomic) NSArray *previousTextFieldArray;
@property (strong, nonatomic) NSArray *CellArray;
@property (strong, nonatomic) NSArray *exerciseLabelArray;
@property (strong, nonatomic) NSArray *repLabelArray;

@property (strong, nonatomic) NSArray *currentNotesArray;
@property (strong, nonatomic) NSArray *previousNotesArray;
@property (strong, nonatomic) NSArray *graphButtonArray;

@property (strong, nonatomic) NSString *actionSheetType;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteDateButton;
@property (weak, nonatomic) IBOutlet UIButton *todayDateButton;
@property (weak, nonatomic) IBOutlet UIButton *previousDateButton;

//  CELLS
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_4;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_5;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_6;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_7;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_8;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_9;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_10;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_11;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_12;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_13;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_14;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_15;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_16;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_17;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_18;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_19;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_20;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_21;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_22;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_23;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_24;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_25;
@property (weak, nonatomic) IBOutlet UITableViewCell *dateCell;


//  Exercise Name Labels
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_3;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_4;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_5;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_6;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_7;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_8;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_9;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_10;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_11;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_12;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_13;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_14;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_15;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_16;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_17;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_18;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_19;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_20;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_21;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_22;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_23;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_24;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel_25;


//  PREVIOUS WEIGHT FIELDS
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_1;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_2;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_3;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_4;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_5;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_6;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_7;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_8;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_9;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_10;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_11;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_12;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_13;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_14;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_15;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_16;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_17;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_18;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_19;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_20;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_21;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_22;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_23;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_24;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_25;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_26;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_27;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_28;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_29;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_30;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_31;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_32;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_33;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_34;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_35;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_36;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_37;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_38;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_39;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_40;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_41;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_42;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_43;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_44;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_45;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_46;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_47;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_48;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_49;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_50;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_51;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_52;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_53;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_54;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_55;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_56;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_57;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_58;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_59;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_60;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_61;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_62;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_63;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_64;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_65;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_66;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_67;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_68;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_69;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_70;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_71;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_72;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_73;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_74;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_75;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_76;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_77;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_78;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_79;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_80;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_81;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_82;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_83;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_84;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_85;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_86;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_87;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_88;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_89;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_90;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_91;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_92;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_93;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_94;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_95;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_96;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_97;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_98;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_99;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_100;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_101;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_102;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_103;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_104;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_105;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_106;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_107;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_108;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_109;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_110;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_111;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_112;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_113;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_114;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_115;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_116;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_117;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_118;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_119;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_120;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_121;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_122;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_123;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_124;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_125;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_126;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_127;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_128;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_129;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_130;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_131;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_132;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_133;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_134;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_135;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_136;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_137;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_138;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_139;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_140;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_141;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_142;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_143;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_144;

@property (weak, nonatomic) IBOutlet UITextField *previousWeight_145;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_146;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_147;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_148;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_149;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight_150;


//  CURRENT WEIGHT FIELDS
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_1;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_2;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_3;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_4;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_5;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_6;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_7;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_8;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_9;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_10;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_11;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_12;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_13;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_14;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_15;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_16;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_17;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_18;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_19;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_20;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_21;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_22;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_23;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_24;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_25;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_26;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_27;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_28;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_29;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_30;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_31;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_32;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_33;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_34;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_35;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_36;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_37;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_38;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_39;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_40;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_41;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_42;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_43;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_44;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_45;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_46;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_47;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_48;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_49;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_50;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_51;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_52;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_53;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_54;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_55;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_56;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_57;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_58;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_59;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_60;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_61;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_62;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_63;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_64;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_65;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_66;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_67;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_68;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_69;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_70;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_71;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_72;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_73;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_74;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_75;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_76;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_77;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_78;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_79;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_80;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_81;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_82;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_83;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_84;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_85;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_86;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_87;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_88;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_89;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_90;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_91;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_92;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_93;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_94;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_95;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_96;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_97;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_98;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_99;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_100;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_101;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_102;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_103;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_104;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_105;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_106;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_107;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_108;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_109;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_110;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_111;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_112;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_113;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_114;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_115;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_116;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_117;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_118;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_119;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_120;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_121;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_122;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_123;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_124;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_125;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_126;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_127;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_128;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_129;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_130;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_131;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_132;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_133;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_134;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_135;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_136;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_137;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_138;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_139;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_140;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_141;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_142;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_143;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_144;

@property (weak, nonatomic) IBOutlet UITextField *currentWeight_145;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_146;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_147;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_148;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_149;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight_150;


// REP LABELS
@property (weak, nonatomic) IBOutlet UILabel *rep_1;
@property (weak, nonatomic) IBOutlet UILabel *rep_2;
@property (weak, nonatomic) IBOutlet UILabel *rep_3;
@property (weak, nonatomic) IBOutlet UILabel *rep_4;
@property (weak, nonatomic) IBOutlet UILabel *rep_5;
@property (weak, nonatomic) IBOutlet UILabel *rep_6;

@property (weak, nonatomic) IBOutlet UILabel *rep_7;
@property (weak, nonatomic) IBOutlet UILabel *rep_8;
@property (weak, nonatomic) IBOutlet UILabel *rep_9;
@property (weak, nonatomic) IBOutlet UILabel *rep_10;
@property (weak, nonatomic) IBOutlet UILabel *rep_11;
@property (weak, nonatomic) IBOutlet UILabel *rep_12;

@property (weak, nonatomic) IBOutlet UILabel *rep_13;
@property (weak, nonatomic) IBOutlet UILabel *rep_14;
@property (weak, nonatomic) IBOutlet UILabel *rep_15;
@property (weak, nonatomic) IBOutlet UILabel *rep_16;
@property (weak, nonatomic) IBOutlet UILabel *rep_17;
@property (weak, nonatomic) IBOutlet UILabel *rep_18;

@property (weak, nonatomic) IBOutlet UILabel *rep_19;
@property (weak, nonatomic) IBOutlet UILabel *rep_20;
@property (weak, nonatomic) IBOutlet UILabel *rep_21;
@property (weak, nonatomic) IBOutlet UILabel *rep_22;
@property (weak, nonatomic) IBOutlet UILabel *rep_23;
@property (weak, nonatomic) IBOutlet UILabel *rep_24;

@property (weak, nonatomic) IBOutlet UILabel *rep_25;
@property (weak, nonatomic) IBOutlet UILabel *rep_26;
@property (weak, nonatomic) IBOutlet UILabel *rep_27;
@property (weak, nonatomic) IBOutlet UILabel *rep_28;
@property (weak, nonatomic) IBOutlet UILabel *rep_29;
@property (weak, nonatomic) IBOutlet UILabel *rep_30;

@property (weak, nonatomic) IBOutlet UILabel *rep_31;
@property (weak, nonatomic) IBOutlet UILabel *rep_32;
@property (weak, nonatomic) IBOutlet UILabel *rep_33;
@property (weak, nonatomic) IBOutlet UILabel *rep_34;
@property (weak, nonatomic) IBOutlet UILabel *rep_35;
@property (weak, nonatomic) IBOutlet UILabel *rep_36;

@property (weak, nonatomic) IBOutlet UILabel *rep_37;
@property (weak, nonatomic) IBOutlet UILabel *rep_38;
@property (weak, nonatomic) IBOutlet UILabel *rep_39;
@property (weak, nonatomic) IBOutlet UILabel *rep_40;
@property (weak, nonatomic) IBOutlet UILabel *rep_41;
@property (weak, nonatomic) IBOutlet UILabel *rep_42;

@property (weak, nonatomic) IBOutlet UILabel *rep_43;
@property (weak, nonatomic) IBOutlet UILabel *rep_44;
@property (weak, nonatomic) IBOutlet UILabel *rep_45;
@property (weak, nonatomic) IBOutlet UILabel *rep_46;
@property (weak, nonatomic) IBOutlet UILabel *rep_47;
@property (weak, nonatomic) IBOutlet UILabel *rep_48;

@property (weak, nonatomic) IBOutlet UILabel *rep_49;
@property (weak, nonatomic) IBOutlet UILabel *rep_50;
@property (weak, nonatomic) IBOutlet UILabel *rep_51;
@property (weak, nonatomic) IBOutlet UILabel *rep_52;
@property (weak, nonatomic) IBOutlet UILabel *rep_53;
@property (weak, nonatomic) IBOutlet UILabel *rep_54;

@property (weak, nonatomic) IBOutlet UILabel *rep_55;
@property (weak, nonatomic) IBOutlet UILabel *rep_56;
@property (weak, nonatomic) IBOutlet UILabel *rep_57;
@property (weak, nonatomic) IBOutlet UILabel *rep_58;
@property (weak, nonatomic) IBOutlet UILabel *rep_59;
@property (weak, nonatomic) IBOutlet UILabel *rep_60;

@property (weak, nonatomic) IBOutlet UILabel *rep_61;
@property (weak, nonatomic) IBOutlet UILabel *rep_62;
@property (weak, nonatomic) IBOutlet UILabel *rep_63;
@property (weak, nonatomic) IBOutlet UILabel *rep_64;
@property (weak, nonatomic) IBOutlet UILabel *rep_65;
@property (weak, nonatomic) IBOutlet UILabel *rep_66;

@property (weak, nonatomic) IBOutlet UILabel *rep_67;
@property (weak, nonatomic) IBOutlet UILabel *rep_68;
@property (weak, nonatomic) IBOutlet UILabel *rep_69;
@property (weak, nonatomic) IBOutlet UILabel *rep_70;
@property (weak, nonatomic) IBOutlet UILabel *rep_71;
@property (weak, nonatomic) IBOutlet UILabel *rep_72;

@property (weak, nonatomic) IBOutlet UILabel *rep_73;
@property (weak, nonatomic) IBOutlet UILabel *rep_74;
@property (weak, nonatomic) IBOutlet UILabel *rep_75;
@property (weak, nonatomic) IBOutlet UILabel *rep_76;
@property (weak, nonatomic) IBOutlet UILabel *rep_77;
@property (weak, nonatomic) IBOutlet UILabel *rep_78;

@property (weak, nonatomic) IBOutlet UILabel *rep_79;
@property (weak, nonatomic) IBOutlet UILabel *rep_80;
@property (weak, nonatomic) IBOutlet UILabel *rep_81;
@property (weak, nonatomic) IBOutlet UILabel *rep_82;
@property (weak, nonatomic) IBOutlet UILabel *rep_83;
@property (weak, nonatomic) IBOutlet UILabel *rep_84;

@property (weak, nonatomic) IBOutlet UILabel *rep_85;
@property (weak, nonatomic) IBOutlet UILabel *rep_86;
@property (weak, nonatomic) IBOutlet UILabel *rep_87;
@property (weak, nonatomic) IBOutlet UILabel *rep_88;
@property (weak, nonatomic) IBOutlet UILabel *rep_89;
@property (weak, nonatomic) IBOutlet UILabel *rep_90;

@property (weak, nonatomic) IBOutlet UILabel *rep_91;
@property (weak, nonatomic) IBOutlet UILabel *rep_92;
@property (weak, nonatomic) IBOutlet UILabel *rep_93;
@property (weak, nonatomic) IBOutlet UILabel *rep_94;
@property (weak, nonatomic) IBOutlet UILabel *rep_95;
@property (weak, nonatomic) IBOutlet UILabel *rep_96;

@property (weak, nonatomic) IBOutlet UILabel *rep_97;
@property (weak, nonatomic) IBOutlet UILabel *rep_98;
@property (weak, nonatomic) IBOutlet UILabel *rep_99;
@property (weak, nonatomic) IBOutlet UILabel *rep_100;
@property (weak, nonatomic) IBOutlet UILabel *rep_101;
@property (weak, nonatomic) IBOutlet UILabel *rep_102;

@property (weak, nonatomic) IBOutlet UILabel *rep_103;
@property (weak, nonatomic) IBOutlet UILabel *rep_104;
@property (weak, nonatomic) IBOutlet UILabel *rep_105;
@property (weak, nonatomic) IBOutlet UILabel *rep_106;
@property (weak, nonatomic) IBOutlet UILabel *rep_107;
@property (weak, nonatomic) IBOutlet UILabel *rep_108;

@property (weak, nonatomic) IBOutlet UILabel *rep_109;
@property (weak, nonatomic) IBOutlet UILabel *rep_110;
@property (weak, nonatomic) IBOutlet UILabel *rep_111;
@property (weak, nonatomic) IBOutlet UILabel *rep_112;
@property (weak, nonatomic) IBOutlet UILabel *rep_113;
@property (weak, nonatomic) IBOutlet UILabel *rep_114;

@property (weak, nonatomic) IBOutlet UILabel *rep_115;
@property (weak, nonatomic) IBOutlet UILabel *rep_116;
@property (weak, nonatomic) IBOutlet UILabel *rep_117;
@property (weak, nonatomic) IBOutlet UILabel *rep_118;
@property (weak, nonatomic) IBOutlet UILabel *rep_119;
@property (weak, nonatomic) IBOutlet UILabel *rep_120;

@property (weak, nonatomic) IBOutlet UILabel *rep_121;
@property (weak, nonatomic) IBOutlet UILabel *rep_122;
@property (weak, nonatomic) IBOutlet UILabel *rep_123;
@property (weak, nonatomic) IBOutlet UILabel *rep_124;
@property (weak, nonatomic) IBOutlet UILabel *rep_125;
@property (weak, nonatomic) IBOutlet UILabel *rep_126;

@property (weak, nonatomic) IBOutlet UILabel *rep_127;
@property (weak, nonatomic) IBOutlet UILabel *rep_128;
@property (weak, nonatomic) IBOutlet UILabel *rep_129;
@property (weak, nonatomic) IBOutlet UILabel *rep_130;
@property (weak, nonatomic) IBOutlet UILabel *rep_131;
@property (weak, nonatomic) IBOutlet UILabel *rep_132;

@property (weak, nonatomic) IBOutlet UILabel *rep_133;
@property (weak, nonatomic) IBOutlet UILabel *rep_134;
@property (weak, nonatomic) IBOutlet UILabel *rep_135;
@property (weak, nonatomic) IBOutlet UILabel *rep_136;
@property (weak, nonatomic) IBOutlet UILabel *rep_137;
@property (weak, nonatomic) IBOutlet UILabel *rep_138;

@property (weak, nonatomic) IBOutlet UILabel *rep_139;
@property (weak, nonatomic) IBOutlet UILabel *rep_140;
@property (weak, nonatomic) IBOutlet UILabel *rep_141;
@property (weak, nonatomic) IBOutlet UILabel *rep_142;
@property (weak, nonatomic) IBOutlet UILabel *rep_143;
@property (weak, nonatomic) IBOutlet UILabel *rep_144;

@property (weak, nonatomic) IBOutlet UILabel *rep_145;
@property (weak, nonatomic) IBOutlet UILabel *rep_146;
@property (weak, nonatomic) IBOutlet UILabel *rep_147;
@property (weak, nonatomic) IBOutlet UILabel *rep_148;
@property (weak, nonatomic) IBOutlet UILabel *rep_149;
@property (weak, nonatomic) IBOutlet UILabel *rep_150;


// PREVIOUS NOTES
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_1;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_2;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_3;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_4;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_5;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_6;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_7;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_8;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_9;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_10;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_11;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_12;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_13;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_14;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_15;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_16;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_17;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_18;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_19;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_20;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_21;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_22;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_23;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_24;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes_25;


// CURRENT NOTES
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_1;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_2;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_3;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_4;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_5;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_6;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_7;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_8;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_9;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_10;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_11;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_12;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_13;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_14;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_15;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_16;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_17;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_18;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_19;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_20;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_21;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_22;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_23;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_24;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes_25;


// GRAPH BUTTON
@property (weak, nonatomic) IBOutlet UIButton *graphButton_1;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_2;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_3;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_4;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_5;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_6;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_7;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_8;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_9;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_10;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_11;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_12;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_13;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_14;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_15;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_16;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_17;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_18;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_19;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_20;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_21;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_22;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_23;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_24;
@property (weak, nonatomic) IBOutlet UIButton *graphButton_25;


- (IBAction)submitEntries:(id)sender;
- (IBAction)showGraph:(UIButton *)sender;
- (IBAction)workoutCompletedDelete:(UIButton *)sender;
- (IBAction)workoutCompletedToday:(UIButton *)sender;
- (IBAction)workoutCompletedPrevious:(UIButton *)sender;

@end
