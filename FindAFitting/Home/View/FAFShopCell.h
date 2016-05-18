//
//  FAFShopCell.h
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

#define FAF_SHOP_CELL_HEIGHT 91
#define FAF_SHOP_ICON_HEIGHT 70

@interface FAFShopCell : SCTableViewCell

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UILabel     *levelLabel;
@property (nonatomic, strong)UILabel     *briefLabel;
@property (nonatomic, strong)UILabel     *addressLabel;
@property (nonatomic, strong)UIView      *seperatorLine;

@end
