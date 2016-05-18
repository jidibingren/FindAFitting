//
//  FAFGoodsTitleCell.m
//  FindAFitting
//
//  Created by SC on 16/5/17.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFGoodsTitleCell.h"

@implementation FAFGoodsTitleCell

- (void)setupSubviewsWithFrame:(CGRect)frame{

    UIView *tempView = self.contentView;
    
    _sharebtn = [UIButton new];
    [_sharebtn setBackgroundImage:[UIImage imageNamed:@"goog_icon_share"] forState:UIControlStateNormal];
    [tempView addSubview:_sharebtn];
    [_sharebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView).offset(7);
        make.right.mas_equalTo(tempView).offset(-17);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_sharebtn bk_whenTapped:^{
        ;
    }];
    
    _shareLabel = [UILabel new];
    _shareLabel.textColor = [SCColor getColor:@"233642"];
    _shareLabel.font = [Utils fontWithSize:10];
    _shareLabel.text = NSLocalizedString(@"分享", nil);
    [tempView addSubview:_shareLabel];
    [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sharebtn.mas_bottom).offset(10);
        make.left.mas_equalTo(_sharebtn.mas_left);
        make.right.mas_equalTo(_sharebtn.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    _seperatorView = [UIView new];
    _seperatorView.backgroundColor = [SCColor getColor:@"dddddd"];
    [tempView addSubview:_seperatorView];
    [_seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView).offset(10);
        make.right.mas_equalTo(_sharebtn.mas_left).offset(-17);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [SCColor getColor:@"051b28"];
    _nameLabel.font = [Utils fontWithSize:15];
    _nameLabel.numberOfLines = 2;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempView).offset(10);
        make.top.mas_equalTo(tempView).offset(10);
        make.right.mas_equalTo(_seperatorView.mas_right).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    
    _unitLabel = [UILabel new];
    _unitLabel.textColor = [SCColor getColor:@"ff5000"];
    _unitLabel.font = [Utils fontWithSize:15];
    _unitLabel.text = NSLocalizedString(@"¥", nil);
    [tempView addSubview:_unitLabel];
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.left.mas_equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(10, 20));
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.textColor = [SCColor getColor:@"ff5000"];
    _priceLabel.font = [Utils fontWithSize:20];
    [tempView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.left.mas_equalTo(_unitLabel.mas_right);
        make.width.mas_greaterThanOrEqualTo(20);
        make.height.mas_equalTo(_unitLabel.mas_height);
    }];
    
    
    _priceAddLabel1 = [UILabel new];
    _priceAddLabel1.backgroundColor = [SCColor getColor:@"ff5000"];
    _priceAddLabel1.textColor = [SCColor getColor:@"fffffe"];
    _priceAddLabel1.font = [Utils fontWithSize:15];
    _priceAddLabel1.textAlignment = NSTextAlignmentCenter;
    _priceAddLabel1.text = NSLocalizedString(@"特惠团", nil);
    [tempView addSubview:_priceAddLabel1];
    [_priceAddLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_unitLabel);
        make.left.mas_equalTo(_priceLabel.mas_right).offset(10);
        make.width.mas_greaterThanOrEqualTo(50);
        make.height.mas_equalTo(_unitLabel.mas_height);
    }];
    
    _priceAddLabel2 = [UILabel new];
    _priceAddLabel2.backgroundColor = [SCColor getColor:@"ff9204"];
    _priceAddLabel2.textColor = [SCColor getColor:@"fffffe"];
    _priceAddLabel2.font = [Utils fontWithSize:15];
    _priceAddLabel2.textAlignment = NSTextAlignmentCenter;
    _priceAddLabel2.text = NSLocalizedString(@"淘金币抵1%", nil);
    [tempView addSubview:_priceAddLabel2];
    [_priceAddLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_unitLabel);
        make.left.mas_equalTo(_priceAddLabel1.mas_right).offset(10);
        make.width.mas_greaterThanOrEqualTo(80);
        make.height.mas_equalTo(_unitLabel.mas_height);
    }];
    
    _orginalPriceUnitLabel = [UILabel new];
    _orginalPriceUnitLabel.textColor = [SCColor getColor:@"999999"];
    _orginalPriceUnitLabel.font = [Utils fontWithSize:15];
    _orginalPriceUnitLabel.text = NSLocalizedString(@"价格:", nil);
    [tempView addSubview:_orginalPriceUnitLabel];
    [_orginalPriceUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_unitLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(_unitLabel);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(_unitLabel);
    }];
    
    _orginalPriceLabel = [UILabel new];
    _orginalPriceLabel.textColor = [SCColor getColor:@"999999"];
    _orginalPriceLabel.font = [Utils fontWithSize:15];
    [tempView addSubview:_orginalPriceLabel];
    [_orginalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orginalPriceUnitLabel);
        make.left.mas_equalTo(_orginalPriceUnitLabel.mas_right);
        make.width.mas_greaterThanOrEqualTo(20);
        make.height.mas_equalTo(_orginalPriceUnitLabel);
    }];
    
    _sendPriceLabel = [UILabel new];
    _sendPriceLabel.textColor = [SCColor getColor:@"ababab"];
    _sendPriceLabel.font = [Utils fontWithSize:15];
    _sendPriceLabel.text = NSLocalizedString(@"快递：免运费", nil);
    [tempView addSubview:_sendPriceLabel];
    [_sendPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orginalPriceUnitLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_orginalPriceUnitLabel);
        make.height.mas_equalTo(_orginalPriceUnitLabel);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    _selledCountLabel = [UILabel new];
    _selledCountLabel.textColor = [SCColor getColor:@"ababab"];
    _selledCountLabel.font = [Utils fontWithSize:15];
    _selledCountLabel.textAlignment = NSTextAlignmentCenter;
    _selledCountLabel.text = NSLocalizedString(@"月销100笔", nil);
    [tempView addSubview:_selledCountLabel];
    [_selledCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sendPriceLabel);
        make.centerX.mas_equalTo(tempView);
        make.height.mas_equalTo(_sendPriceLabel);
        make.width.mas_equalTo(100);
    }];
    
    _addressLabel = [UILabel new];
    _addressLabel.textColor = [SCColor getColor:@"ababab"];
    _addressLabel.font = [Utils fontWithSize:15];
    _addressLabel.textAlignment = NSTextAlignmentRight;
    _addressLabel.text = NSLocalizedString(@"全国", nil);
    [tempView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sendPriceLabel);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.height.mas_equalTo(_orginalPriceUnitLabel);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    _sendIconImageView = [UIImageView new];
    _sendIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _sendIconImageView.image = [UIImage imageNamed:@"goog_icon_car"];
    [tempView addSubview:_sendIconImageView];
    [_sendIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sendPriceLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(tempView).offset(17);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    _sendTimeLabel = [UILabel new];
    _sendTimeLabel.textColor = [SCColor getColor:@"999999"];
    _sendTimeLabel.font = [Utils fontWithSize:15];
    _sendTimeLabel.text = NSLocalizedString(@"尽快送达", nil);
    [tempView addSubview:_sendTimeLabel];
    [_sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sendPriceLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_sendIconImageView.mas_right).offset(10);
        make.right.mas_equalTo(tempView).offset(-17);
        make.height.mas_equalTo(20);
    }];
}

@end
