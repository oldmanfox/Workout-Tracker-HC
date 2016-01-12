//
//  UITableViewController+CheckMarkStatus.m
//  60 DWT HC
//
//  Created by Grant, Jared on 3/27/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import "UITableViewController+CheckMarkStatus.h"

@implementation UITableViewController (CheckMarkStatus)

- (void)LPGR_PressedSuccessfully:(UITableViewCell*)argCell :(NSString*)cellTitle {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *tempMessage = [NSString stringWithFormat:@"Set the status for:\n\n%@ - %@ - %@", ((DataNavController *)self.parentViewController).routine, ((DataNavController *)self.parentViewController).week, cellTitle];
    
    //NSLog(@"%@", tempMessage);
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Workout Status"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *notCompletedAction = [UIAlertAction
                                             actionWithTitle:@"Not Completed"
                                             style:UIAlertActionStyleDestructive
                                             handler:^(UIAlertAction *action) {
                                                 
                                                 appDelegate.request = @"Not Completed";
                                                 [self verifyAddDeleteRequestFromTableViewCell:argCell :cellTitle];
                                             }];
        
        UIAlertAction *completedAction = [UIAlertAction
                                          actionWithTitle:NSLocalizedString(@"Completed", @"Completed action")
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action) {
                                              
                                              appDelegate.request = @"Completed";
                                              [self verifyAddDeleteRequestFromTableViewCell:argCell :cellTitle];
                                          }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:notCompletedAction];
        [alertController addAction:completedAction];
        [alertController addAction:cancelAction];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        
        if (popover)
        {
            popover.sourceView = argCell;
            popover.delegate = self;
            popover.sourceRect = argCell.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIActionSheet (iOS 7 and below)
        NSString *tempMessage_iOS7 = [NSString stringWithFormat:@"Workout Status\n\n%@", tempMessage];
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:tempMessage_iOS7
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                  destructiveButtonTitle:@"Not Completed"
                                                       otherButtonTitles:@"Completed", nil];
        
        // Action sheet from tableview Cell
        actionSheet.tag = 100;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            // In this case the device is an iPad.
            [actionSheet showFromRect:argCell.bounds inView:argCell animated:YES];
        }
        else{
            
            // In this case the device is an iPhone/iPod Touch.
            [actionSheet showInView:self.view];
        }
    }
}

- (void)BBI_EditButtonPressed:(UIBarButtonItem *)sender :(NSArray*)argTableCellArray {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *tempMessage = [NSString stringWithFormat:@"Set the status for all workouts of:\n\n%@ - %@", ((DataNavController *)self.parentViewController).routine, ((DataNavController *)self.parentViewController).week];
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Workout Status"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *notCompletedAction = [UIAlertAction
                                             actionWithTitle:@"Not Completed"
                                             style:UIAlertActionStyleDestructive
                                             handler:^(UIAlertAction *action) {
                                                 
                                                 appDelegate.request = @"Not Completed";
                                                 [self verifyAddDeleteRequestFromBarButtonItem:argTableCellArray];
                                             }];
        
        UIAlertAction *completedAction = [UIAlertAction
                                          actionWithTitle:NSLocalizedString(@"Completed", @"Completed action")
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action) {
                                              
                                              appDelegate.request = @"Completed";
                                              [self verifyAddDeleteRequestFromBarButtonItem:argTableCellArray];
                                          }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:notCompletedAction];
        [alertController addAction:completedAction];
        [alertController addAction:cancelAction];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        
        if (popover)
        {
            popover.barButtonItem = sender;
            popover.sourceView = self.view;
            popover.delegate = self;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIAlertView (iOS 7 and below)
        NSString *tempMessage_iOS7 = [NSString stringWithFormat:@"Workout Status\n\n%@", tempMessage];
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:tempMessage_iOS7
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                  destructiveButtonTitle:@"Not Completed"
                                                       otherButtonTitles:@"Completed", nil];
        
        // Action sheet from barbuttonitem
        actionSheet.tag = 200;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            // In this case the device is an iPad.
            //CGRect frame = [self.view convertRect:cell.bounds fromView:cell];
            [actionSheet showFromBarButtonItem:sender animated:YES];
        }
        else{
            
            // In this case the device is an iPhone/iPod Touch.
            [actionSheet showInView:self.view];
        }
    }
}

