//
//  FAFProductCategoryCell.m
//  FindAFitting
//
//  Created by SC on 16/5/14.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFProductCategoryCell.h"

@implementation FAFProductCategoryCell


- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    UIView *backgroundView = [UIView new];
    
    
    
    backgroundView.backgroundColor = [SCColor getColor:@"ffffff"];
    
    self.selectedBackgroundView = backgroundView;
    
    UIImageView *selectedImageView = [[UIImageView alloc]init];
    
    selectedImageView.contentMode = UIViewContentModeScaleToFill;
    
    selectedImageView.image = [UIImage imageNamed:@"tiaokuang"];
    
    [backgroundView addSubview:selectedImageView];
    
    [selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backgroundView);
        make.bottom.mas_equalTo(backgroundView);
        make.left.mas_equalTo(backgroundView);
        make.width.mas_equalTo(2.5);
    }];
    
    self.backgroundColor = [SCColor getColor:@"f5f5f5"];
    
    
    UIView *tempView = self.contentView;
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"666666"];
    _nameLabel.highlightedTextColor = [SCColor getColor:@"ff3939"];
    _nameLabel.font = [Utils fontWithSize:12];
    _nameLabel.textAlignment = NSTextAlignmentLeft;

    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView.mas_top);
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.bottom.mas_equalTo(tempView);
    }];
    
}

- (void)setData:(FAFProductCategoryCellData *)data{
    
    if ([data isKindOfClass:[FAFProductCategoryCellData class]]) {
        
        _categoryData = data;
        
        _nameLabel.text = data.name;
        
    }
    
}

@end
