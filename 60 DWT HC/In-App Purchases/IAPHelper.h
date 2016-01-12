//
//  IAPHelper.h
//  60 DWT HC
//
//  Created by Jared Grant on 9/15/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler) (BOOL success, NSArray * products);

@interface IAPHelper : NSObject

//@property (nonatomic, strong) NSMutableDictionary * products;

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)restoreCompletedTransactions;

@end