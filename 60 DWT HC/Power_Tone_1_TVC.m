//
//  Build_Shoulders_1_TVC.m
//  90 DWT BB
//
//  Created by Jared Grant on 2/27/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "Power_Tone_1_TVC.h"
#import "UITableViewController+Database.h"
#import "UITableViewController+Design.h"
#import "DataNavController.h"
#import "60DWTHCIAPHelper.h"
#import "DatePickerViewController.h"
#import <iAd/iAd.h>

@interface Power_Tone_1_TVC ()

@end

@implementation Power_Tone_1_TVC

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
    
    [self loadArrays];
    
    [self saveDataNavControllerToAppDelegate];
    
    [self configureDateCell:self.dateCell :self.deleteDateButton :self.todayDateButton :self.previousDateButton :self.dateLabel];
    
    [self addAccessoryToolBar];
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iPhone
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"0c100c8b79754d7588f0e550a800e9ba"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"fa2d861291b34c5aaaaf93d0849c4818"
                                                        size:MOPUB_LEADERBOARD_SIZE];
            self.bannerSize = MOPUB_LEADERBOARD_SIZE;
            
        }
        
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        
        [self.headerView addSubview:self.adView];
        
        [self.adView loadAd];
    }
    
    self.navigationItem.title = ((DataNavController *)self.parentViewController).workout;
    
    //  Configure the cell...
    [self configureExerciseCell:self.CellArray :self.Reps :self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.exerciseLabelArray :self.repLabelArray :self.previousNotesArray :self.currentNotesArray :self.graphButtonArray];
    
    //  Get data from the database
    [self exerciseMatches:self.Titles :self.previousTextFieldArray :self.currentTextFieldArray :self.previousNotesArray :self.currentNotesArray];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.hidden = YES;
    }
}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [self updateWorkoutCompleteCell];
    
    // Show or Hide Ads
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:@"com.grantdevelopers.60DWTHC.removeads"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    //} else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        self.adView.hidden = NO;
    }
}