- (void)verifyAddDeleteRequestFromTableViewCell:(UITableViewCell*)argCell :(NSString*)cellTitle {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *tempMessage = [NSString stringWithFormat:@"You are about to set the status for\n\n%@ - %@ - %@\n\nto:\n\n%@\n\nDo you want to proceed?", ((DataNavController *)self.parentViewController).routine, ((DataNavController *)self.parentViewController).week ,cellTitle, mainAppDelegate.request];
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Warning"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action) {
                                        
                                        [self addDeleteDate:argCell];
                                        
                                        //NSLog(@"Not Completed action");
                                        //NSLog(@"Week Position = %ld", (long)mainAppDelegate.weekArrayPositionValue);
                                        //NSLog(@"WorkoutTBLVW Position = %ld", (long)mainAppDelegate.selectedWorkoutArrayPositionValue);
                                    }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:yesAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIAlertView (iOS 7 and below)
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:tempMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Yes", nil];
        alertView.tag = 100;
        
        [alertView show];
    }
}

- (void)verifyAddDeleteRequestFromBarButtonItem:(NSArray*)argTableCellArray {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *tempMessage = [NSString stringWithFormat:@"You are about to set the status for all workouts of:\n\n%@ - %@\n\nto:\n\n%@\n\nDo you want to proceed?", ((DataNavController *)self.parentViewController).routine, ((DataNavController *)self.parentViewController).week, mainAppDelegate.request];
    
    if ([UIAlertController class]) {
        
        // Use UIAlertController (iOS 8 and above)
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Warning"
                                              message:tempMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action) {
                                        
                                        [self AddDeleteDatesFromOneWeek:argTableCellArray];
                                    }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           //NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:yesAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {
        
        // Use UIAlertView (iOS 7 and below)
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:tempMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Yes", nil];
        
        alertView.tag = 200;
        
        [alertView show];
    }
}

