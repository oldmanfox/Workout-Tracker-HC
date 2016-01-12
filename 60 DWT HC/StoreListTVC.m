//
//  StoreListTVC.m
//  60 DWT HC
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "StoreListTVC.h"
#import "StoreListTVCCell.h"

// 1
#import "60DWTHCIAPHelper.h"
#import <StoreKit/StoreKit.h>

// 2
@interface StoreListTVC () {
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
}
@end

@implementation StoreListTVC

// 3
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"shop_cart_selected"];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Store";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    // Add to end of viewDidLoad
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // Add to end of viewDidLoad
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 4
- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[_0DWTHCIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    //NSLog(@"Buying %@...", product.productIdentifier);
    [[_0DWTHCIAPHelper sharedInstance] buyProduct:product];
}

- (void)restoreTapped:(id)sender {
    [[_0DWTHCIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreListTVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    [_priceFormatter setLocale:product.priceLocale];
    
    cell.titleLabel.text = product.localizedTitle;
    cell.descriptionLabel.text = product.localizedDescription;
    cell.priceLabel.text = [_priceFormatter stringFromNumber:product.price];
    cell.buyButton.tag = indexPath.row;
    //cell.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    cell.descriptionLabel.font = [UIFont systemFontOfSize:16];
    
    //cell.priceLabel.textColor = [UIColor colorWithRed:48/255.0f green:137/255.0f blue:210/255.0f alpha:1];
    
    if ([[_0DWTHCIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.buyButton.hidden = YES;
        
    } else {
        
        [cell.buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Configure tableview.
    NSArray *tableCell = @[cell];
    NSArray *accessoryIcon = @[@NO];
    NSArray *cellColor = @[@NO];
    
    [self configureStoreTableView:tableCell :accessoryIcon :cellColor];
    
    
    return cell;
}

@end
