//
//  FAFShippingAddressCell.m
//  FindAFitting
//
//  Created by SC on 16/5/8.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFShippingAddressCell.h"

@implementation FAFShippingAddressCell

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
        make.top.mas_equalTo(tempView.mas_top).offset(21);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(14);
    }];
    
    _phoneLabel = [[UILabel alloc]init];
    _phoneLabel.textColor = [SCColor getColor:@"666666"];
    _phoneLabel.font = [Utils fontWithSize:13];
    _phoneLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(2);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.bottom.mas_equalTo(_nameLabel.mas_bottom);
    }];
    
    _iconView = [[UIButton alloc]init];
    [_iconView setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(28, 14));
    }];
    
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textColor = [SCColor getColor:@"999999"];
    _addressLabel.font = [Utils fontWithSize:12];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.right.mas_equalTo(_phoneLabel.mas_right);
        make.left.mas_equalTo(_iconView.mas_right);
        make.bottom.mas_equalTo(_iconView.mas_bottom);
    }];
    
}

- (void)setData:(FAFAddress *)data{
    
    if ([data isKindOfClass:[FAFAddress class]]) {
    
        _nameLabel.text = data.buyer ? : @"";
        
        _phoneLabel.text = data.telephone ? : @"";
        
        _addressLabel.text = data.address ? : @"";
        
        if (data.isHome){
            
            [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLabel.mas_bottom);
                make.left.mas_equalTo(_nameLabel.mas_left);
                make.size.mas_equalTo(CGSizeMake(28, 14));
            }];
            
            [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLabel.mas_top);
                make.right.mas_equalTo(_phoneLabel.mas_right);
                make.left.mas_equalTo(_iconView.mas_right);
                make.bottom.mas_equalTo(_iconView.mas_bottom);
            }];
            
        }else{
            
            [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLabel.mas_bottom);
                make.left.mas_equalTo(_nameLabel.mas_left);
                make.size.mas_equalTo(CGSizeMake(0, 0));
            }];
            
            [_addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLabel.mas_bottom);
                make.right.mas_equalTo(_phoneLabel.mas_right);
                make.left.mas_equalTo(_nameLabel.mas_left);
                make.height.mas_equalTo(14);
            }];
            
        }
    }
}
@end