- (void)addDeleteDate:(UITableViewCell*)argCell {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // ***DELETE***
    
    if ([mainAppDelegate.request isEqualToString:@"Not Completed"]) {
        
        // 60 - Normal
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"60 - Normal"]) {
            
            NSArray *nameArray = mainAppDelegate._60_Normal_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._60_Normal_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            [self deleteDateWithArguments:indexArray[mainAppDelegate.selectedWorkoutArrayPositionValue]
                                         :((DataNavController *)self.parentViewController).routine
                                         :nameArray[mainAppDelegate.selectedWorkoutArrayPositionValue] ];
        }
        
        // 30 - Bulk
        else if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"30 - Bulk"]) {
            
            NSArray *nameArray = mainAppDelegate._30_Bulk_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Bulk_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            [self deleteDateWithArguments:indexArray[mainAppDelegate.selectedWorkoutArrayPositionValue]
                                         :((DataNavController *)self.parentViewController).routine
                                         :nameArray[mainAppDelegate.selectedWorkoutArrayPositionValue] ];
        }

        
        else {
            
            // 30 - Tone
            NSArray *nameArray = mainAppDelegate._30_Tone_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Tone_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self deleteDateWithArguments:indexArray[mainAppDelegate.selectedWorkoutArrayPositionValue]
                                             :((DataNavController *)self.parentViewController).routine
                                             :nameArray[mainAppDelegate.selectedWorkoutArrayPositionValue]];
            }
        }
        
        // Update TableViewCell Accessory Icon - Arrow
        UIImage* accessoryArrow = [UIImage imageNamed:@"nav_r_arrow_grey"];
        UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryArrow];
        argCell.accessoryView = accessoryView;
    }
    
    else {
        
        // ***ADD***
        
        // 60 - Normal
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"60 - Normal"]) {
            
            NSArray *nameArray = mainAppDelegate._60_Normal_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._60_Normal_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[mainAppDelegate.selectedWorkoutArrayPositionValue]
                                                      :((DataNavController *)self.parentViewController).routine
                                                      :nameArray[mainAppDelegate.selectedWorkoutArrayPositionValue]];
            }
        }
        
        // 30 - Bulk
        else if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"30 - Bulk"]) {
            
            NSArray *nameArray = mainAppDelegate._30_Bulk_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Bulk_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[mainAppDelegate.selectedWorkoutArrayPositionValue]
                                                      :((DataNavController *)self.parentViewController).routine
                                                      :nameArray[mainAppDelegate.selectedWorkoutArrayPositionValue]];
            }
        }
        else {
            
            // 30 - Tone
            NSArray *nameArray = mainAppDelegate._30_Tone_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Tone_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[mainAppDelegate.selectedWorkoutArrayPositionValue]
                                                      :((DataNavController *)self.parentViewController).routine
                                                      :nameArray[mainAppDelegate.selectedWorkoutArrayPositionValue]];
            }
        }
        
        // Update TableViewCell Accessory Icon - Checkmark
        
        
        UIImage* accessoryCheckMark = [UIImage imageNamed:@"checkMark_orange_22"];
        UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryCheckMark];
        argCell.accessoryView = accessoryView;
        
        
        /*
        argCell.accessoryView = nil;
        argCell.accessoryType = UITableViewCellAccessoryCheckmark;
         */
    }
}

- (void)AddDeleteDatesFromOneWeek:(NSArray*)argTableCellArray {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // ***DELETE***
    
    if ([mainAppDelegate.request isEqualToString:@"Not Completed"]) {
        
        // 60 - Normal
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"60 - Normal"]) {
            
            NSArray *nameArray = mainAppDelegate._60_Normal_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._60_Normal_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self deleteDateWithArguments:indexArray[i]
                                             :((DataNavController *)self.parentViewController).routine
                                             :nameArray[i]];
            }
        }

        // 30 - Bulk
        else if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"30 - Bulk"]) {
            
            NSArray *nameArray = mainAppDelegate._30_Bulk_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Bulk_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self deleteDateWithArguments:indexArray[i]
                                             :((DataNavController *)self.parentViewController).routine
                                             :nameArray[i]];
            }
        }
        else {
            
            // 30 - Tone
            NSArray *nameArray = mainAppDelegate._30_Tone_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Tone_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self deleteDateWithArguments:indexArray[i]
                                             :((DataNavController *)self.parentViewController).routine
                                             :nameArray[i]];
            }
        }
        
        // Update TableViewCell Accessory Icon - Arrow
        for (int i = 0; i < argTableCellArray.count; i++) {
            
            UITableViewCell *cell = argTableCellArray[i];
            
            UIImage* accessoryArrow = [UIImage imageNamed:@"nav_r_arrow_grey"];
            UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryArrow];
            cell.accessoryView = accessoryView;
        }
    }
    
    else {
        
        // ***ADD***
        
        // 60 - Normal
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"60 - Normal"]) {
            
            NSArray *nameArray = mainAppDelegate._60_Normal_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._60_Normal_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[i]
                                                      :((DataNavController *)self.parentViewController).routine
                                                      :nameArray[i]];
            }
        }

        // 30 - Bulk
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"30 - Bulk"]) {
            
            NSArray *nameArray = mainAppDelegate._30_Bulk_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Bulk_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[i]
                                                      :((DataNavController *)self.parentViewController).routine
                                                      :nameArray[i]];
            }
        }
        else {
            
            // 30 - Tone
            NSArray *nameArray = mainAppDelegate._30_Tone_WorkoutNameArray[mainAppDelegate.weekArrayPositionValue];
            NSArray *indexArray = mainAppDelegate._30_Tone_WorkoutIndexArray[mainAppDelegate.weekArrayPositionValue];
            
            for (int i = 0; i < nameArray.count; i++) {
                
                [self saveWorkoutCompleteWithArguments:indexArray[i]
                                                      :((DataNavController *)self.parentViewController).routine
                                                      :nameArray[i]];
            }
        }
        
        // Update TableViewCell Accessory Icon - checkmark
        for (int i = 0; i < argTableCellArray.count; i++) {
            
            UITableViewCell *cell = argTableCellArray[i];
            
            
            UIImage* accessoryCheckMark = [UIImage imageNamed:@"checkMark_orange_22"];
            UIImageView* accessoryView = [[UIImageView alloc] initWithImage:accessoryCheckMark];
            cell.accessoryView = accessoryView;
            
            
            /*
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
             */
        }
    }
}