- (void)loadArrays {
    
    self.Titles = @[@"Ball Squat Jumps",
                    @"Squat - Heavy",
                    @"Upright Row",
                    @"Pull-Up",
                    @"Hanging Knee Curl",
                    @"Ball Plyo Lunge - R",
                    @"Lunge - R - Heavy",
                    @"Ball Plyo Lunge - L",
                    @"Lunge - L - Heavy",
                    @"Plyo Push-Up",
                    @"Chest Press - Heavy",
                    @"Half Spiderman",
                    @"Ball Sumo Plyo",
                    @"Sumo Squat - Heavy",
                    @"Ball Push Press",
                    @"Military Press - Heavy",
                    @"Ball Seated Toe Tap",
                    @"Ball Knee Drivers - L",
                    @"Side Step-Up - L - Heavy",
                    @"Ball Knee Drivers - R",
                    @"Side Step-Up - R - Heavy",
                    @"Bicep Curls",
                    @"Bicep Curls - Heavy",
                    @"Tricep Kickbacks",
                    @"Tricep Kickbacks - Heavy"];
    
    self.Reps = @[@"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 2
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 3
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 4
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 5
                  @"16",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 6
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 7
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 8
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 9
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 10
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 11
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 12
                  @"16",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 13
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 14
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 15
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 16
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 17
                  @"16",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 18
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 19
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 20
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 21
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 22
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 23
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @"",
                  //  Cell 24
                  @"4",
                  @"4",
                  @"4",
                  @"4",
                  @"",
                  @"",
                  //  Cell 25
                  @"10",
                  @"",
                  @"",
                  @"",
                  @"",
                  @""];
    
    self.CellArray = @[self.cell_1,
                       self.cell_2,
                       self.cell_3,
                       self.cell_4,
                       self.cell_5,
                       self.cell_6,
                       self.cell_7,
                       self.cell_8,
                       self.cell_9,
                       self.cell_10,
                       self.cell_11,
                       self.cell_12,
                       self.cell_13,
                       self.cell_14,
                       self.cell_15,
                       self.cell_16,
                       self.cell_17,
                       self.cell_18,
                       self.cell_19,
                       self.cell_20,
                       self.cell_21,
                       self.cell_22,
                       self.cell_23,
                       self.cell_24,
                       self.cell_25];
    
    self.exerciseLabelArray = @[self.exerciseLabel_1,
                                self.exerciseLabel_2,
                                self.exerciseLabel_3,
                                self.exerciseLabel_4,
                                self.exerciseLabel_5,
                                self.exerciseLabel_6,
                                self.exerciseLabel_7,
                                self.exerciseLabel_8,
                                self.exerciseLabel_9,
                                self.exerciseLabel_10,
                                self.exerciseLabel_11,
                                self.exerciseLabel_12,
                                self.exerciseLabel_13,
                                self.exerciseLabel_14,
                                self.exerciseLabel_15,
                                self.exerciseLabel_16,
                                self.exerciseLabel_17,
                                self.exerciseLabel_18,
                                self.exerciseLabel_19,
                                self.exerciseLabel_20,
                                self.exerciseLabel_21,
                                self.exerciseLabel_22,
                                self.exerciseLabel_23,
                                self.exerciseLabel_24,
                                self.exerciseLabel_25];
    
    self.repLabelArray = @[self.rep_1,
                           self.rep_2,
                           self.rep_3,
                           self.rep_4,
                           self.rep_5,
                           self.rep_6,
                           self.rep_7,
                           self.rep_8,
                           self.rep_9,
                           self.rep_10,
                           self.rep_11,
                           self.rep_12,
                           self.rep_13,
                           self.rep_14,
                           self.rep_15,
                           self.rep_16,
                           self.rep_17,
                           self.rep_18,
                           self.rep_19,
                           self.rep_20,
                           self.rep_21,
                           self.rep_22,
                           self.rep_23,
                           self.rep_24,
                           self.rep_25,
                           self.rep_26,
                           self.rep_27,
                           self.rep_28,
                           self.rep_29,
                           self.rep_30,
                           self.rep_31,
                           self.rep_32,
                           self.rep_33,
                           self.rep_34,
                           self.rep_35,
                           self.rep_36,
                           self.rep_37,
                           self.rep_38,
                           self.rep_39,
                           self.rep_40,
                           self.rep_41,
                           self.rep_42,
                           self.rep_43,
                           self.rep_44,
                           self.rep_45,
                           self.rep_46,
                           self.rep_47,
                           self.rep_48,
                           self.rep_49,
                           self.rep_50,
                           self.rep_51,
                           self.rep_52,
                           self.rep_53,
                           self.rep_54,
                           self.rep_55,
                           self.rep_56,
                           self.rep_57,
                           self.rep_58,
                           self.rep_59,
                           self.rep_60,
                           self.rep_61,
                           self.rep_62,
                           self.rep_63,
                           self.rep_64,
                           self.rep_65,
                           self.rep_66,
                           self.rep_67,
                           self.rep_68,
                           self.rep_69,
                           self.rep_70,
                           self.rep_71,
                           self.rep_72,
                           self.rep_73,
                           self.rep_74,
                           self.rep_75,
                           self.rep_76,
                           self.rep_77,
                           self.rep_78,
                           self.rep_79,
                           self.rep_80,
                           self.rep_81,
                           self.rep_82,
                           self.rep_83,
                           self.rep_84,
                           self.rep_85,
                           self.rep_86,
                           self.rep_87,
                           self.rep_88,
                           self.rep_89,
                           self.rep_90,
                           self.rep_91,
                           self.rep_92,
                           self.rep_93,
                           self.rep_94,
                           self.rep_95,
                           self.rep_96,
                           self.rep_97,
                           self.rep_98,
                           self.rep_99,
                           self.rep_100,
                           self.rep_101,
                           self.rep_102,
                           self.rep_103,
                           self.rep_104,
                           self.rep_105,
                           self.rep_106,
                           self.rep_107,
                           self.rep_108,
                           self.rep_109,
                           self.rep_110,
                           self.rep_111,
                           self.rep_112,
                           self.rep_113,
                           self.rep_114,
                           self.rep_115,
                           self.rep_116,
                           self.rep_117,
                           self.rep_118,
                           self.rep_119,
                           self.rep_120,
                           self.rep_121,
                           self.rep_122,
                           self.rep_123,
                           self.rep_124,
                           self.rep_125,
                           self.rep_126,
                           self.rep_127,
                           self.rep_128,
                           self.rep_129,
                           self.rep_130,
                           self.rep_131,
                           self.rep_132,
                           self.rep_133,
                           self.rep_134,
                           self.rep_135,
                           self.rep_136,
                           self.rep_137,
                           self.rep_138,
                           self.rep_139,
                           self.rep_140,
                           self.rep_141,
                           self.rep_142,
                           self.rep_143,
                           self.rep_144,
                           self.rep_145,
                           self.rep_146,
                           self.rep_147,
                           self.rep_148,
                           self.rep_149,
                           self.rep_150];
    
    self.currentTextFieldArray = @[self.currentWeight_1,
                                   self.currentWeight_2,
                                   self.currentWeight_3,
                                   self.currentWeight_4,
                                   self.currentWeight_5,
                                   self.currentWeight_6,
                                   self.currentWeight_7,
                                   self.currentWeight_8,
                                   self.currentWeight_9,
                                   self.currentWeight_10,
                                   self.currentWeight_11,
                                   self.currentWeight_12,
                                   self.currentWeight_13,
                                   self.currentWeight_14,
                                   self.currentWeight_15,
                                   self.currentWeight_16,
                                   self.currentWeight_17,
                                   self.currentWeight_18,
                                   self.currentWeight_19,
                                   self.currentWeight_20,
                                   self.currentWeight_21,
                                   self.currentWeight_22,
                                   self.currentWeight_23,
                                   self.currentWeight_24,
                                   self.currentWeight_25,
                                   self.currentWeight_26,
                                   self.currentWeight_27,
                                   self.currentWeight_28,
                                   self.currentWeight_29,
                                   self.currentWeight_30,
                                   self.currentWeight_31,
                                   self.currentWeight_32,
                                   self.currentWeight_33,
                                   self.currentWeight_34,
                                   self.currentWeight_35,
                                   self.currentWeight_36,
                                   self.currentWeight_37,
                                   self.currentWeight_38,
                                   self.currentWeight_39,
                                   self.currentWeight_40,
                                   self.currentWeight_41,
                                   self.currentWeight_42,
                                   self.currentWeight_43,
                                   self.currentWeight_44,
                                   self.currentWeight_45,
                                   self.currentWeight_46,
                                   self.currentWeight_47,
                                   self.currentWeight_48,
                                   self.currentWeight_49,
                                   self.currentWeight_50,
                                   self.currentWeight_51,
                                   self.currentWeight_52,
                                   self.currentWeight_53,
                                   self.currentWeight_54,
                                   self.currentWeight_55,
                                   self.currentWeight_56,
                                   self.currentWeight_57,
                                   self.currentWeight_58,
                                   self.currentWeight_59,
                                   self.currentWeight_60,
                                   self.currentWeight_61,
                                   self.currentWeight_62,
                                   self.currentWeight_63,
                                   self.currentWeight_64,
                                   self.currentWeight_65,
                                   self.currentWeight_66,
                                   self.currentWeight_67,
                                   self.currentWeight_68,
                                   self.currentWeight_69,
                                   self.currentWeight_70,
                                   self.currentWeight_71,
                                   self.currentWeight_72,
                                   self.currentWeight_73,
                                   self.currentWeight_74,
                                   self.currentWeight_75,
                                   self.currentWeight_76,
                                   self.currentWeight_77,
                                   self.currentWeight_78,
                                   self.currentWeight_79,
                                   self.currentWeight_80,
                                   self.currentWeight_81,
                                   self.currentWeight_82,
                                   self.currentWeight_83,
                                   self.currentWeight_84,
                                   self.currentWeight_85,
                                   self.currentWeight_86,
                                   self.currentWeight_87,
                                   self.currentWeight_88,
                                   self.currentWeight_89,
                                   self.currentWeight_90,
                                   self.currentWeight_91,
                                   self.currentWeight_92,
                                   self.currentWeight_93,
                                   self.currentWeight_94,
                                   self.currentWeight_95,
                                   self.currentWeight_96,
                                   self.currentWeight_97,
                                   self.currentWeight_98,
                                   self.currentWeight_99,
                                   self.currentWeight_100,
                                   self.currentWeight_101,
                                   self.currentWeight_102,
                                   self.currentWeight_103,
                                   self.currentWeight_104,
                                   self.currentWeight_105,
                                   self.currentWeight_106,
                                   self.currentWeight_107,
                                   self.currentWeight_108,
                                   self.currentWeight_109,
                                   self.currentWeight_110,
                                   self.currentWeight_111,
                                   self.currentWeight_112,
                                   self.currentWeight_113,
                                   self.currentWeight_114,
                                   self.currentWeight_115,
                                   self.currentWeight_116,
                                   self.currentWeight_117,
                                   self.currentWeight_118,
                                   self.currentWeight_119,
                                   self.currentWeight_120,
                                   self.currentWeight_121,
                                   self.currentWeight_122,
                                   self.currentWeight_123,
                                   self.currentWeight_124,
                                   self.currentWeight_125,
                                   self.currentWeight_126,
                                   self.currentWeight_127,
                                   self.currentWeight_128,
                                   self.currentWeight_129,
                                   self.currentWeight_130,
                                   self.currentWeight_131,
                                   self.currentWeight_132,
                                   self.currentWeight_133,
                                   self.currentWeight_134,
                                   self.currentWeight_135,
                                   self.currentWeight_136,
                                   self.currentWeight_137,
                                   self.currentWeight_138,
                                   self.currentWeight_139,
                                   self.currentWeight_140,
                                   self.currentWeight_141,
                                   self.currentWeight_142,
                                   self.currentWeight_143,
                                   self.currentWeight_144,
                                   self.currentWeight_145,
                                   self.currentWeight_146,
                                   self.currentWeight_147,
                                   self.currentWeight_148,
                                   self.currentWeight_149,
                                   self.currentWeight_150];
    
    self.previousTextFieldArray = @[self.previousWeight_1,
                                    self.previousWeight_2,
                                    self.previousWeight_3,
                                    self.previousWeight_4,
                                    self.previousWeight_5,
                                    self.previousWeight_6,
                                    self.previousWeight_7,
                                    self.previousWeight_8,
                                    self.previousWeight_9,
                                    self.previousWeight_10,
                                    self.previousWeight_11,
                                    self.previousWeight_12,
                                    self.previousWeight_13,
                                    self.previousWeight_14,
                                    self.previousWeight_15,
                                    self.previousWeight_16,
                                    self.previousWeight_17,
                                    self.previousWeight_18,
                                    self.previousWeight_19,
                                    self.previousWeight_20,
                                    self.previousWeight_21,
                                    self.previousWeight_22,
                                    self.previousWeight_23,
                                    self.previousWeight_24,
                                    self.previousWeight_25,
                                    self.previousWeight_26,
                                    self.previousWeight_27,
                                    self.previousWeight_28,
                                    self.previousWeight_29,
                                    self.previousWeight_30,
                                    self.previousWeight_31,
                                    self.previousWeight_32,
                                    self.previousWeight_33,
                                    self.previousWeight_34,
                                    self.previousWeight_35,
                                    self.previousWeight_36,
                                    self.previousWeight_37,
                                    self.previousWeight_38,
                                    self.previousWeight_39,
                                    self.previousWeight_40,
                                    self.previousWeight_41,
                                    self.previousWeight_42,
                                    self.previousWeight_43,
                                    self.previousWeight_44,
                                    self.previousWeight_45,
                                    self.previousWeight_46,
                                    self.previousWeight_47,
                                    self.previousWeight_48,
                                    self.previousWeight_49,
                                    self.previousWeight_50,
                                    self.previousWeight_51,
                                    self.previousWeight_52,
                                    self.previousWeight_53,
                                    self.previousWeight_54,
                                    self.previousWeight_55,
                                    self.previousWeight_56,
                                    self.previousWeight_57,
                                    self.previousWeight_58,
                                    self.previousWeight_59,
                                    self.previousWeight_60,
                                    self.previousWeight_61,
                                    self.previousWeight_62,
                                    self.previousWeight_63,
                                    self.previousWeight_64,
                                    self.previousWeight_65,
                                    self.previousWeight_66,
                                    self.previousWeight_67,
                                    self.previousWeight_68,
                                    self.previousWeight_69,
                                    self.previousWeight_70,
                                    self.previousWeight_71,
                                    self.previousWeight_72,
                                    self.previousWeight_73,
                                    self.previousWeight_74,
                                    self.previousWeight_75,
                                    self.previousWeight_76,
                                    self.previousWeight_77,
                                    self.previousWeight_78,
                                    self.previousWeight_79,
                                    self.previousWeight_80,
                                    self.previousWeight_81,
                                    self.previousWeight_82,
                                    self.previousWeight_83,
                                    self.previousWeight_84,
                                    self.previousWeight_85,
                                    self.previousWeight_86,
                                    self.previousWeight_87,
                                    self.previousWeight_88,
                                    self.previousWeight_89,
                                    self.previousWeight_90,
                                    self.previousWeight_91,
                                    self.previousWeight_92,
                                    self.previousWeight_93,
                                    self.previousWeight_94,
                                    self.previousWeight_95,
                                    self.previousWeight_96,
                                    self.previousWeight_97,
                                    self.previousWeight_98,
                                    self.previousWeight_99,
                                    self.previousWeight_100,
                                    self.previousWeight_101,
                                    self.previousWeight_102,
                                    self.previousWeight_103,
                                    self.previousWeight_104,
                                    self.previousWeight_105,
                                    self.previousWeight_106,
                                    self.previousWeight_107,
                                    self.previousWeight_108,
                                    self.previousWeight_109,
                                    self.previousWeight_110,
                                    self.previousWeight_111,
                                    self.previousWeight_112,
                                    self.previousWeight_113,
                                    self.previousWeight_114,
                                    self.previousWeight_115,
                                    self.previousWeight_116,
                                    self.previousWeight_117,
                                    self.previousWeight_118,
                                    self.previousWeight_119,
                                    self.previousWeight_120,
                                    self.previousWeight_121,
                                    self.previousWeight_122,
                                    self.previousWeight_123,
                                    self.previousWeight_124,
                                    self.previousWeight_125,
                                    self.previousWeight_126,
                                    self.previousWeight_127,
                                    self.previousWeight_128,
                                    self.previousWeight_129,
                                    self.previousWeight_130,
                                    self.previousWeight_131,
                                    self.previousWeight_132,
                                    self.previousWeight_133,
                                    self.previousWeight_134,
                                    self.previousWeight_135,
                                    self.previousWeight_136,
                                    self.previousWeight_137,
                                    self.previousWeight_138,
                                    self.previousWeight_139,
                                    self.previousWeight_140,
                                    self.previousWeight_141,
                                    self.previousWeight_142,
                                    self.previousWeight_143,
                                    self.previousWeight_144,
                                    self.previousWeight_145,
                                    self.previousWeight_146,
                                    self.previousWeight_147,
                                    self.previousWeight_148,
                                    self.previousWeight_149,
                                    self.previousWeight_150];
    
    self.currentNotesArray = @[self.currentNotes_1,
                               self.currentNotes_2,
                               self.currentNotes_3,
                               self.currentNotes_4,
                               self.currentNotes_5,
                               self.currentNotes_6,
                               self.currentNotes_7,
                               self.currentNotes_8,
                               self.currentNotes_9,
                               self.currentNotes_10,
                               self.currentNotes_11,
                               self.currentNotes_12,
                               self.currentNotes_13,
                               self.currentNotes_14,
                               self.currentNotes_15,
                               self.currentNotes_16,
                               self.currentNotes_17,
                               self.currentNotes_18,
                               self.currentNotes_19,
                               self.currentNotes_20,
                               self.currentNotes_21,
                               self.currentNotes_22,
                               self.currentNotes_23,
                               self.currentNotes_24,
                               self.currentNotes_25];
    
    self.previousNotesArray = @[self.previousNotes_1,
                                self.previousNotes_2,
                                self.previousNotes_3,
                                self.previousNotes_4,
                                self.previousNotes_5,
                                self.previousNotes_6,
                                self.previousNotes_7,
                                self.previousNotes_8,
                                self.previousNotes_9,
                                self.previousNotes_10,
                                self.previousNotes_11,
                                self.previousNotes_12,
                                self.previousNotes_13,
                                self.previousNotes_14,
                                self.previousNotes_15,
                                self.previousNotes_16,
                                self.previousNotes_17,
                                self.previousNotes_18,
                                self.previousNotes_19,
                                self.previousNotes_20,
                                self.previousNotes_21,
                                self.previousNotes_22,
                                self.previousNotes_23,
                                self.previousNotes_24,
                                self.previousNotes_25];
    
    self.graphButtonArray = @[self.graphButton_1,
                              self.graphButton_2,
                              self.graphButton_3,
                              self.graphButton_4,
                              self.graphButton_5,
                              self.graphButton_6,
                              self.graphButton_7,
                              self.graphButton_8,
                              self.graphButton_9,
                              self.graphButton_10,
                              self.graphButton_11,
                              self.graphButton_12,
                              self.graphButton_13,
                              self.graphButton_14,
                              self.graphButton_15,
                              self.graphButton_16,
                              self.graphButton_17,
                              self.graphButton_18,
                              self.graphButton_19,
                              self.graphButton_20,
                              self.graphButton_21,
                              self.graphButton_22,
                              self.graphButton_23,
                              self.graphButton_24,
                              self.graphButton_25];

}

