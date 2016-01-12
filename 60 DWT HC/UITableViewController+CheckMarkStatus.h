//
//  UITableViewController+CheckMarkStatus.h
//  60 DWT HC
//
//  Created by Grant, Jared on 3/27/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataNavController.h"
#import "AppDelegate.h"
#import "UITableViewController+Database.m"

@interface UITableViewController (CheckMarkStatus) <UIActionSheetDelegate, UIAlertViewDelegate, UIPopoverPresentationControllerDelegate, UIPopoverControllerDelegate, UIGestureRecognizerDelegate>

- (void)LPGR_PressedSuccessfully:(UITableViewCell*)argCell :(NSString*)cellTitle;
- (void)BBI_EditButtonPressed:(UIBarButtonItem *)sender :(NSArray*)argTableCellArray;
- (NSInteger)findArrayPosition:(NSIndexPath*)indexPath;
- (void)actionSheetDisplay:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex :(UITableViewCell*)argCell :(NSString*)cellTitle :(NSArray*)argTableCellArray;
- (void)alertViewDisplay:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex :(UITableViewCell*)argCell :(NSArray*)argTableCellArray;
@end
