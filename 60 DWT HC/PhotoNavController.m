//
//  PhotoNavController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "PhotoNavController.h"

@implementation PhotoNavController


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

//find the location of the image file/

- (NSString*)fileLocation:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths[0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG", imageName]];
    
    return fullPath;
    
}

//saving an image

- (void)saveImage:(UIImage*)image imageName:(NSString*)imageName {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0); //convert image into .JPG format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = paths[0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG", imageName]]; //add our image to the path
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
    
    //NSLog(@"image saved");
    
}

//loading an image

- (UIImage*)loadImage:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths[0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}

//loading an image for email attachment

- (NSData*)emailImage:(NSString *)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths[0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG", imageName]];
    
    return [NSData dataWithContentsOfFile:fullPath];
    
}

//removing an image

- (void)removeImage:(NSString*)fileName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = paths[0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG", fileName]];
    
    [fileManager removeItemAtPath: fullPath error:NULL];
    
    //NSLog(@"image removed");
    
}
@end