- (void)addAccessoryToolBar
{
    // Create the toolbar to go above the keyboard.
    UIToolbar *accessoryToolBar = [[UIToolbar alloc] init];
    accessoryToolBar.barTintColor = [UIColor darkGrayColor];
    
    // Create buttons for the toolbar.
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)];
    
    UIBarButtonItem *flexableSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveWithNumberPad)];
    
    // Add buttons to the toolbar.
    accessoryToolBar.items = [NSArray arrayWithObjects:cancel, flexableSpace, save, nil];
    
    [accessoryToolBar sizeToFit];
    
    //  Change color of the toolbar and buttons.
    accessoryToolBar.barTintColor = [UIColor darkGrayColor];
    cancel.tintColor = [UIColor whiteColor];
    save.tintColor = [UIColor whiteColor];
    
    // Set the toolbar to show for all the textfields.
    for (int i = 0; i < self.currentTextFieldArray.count; i++) {
        
        UITextField *tempTextField = self.currentTextFieldArray[i];
        tempTextField.inputAccessoryView = accessoryToolBar;
    }
}

- (void)cancelNumberPad {
    
    //  Dismiss the keyboard.
    [self.view endEditing:YES];
}


- (void)saveWithNumberPad {
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    [self saveData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 9 + 1;
}

/*
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 // Return the number of rows in the section.
 
 NSArray *tempSectionTitleArray = self.Titles[section];
 
 return tempSectionTitleArray.count;
 }
 */

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 ExerciseCell *cell;
 
 NSString *cellIdentifier = @"ExerciseCell";
 //cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", indexPath.section + 1];
 //cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%d", [self findCurrentRow:indexPath]];
 
 cellIdentifier = [NSString stringWithFormat:@"%@_%d_%d", cellIdentifier, indexPath.section, indexPath.row];
 NSLog(@"%@", cellIdentifier);
 
 cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
 
 cell.weightField1.delegate = self;
 cell.weightField2.delegate = self;
 cell.weightField3.delegate = self;
 cell.weightField4.delegate = self;
 cell.weightField5.delegate = self;
 cell.weightField6.delegate = self;
 
 //  Configure the cell...
 [self configureExerciseCell:cell :indexPath :self.Reps[indexPath.section] :self.Titles[indexPath.section]];
 
 //  Get data from the database
 //NSInteger section = [indexPath section];
 [self exerciseMatches:cell :indexPath];
 
 
 //  Only save cells in the current section so that you can access them later when you need to save to database.
 if (indexPath.section == 0 && self.CellArray.count < self.Titles.count) {
 [self.CellArray addObject:cell];
 }
 
 
 [self.CellArray addObject:cell];
 
 return cell;
 }
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == [self numberOfSectionsInTableView:self.tableView] - 1) {
        
        return @"Finished";
    }
    else {
        
        NSNumber *headerSection = [NSNumber numberWithInteger:section +1];
        NSNumber *numberOfSections = [NSNumber numberWithInteger:self.tableView.numberOfSections - 1];
        NSString *headerTitle = @"";
        headerTitle = [headerTitle stringByAppendingFormat:@"Set %@ of %@", headerSection, numberOfSections];
        
        return headerTitle;
    }
}

