//
//  FAFGoodsTitleCell.h
//  FindAFitting
//
//  Created by SC on 16/5/17.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

@interface FAFGoodsTitleCell : SCTableViewCell

@property (nonatomic, strong)UILabel  *nameLabel;
@property (nonatomic, strong)UIView   *seperatorView;
@property (nonatomic, strong)UIButton *sharebtn;
@property (nonatomic, strong)UILabel  *shareLabel;
@property (nonatomic, strong)UILabel  *unitLabel;
@property (nonatomic, strong)UILabel  *priceLabel;
@property (nonatomic, strong)UILabel  *priceAddLabel1;
@property (nonatomic, strong)UILabel  *priceAddLabel2;
@property (nonatomic, strong)UILabel  *orginalPriceUnitLabel;
@property (nonatomic, strong)UILabel  *orginalPriceLabel;
@property (nonatomic, strong)UILabel  *sendPriceLabel;
@property (nonatomic, strong)UILabel  *selledCountLabel;
@property (nonatomic, strong)UILabel  *addressLabel;
@property (nonatomic, strong)UIImageView  *sendIconImageView;
@property (nonatomic, strong)UILabel  *sendTimeLabel;

@end
