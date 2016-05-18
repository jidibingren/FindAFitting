//
//  FAFShopCell.m
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFShopCell.h"

#define FAF_SHOP_DEFAULTIMAGE [UIImage imageNamed:@"shopdefault1"]

@implementation FAFShopCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    tempFrame.size.width  = ScreenWidth;
    tempFrame.size.height = FAF_SHOP_CELL_HEIGHT;
    
    UIView *tempView = self.contentView;
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.image = FAF_SHOP_DEFAULTIMAGE;
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(tempView.mas_left).offset(13);
        make.size.mas_equalTo(CGSizeMake(FAF_SHOP_ICON_HEIGHT, FAF_SHOP_ICON_HEIGHT));
    }];
    
    _levelLabel = [[UILabel alloc]init];
    _levelLabel.textColor = [SCColor getColor:@"24c1ec"];
    _levelLabel.font = [Utils fontWithSize:15];
    _levelLabel.textAlignment = NSTextAlignmentRight;
    [tempView addSubview:_levelLabel];
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(tempView.mas_right).offset(-11);
        make.top.mas_equalTo(_iconView.mas_top);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"333333"];
    _nameLabel.font = [Utils fontWithSize:17];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconView);
        make.left.mas_equalTo(_iconView.mas_right).offset(12);
        make.right.mas_equalTo(_levelLabel.mas_left);
        make.height.mas_equalTo(_levelLabel.mas_height);
    }];
    
    _briefLabel = [[UILabel alloc]init];
    _briefLabel.textColor = [SCColor getColor:@"666666"];
    _briefLabel.font = [Utils fontWithSize:11];
    _briefLabel.textAlignment = NSTextAlignmentLeft;
    _briefLabel.numberOfLines = 3;
    [tempView addSubview:_briefLabel];
    [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.left.mas_equalTo(_nameLabel);
        make.right.mas_equalTo(_levelLabel.mas_right);
        make.height.mas_equalTo(38);
    }];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textColor = [SCColor getColor:@"666666"];
    _addressLabel.font = [Utils fontWithSize:10];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_briefLabel.mas_bottom);
        make.left.mas_equalTo(_nameLabel);
        make.right.mas_equalTo(_levelLabel.mas_right);
        make.height.mas_equalTo(12);
    }];
    
    _seperatorLine = [[UIView alloc]init];
    _seperatorLine.backgroundColor = [SCColor getColor:@"ebebeb"];
    [tempView addSubview:_seperatorLine];
    [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconView.mas_left);
        make.right.mas_equalTo(_levelLabel.mas_right);
        make.bottom.mas_equalTo(tempView);
        make.height.mas_equalTo(0.5);
    }];
    
    _nameLabel.text = @"发电房间啊发发发电机发电房间爱的发发空间发的发";
    _levelLabel.text = [NSString stringWithFormat:@"%.1f分",100.000];
    _briefLabel.text = @"安居客的加法就发生的房间按房间爱书法的房间开拉法案件发放及会计法接发房间卡打飞机阿道夫";
    _addressLabel.text = @"大家发卡单发单发建安大发了房间爱聊发附件";
    
}


- (void)setData:(FAFShopCellData *)data{
    if (data && [data isKindOfClass:[FAFShopCellData class]]) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:data.imageUrl] placeholderImage:FAF_SHOP_DEFAULTIMAGE];
        _nameLabel.text = [Utils isValidStr:data.name] ? data.name : @"";
        _levelLabel.text =  [NSString stringWithFormat:@"%.1f分", data.score];
        _briefLabel.text = [Utils isValidStr:data.descs] ? data.descs : @"";
        _addressLabel.text = [Utils isValidStr:data.address] ? data.address : @"";
    }
}

@end
