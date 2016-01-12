//
//  StoreListTVCCell.h
//  60 DWT HC
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreListTVCCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end