- (IBAction)submitEntries:(id)sender {
    
    //  Save to the database
    [self saveData];
    
    [self shareActionSheet];
}

- (IBAction)showGraph:(UIButton *)sender {
    
    [self saveData];

    int minRange = 0;
    int maxRange = 0;
    NSMutableArray *tempArray;
    tempArray = [[NSMutableArray alloc] init];
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (int i = 0; i < self.graphButtonArray.count; i++) {
        
        if (self.graphButtonArray[i] == sender) {
            
            // Get name of exercise for this cell
            UILabel *tempLabel = self.exerciseLabelArray[i];
            //NSLog(@"Button = graphButton_%d", i + 1);
            
            mainAppDelegate.graphTitle = tempLabel.text;
            mainAppDelegate.graphRoutine = ((DataNavController *)self.parentViewController).routine;
            mainAppDelegate.graphWorkout = ((DataNavController *)self.parentViewController).workout;
            //NSLog(@"GraphTitle = %@", mainAppDelegate.graphTitle);
            //NSLog(@"GraphRoutine = %@", mainAppDelegate.graphRoutine);
            //NSLog(@"GraphWorkout = %@", mainAppDelegate.graphWorkout)
            
            // Get the beginning and end range for the reps labels in the cell
            minRange = i * 6;
            maxRange = (i * 6) + 6;
        }
    }
    
    // Get the number of reps labels in the cell that aren't ""
    for (int j = minRange; j < maxRange; j++) {
        
        if (![self.Reps[j] isEqualToString:@""]) {
            
            NSString *tempString = self.Reps[j];
            [tempArray addObject:tempString];
        }
    }
    
    mainAppDelegate.graphDataPoints = tempArray;
    
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        [self performSegueWithIdentifier:@"showPopover" sender:sender];
        
    }
}

