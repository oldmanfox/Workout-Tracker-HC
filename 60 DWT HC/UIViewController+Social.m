//
//  UIViewController+Social.m
//  90 DWT 2
//
//  Created by Grant, Jared on 11/19/12.
//  Copyright (c) 2012 Grant, Jared. All rights reserved.
//

#import "UIViewController+Social.h"

@implementation UIViewController (Social)

- (BOOL)connectedToNetwork  {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        
        //NSLog(@"Error. Could not recover network reachability flags");
        return 0;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    //below suggested by Ariel
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    NSURL *testURL = [NSURL URLWithString:@"http://www.apple.com/"]; //comment by friendlydeveloper: maybe use www.google.com
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    //NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:nil]; //suggested by Ariel
    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:nil]; //modified by friendlydeveloper
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}

- (void)facebook {
    
    SLComposeViewController *facebookComposer;
    facebookComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    // Check if they are signed into Facebook
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        // Check for internet connectivity
        if ([self connectedToNetwork]) {
            
            // Good to post to Facebook
            //[facebookComposer setInitialText:theStory.text];
            [self presentViewController:facebookComposer animated:YES completion:NULL];
        }
        
        else {
            
            // Neet to connect to internet before posting to Facebook
            UIAlertView *alertDialog;
            alertDialog = [[UIAlertView alloc]
                           initWithTitle:@"Not Connected To Internet."
                           message:@"Please ensure you are connected to the internet before posting to Facebook."
                           delegate: nil
                           cancelButtonTitle: @"Ok"
                           otherButtonTitles: nil];
            [alertDialog show];
        }
    }
    
    else {
        
        // Not signed into Facebook
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle:@"Facebook Not Configured."
                       message:@"Please sign-in to Facebook from your device Settings -> Facebook tab."
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
    }
}

- (void)twitter {
    
    SLComposeViewController *twitterComposer;
    twitterComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Check if they are signed into Twitter
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        // Check for internet connectivity
        if ([self connectedToNetwork]) {
            
            // Good to post to Twitter
            //[twitterComposer setInitialText:theStory.text];
            [self presentViewController:twitterComposer animated:YES completion:NULL];
        }
        
        else {
            
            // Neet to connect to internet before posting to Twitter
            UIAlertView *alertDialog;
            alertDialog = [[UIAlertView alloc]
                           initWithTitle:@"Not Connected To Internet."
                           message:@"Please ensure you are connected to the internet before posting to Twitter."
                           delegate: nil
                           cancelButtonTitle: @"Ok"
                           otherButtonTitles: nil];
            [alertDialog show];
        }
    }
    
    else {
        
        // Not signed into Twitter
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle:@"Twitter Not Configured."
                       message:@"Please sign-in to Twitter from your device Settings -> Twitter tab."
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
    }
}
@end
