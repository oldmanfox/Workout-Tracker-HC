//
//  PhotoNavController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoNavController : UINavigationController

@property (strong, nonatomic) NSString *month; // Current month for pictures.
@property (strong, nonatomic) NSString *photoMonthSelected; // Month for pictures to save/load.

- (void)saveImage:(UIImage*)image imageName:(NSString*)imageName;
- (UIImage*)loadImage:(NSString*)imageName;
- (void)removeImage:(NSString*)fileName;
- (NSData*)emailImage:(NSString*)imageName;
- (NSString*)fileLocation:(NSString*)imageName;

@end
