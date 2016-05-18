//
//  FAFNearbyCell.m
//  FindAFitting
//
//  Created by SC on 16/5/9.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFNearbyCell.h"

@implementation FAFNearbyCell

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    CGRect tempFrame = frame;
    
    tempFrame.origin = CGPointZero;
    
    tempFrame.size.width = ScreenWidth;
    
    tempFrame.size.height = FAF_ADDRESS_BASE_HEIGHT;
    
    UIView *tempView = self.contentView;
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.image = [UIImage imageNamed:@"dingwei"];
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.top.mas_equalTo(tempView.mas_top).offset(17);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(17);
    }];
    
    _curAddressLabel = [[UILabel alloc]init];
    _curAddressLabel.textColor = [SCColor getColor:@"53abfd"];
    _curAddressLabel.font = [Utils fontWithSize:15];
    _curAddressLabel.textAlignment = NSTextAlignmentLeft;
    _curAddressLabel.text = @"[当前]";
    [tempView addSubview:_curAddressLabel];
    [_curAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconView.mas_right).offset(1.5);
        make.top.mas_equalTo(tempView.mas_top).offset(17);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(17);
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"666666"];
    _nameLabel.font = [Utils fontWithSize:15];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_curAddressLabel.mas_right);
        make.top.mas_equalTo(tempView.mas_top).offset(17);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.height.mas_equalTo(17);
    }];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textColor = [SCColor getColor:@"666666"];
    _addressLabel.font = [Utils fontWithSize:12];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconView.mas_right).offset(1.5);
        make.top.mas_equalTo(_iconView.mas_bottom);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.height.mas_equalTo(17);
    }];
    
}

- (void)setData:(FAFAddress *)data{
    
    [self setData:data indexPath:nil];
    
}

- (void)setData:(FAFAddress *)data indexPath:(NSIndexPath*)indexPath{
    
    if ([data isKindOfClass:[FAFAddress class]]) {
        _nameLabel.text = data.name ? :@"";
        _addressLabel.text = data.address ? :@"";
        
        
        UIView *tempView = self.contentView;
        
        if (indexPath.row == 0) {
            [_curAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_iconView.mas_right).offset(1.5);
                make.top.mas_equalTo(tempView.mas_top).offset(17);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(17);
            }];
            
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_curAddressLabel.mas_right);
                make.top.mas_equalTo(tempView.mas_top).offset(17);
                make.right.mas_equalTo(tempView.mas_right).offset(-17);
                make.height.mas_equalTo(17);
            }];
            
        }else {
            
            [_curAddressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(-100);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(0);
            }];
            
            [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_iconView.mas_right).offset(1.5);
                make.top.mas_equalTo(tempView.mas_top).offset(17);
                make.right.mas_equalTo(tempView.mas_right).offset(-17);
                make.height.mas_equalTo(17);
            }];
        }
    }
}

@end
