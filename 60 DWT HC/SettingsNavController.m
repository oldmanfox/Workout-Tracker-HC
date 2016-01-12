//
//  SettingsNavController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/12/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "SettingsNavController.h"

@implementation SettingsNavController


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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
