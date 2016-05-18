//
//  FAFFilterCategoryCell.m
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFFilterCategoryCell.h"

#define FAF_FILTER_CATEGORY_DEFAULTIMAGE [UIImage imageNamed:@""]

@implementation FAFFilterCategoryCell

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
    _iconView.image = FAF_FILTER_CATEGORY_DEFAULTIMAGE;

    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    _arrow = [[UIImageView alloc]init];
    _arrow.contentMode = UIViewContentModeScaleAspectFit;
    _arrow.image = [UIImage imageNamed:@"jiantou"];
    [tempView addSubview:_arrow];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.size.mas_equalTo(CGSizeMake(8, 10));
    }];
    
    _countBtn = [[UIButton alloc]init];
    [_countBtn setTitle:NSLocalizedString(@"0", nil) forState:UIControlStateNormal];
    [_countBtn setTitleColor:[SCColor getColor:@"ffffff"] forState:UIControlStateNormal];
    _countBtn.titleLabel.font = [Utils fontWithSize:13];
    _countBtn.backgroundColor = [SCColor getColor:@"cfcfcf"];
    _countBtn.layer.cornerRadius = 8;
    _countBtn.layer.masksToBounds = YES;
    [tempView addSubview:_countBtn];
    [_countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.right.mas_equalTo(_arrow.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 16));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"5e5e5e"];
    _nameLabel.font = [Utils fontWithSize:17];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(_iconView.mas_right).offset(12);
        make.right.mas_equalTo(_countBtn.mas_left);
    }];
}

- (void)setData:(FAFFilterCategoryData *)data{
    if (data && [data isKindOfClass:[FAFFilterCategoryData class]]) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:data.icon] placeholderImage:FAF_FILTER_CATEGORY_DEFAULTIMAGE];
        _nameLabel.text = [Utils isValidStr:data.name] ? data.name : @"";
        [_countBtn setTitle:[NSString stringWithFormat:@"%ld", data.count] forState:UIControlStateNormal];
    }
}

@end