- (void)shareActionSheet {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Data saved successfully.  Share your progress!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email .csv File", @"Facebook", @"Twitter", nil];
    
    [action showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
    
    self.actionSheetType = @"Share";
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([self.actionSheetType isEqualToString:@"Share"]) {
        
        if (buttonIndex == 0) {
            
            //  Get the csvstring and then send the email
            [self sendEmail:[self stringForEmail:self.Titles] ];
        }
        
        if (buttonIndex == 1) {
            
            [self facebook];
        }
        
        if (buttonIndex == 2) {
            
            [self twitter];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //  Save to the database
    [self saveData];
}

- (void)saveData {
    
    //  Save to the database
    [self saveToDatabase:self.Titles :self.Reps :self.currentTextFieldArray :self.currentNotesArray];
}

#pragma mark - Popover methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *destNav = segue.destinationViewController;
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        
        // This is the important part
        UIPopoverPresentationController *popPC = destNav.popoverPresentationController;
        popPC.delegate = self;
        popPC.sourceView = sender;
        //popPC.sourceRect = sender.bounds;
        popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    [self updateWorkoutCompleteCell];
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    [self updateWorkoutCompleteCell];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (IBAction)workoutCompletedToday:(UIButton *)sender {
    
    [self saveData];
    
    [self saveWorkoutComplete:[NSDate date]];
    
    [self updateWorkoutCompleteCell];
}

- (IBAction)workoutCompletedPrevious:(UIButton *)sender {
    
    [self saveData];
    
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 8.0) {
        
        // iOS 8 or greater show popover of chart/grid
        [self performSegueWithIdentifier:@"iOS8_PopoverDatePicker" sender:sender];
        
    }
}

- (IBAction)workoutCompletedDelete:(UIButton *)sender {
    
    [self saveData];
    
    [self deleteDate];
    
    [self updateWorkoutCompleteCell];
}

- (void)updateWorkoutCompleteCell {
    
    [self configureDateCell:self.dateCell :self.deleteDateButton :self.todayDateButton :self.previousDateButton :self.dateLabel];
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.bannerSize.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    if (self.headerView.frame.size.height == 0) {
        
        // No ads shown yet.  Animate showing the ad.
        CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.bannerSize.height);
        
        [UIView animateWithDuration:0.25 animations:^{ self.headerView.frame = headerViewFrame;
            self.tableView.tableHeaderView = self.headerView;
            self.adView.hidden = YES;}
         
                         completion:^(BOOL finished) {self.adView.hidden = NO;
                         }];
        
    } else {
        
        // Ad is already showing.
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    self.adView.hidden = YES;
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize size = [self.adView adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.headerView.bounds.size.height - size.height;
    self.adView.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    self.adView.hidden = NO;
}
@end
