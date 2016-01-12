//
//  PhotoScrollerViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PhotoScrollerDetailViewController.h"
#import "PhotoNavController.h"
#import <CoreImage/CoreImage.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import "UIViewController+Social.h"
#import "UIImage+Resizing.h"
#import "photoCollectionViewCell.h"
#import "CoreDataHelper.h"

@interface PhotoScrollerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareActionButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *arrayOfImages;
@property (strong, nonatomic) UIPopoverController *myPopoverController;

- (IBAction)shareActionSheet:(UIBarButtonItem *)sender;
@end
