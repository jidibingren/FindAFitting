//
//  FAFFilterSortCell.m
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFFilterSortCell.h"

#define FAF_FILTER_SORT_DEFAULTIMAGE [UIImage imageNamed:@"shopdefault1"]

@implementation FAFFilterSortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self  =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviewsWithFrame:self.contentView.frame];
        
    }
    
    return self;
    
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    tempFrame.size.width  = ScreenWidth;
    tempFrame.size.height = FAF_FILTER_CATEGORY_CELL_HEIGHT;
    
    UIView *tempView = self.contentView;
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
//    _iconView.image = FAF_FILTER_SORT_DEFAULTIMAGE;
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"5e5e5e"];
    _nameLabel.font = [Utils fontWithSize:17];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(_iconView.mas_right).offset(12);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
    }];
}

- (void)setData:(FAFFilterSortData *)data{
    if (data && [data isKindOfClass:[FAFFilterSortData class]]) {
        [_iconView setImage:[UIImage imageNamed:data.icon]];
        _nameLabel.text = [Utils isValidStr:data.name] ? data.name : @"";
    }
}

@end
