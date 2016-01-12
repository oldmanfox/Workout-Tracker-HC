//
//  MainTBC.m
//  90 DWT 1
//
//  Created by Grant, Jared on 12/10/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import "MainTBC.h"
#import "CoreDataHelper.h"

@interface MainTBC ()

@end

@implementation MainTBC

#define debug 0

@synthesize workoutChanged;

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) readBandSetting {
    
}
@end