- (NSInteger)findArrayPosition:(NSIndexPath*)indexPath {
    
    NSInteger position = 0;
    
    for (int i = 0; i <= indexPath.section; i++) {
        
        if (i == indexPath.section) {
            
            position = position + (indexPath.row + 1);
        }
        
        else {
            
            NSInteger totalRowsInSection = [self.tableView numberOfRowsInSection:i];
            
            position = position + totalRowsInSection;
        }
    }
    
    return position - 1;
}

- (void)actionSheetDisplay:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex :(UITableViewCell*)argCell :(NSString*)cellTitle :(NSArray*)argTableCellArray {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (actionSheet.tag == 100) {
        
        // Action sheet from tableview Cell
        
        if (buttonIndex == 0) {
            
            // Not Completed
            //NSLog(@"Not Completed");
            
            mainAppDelegate.request = @"Not Completed";
            [self verifyAddDeleteRequestFromTableViewCell:argCell :cellTitle];
        }
        
        else if (buttonIndex == 1) {
            
            // Completed
            //NSLog(@"Completed");
            
            mainAppDelegate.request = @"Completed";
            [self verifyAddDeleteRequestFromTableViewCell:argCell :cellTitle];
        }
        
        else {
            
            // Cancel
            //NSLog(@"Cancel");
        }
    }
    
    else if (actionSheet.tag == 200) {
        
        // Action sheet from a barbuttonitem
        
        if (buttonIndex == 0) {
            
            // Not Completed
            //NSLog(@"Not Completed");
            
            mainAppDelegate.request = @"Not Completed";
            [self verifyAddDeleteRequestFromBarButtonItem:argTableCellArray];
        }
        
        else if (buttonIndex == 1) {
            
            // Completed
            //NSLog(@"Completed");
            
            mainAppDelegate.request = @"Completed";
            [self verifyAddDeleteRequestFromBarButtonItem:argTableCellArray];
        }
        
        else {
            
            // Cancel
            //NSLog(@"Cancel");
        }
    }
}
- (void)alertViewDisplay:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex :(UITableViewCell*)argCell :(NSArray*)argTableCellArray {
    
    if (alertView.tag == 100) {
        
        // Alert View for a tableview Cell
        
        if (buttonIndex == 0) {
            
            // Cancel
            //NSLog(@"Cancel");
        }
        
        else if (buttonIndex == 1) {
            
            // Yes
            //NSLog(@"Yes");
            
            [self addDeleteDate:argCell];
        }
    }
    
    else if (alertView.tag == 200) {
        
        // Alert View for a barbuttonitem
        
        if (buttonIndex == 0) {
            
            // Cancel
            //NSLog(@"Cancel");
        }
        
        else if (buttonIndex == 1) {
            
            // Yes
            //NSLog(@"Yes");
            
            [self AddDeleteDatesFromOneWeek:argTableCellArray];
        }
    }
}
@end
