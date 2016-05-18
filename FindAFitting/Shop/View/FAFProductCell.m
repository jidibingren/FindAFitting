//
//  FAFProductCell.m
//  FindAFitting
//
//  Created by SC on 16/5/14.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFProductCell.h"

@implementation FAFProductCell

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    UIView *tempView = self.contentView;
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.image = [UIImage imageNamed:@"tu"];
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(tempView.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(57, 57));
    }];
    
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [SCColor getColor:@"070c16"];
    _countLabel.font = [Utils fontWithSize:11];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.text = @"0";
    [tempView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.right.mas_equalTo(tempView).offset(-12-19);
        make.size.mas_equalTo(CGSizeMake(30, 19));
    }];
    
    __weak FAFUserInfo * userInfo = [FAFUserInfo sharedInstance];
     
    _addBtn = [UIButton new];
    [_addBtn setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
    _addBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [tempView addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(_countLabel.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_addBtn bk_whenTapped:^{
        
        NSInteger count  = _goodsData.selectedCount;
        if (count < _goodsData.stock) {
            count += 1;
            _countLabel.text = [NSString stringWithFormat:@"%d", count];
            _goodsData.selectedCount = count;
            userInfo.totalAmount += _goodsData.price;
            [userInfo.cartGoodsDict setObject:_goodsData forKey:@(_goodsData.id)];
        }else if (count > _goodsData.stock){
            
            userInfo.totalAmount -= (count-_goodsData.stock)*_goodsData.price;
            
            _goodsData.selectedCount = _goodsData.stock;
            
            _countLabel.text = [NSString stringWithFormat:@"%d", _goodsData.selectedCount];
            
            [userInfo.cartGoodsDict setObject:_goodsData forKey:@(_goodsData.id)];

        }
    }];
    
    _subBtn = [UIButton new];
    [_subBtn setImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
    _subBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [tempView addSubview:_subBtn];
    [_subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.right.mas_equalTo(_countLabel.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_subBtn bk_whenTapped:^{
        
        NSInteger count  = _goodsData.selectedCount;
        if (count > 0) {
            
            count -= 1;
            _countLabel.text = [NSString stringWithFormat:@"%d", count];
            _goodsData.selectedCount = count;
            userInfo.totalAmount -= _goodsData.price;
            [userInfo.cartGoodsDict setObject:_goodsData forKey:@(_goodsData.id)];
        }else{
        
            [userInfo.cartGoodsDict removeObjectForKey:@(_goodsData.id)];
            
        }
    }];
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"333333"];
    _nameLabel.font = [Utils fontWithSize:15];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tempView.mas_centerY);
        make.left.mas_equalTo(_iconView.mas_right).offset(10);
        make.right.mas_equalTo(_countLabel.mas_left).offset(-19);
        make.height.mas_equalTo(20);
    }];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = [SCColor getColor:@"666666"];
    _priceLabel.font = [Utils fontWithSize:12];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    
    [tempView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView.mas_centerY);
        make.left.mas_equalTo(_nameLabel);
        make.right.mas_equalTo(_nameLabel);
        make.height.mas_equalTo(20);
    }];
    
    _seperatorLine = [[UIView alloc]init];
    _seperatorLine.backgroundColor = [SCColor getColor:@"ebebeb"];
    [tempView addSubview:_seperatorLine];
    [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempView.mas_left).offset(10);
        make.right.mas_equalTo(tempView.mas_right).offset(-10);
        make.bottom.mas_equalTo(tempView);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setData:(FAFProductCellData *)data{
    
    if ([data isKindOfClass:[FAFProductCellData class]]) {
        
        FAFUserInfo *userInfo = [FAFUserInfo sharedInstance];
        
        FAFProductCellData *tempData = [userInfo.cartGoodsDict objectForKey:@(data.id)];
        
        if (tempData) {
            
            data.selectedCount = tempData.selectedCount;
            
            [userInfo.cartGoodsDict setObject:data forKey:@(data.id)];
        }
        
        
        _goodsData = data;
        
        _nameLabel.text = data.name;
        
        _priceLabel.text = [NSString stringWithFormat:@"¥%.2f/把", data.price];
        
        
        _countLabel.text = [NSString stringWithFormat:@"%d", data.selectedCount];
        
        
    }
    
}

@end
