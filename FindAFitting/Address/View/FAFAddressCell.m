//
//  FAFAddressBaseCell.m
//  FindAFitting
//
//  Created by SC on 16/5/8.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFAddressCell.h"

@implementation FAFCurrentAddressCell

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    CGRect tempFrame = frame;
    
    tempFrame.origin = CGPointZero;
    
    tempFrame.size.width = ScreenWidth;
    
    tempFrame.size.height = FAF_ADDRESS_BASE_HEIGHT;
    
    UIView *tempView = self.contentView;
    
    _relocationBtn = [UIButton new];
    [_relocationBtn setTitle:NSLocalizedString(@"重新定位", nil) forState:UIControlStateNormal];
    [_relocationBtn setTitleColor:[SCColor getColor:@"53abfd"] forState:UIControlStateNormal];
    _relocationBtn.titleLabel.font = [Utils fontWithSize:13];
    [tempView addSubview:_relocationBtn];
    [_relocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView);
        make.bottom.mas_equalTo(tempView);
        make.right.mas_equalTo(tempView).offset(-17);
        make.width.mas_equalTo(60);
    }];
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.image = [UIImage imageNamed:@"weizhi"];
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.right.mas_equalTo(_relocationBtn.mas_left);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"666666"];
    _nameLabel.font = [Utils fontWithSize:13];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.right.mas_equalTo(_iconView.mas_left);
        make.top.mas_equalTo(_iconView.mas_top);
        make.bottom.mas_equalTo(_iconView.mas_bottom);
    }];
    
}

- (void)setData:(FAFAddress *)data{
    
    if ([data isKindOfClass:[FAFAddress class]]) {
        _nameLabel.text = data.name ? :@"";
    }
}

@end

@implementation FAFNearbyAddressCell1

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    CGRect tempFrame = frame;
    
    tempFrame.origin = CGPointZero;
    
    tempFrame.size.width = ScreenWidth;
    
    tempFrame.size.height = FAF_ADDRESS_BASE_HEIGHT;
    
    UIView *tempView = self.contentView;
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"666666"];
    _nameLabel.font = [Utils fontWithSize:13];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.top.mas_equalTo(tempView.mas_top);
        make.bottom.mas_equalTo(tempView.mas_bottom);
    }];
    
}

- (void)setData:(FAFAddress *)data{
    
    if ([data isKindOfClass:[FAFAddress class]]) {
        _nameLabel.text = data.name ? :@"";
    }
}

@end

@implementation FAFNearbyAddressCell2

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    CGRect tempFrame = frame;
    
    tempFrame.origin = CGPointZero;
    
    tempFrame.size.width = ScreenWidth;
    
    tempFrame.size.height = FAF_ADDRESS_BASE_HEIGHT;
    
    UIView *tempView = self.contentView;
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.image = [UIImage imageNamed:@"jiantou"];
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.right.mas_equalTo(tempView).offset(-17);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"666666"];
    _nameLabel.font = [Utils fontWithSize:13];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.text = NSLocalizedString(@"更多地址", nil);
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.right.mas_equalTo(_iconView.mas_left);
        make.top.mas_equalTo(_iconView.mas_top);
        make.bottom.mas_equalTo(_iconView.mas_bottom);
    }];
    
}

- (void)setData:(FAFAddress *)data{
    
}

@end


