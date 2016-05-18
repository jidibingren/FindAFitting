//
//  FAFFilterDistanceCell.m
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFFilterDistanceCell.h"

@implementation FAFFilterDistanceCell

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
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"5e5e5e"];
    _nameLabel.font = [Utils fontWithSize:17];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
    }];
}

- (void)setData:(FAFFilterDistanceData *)data{
    if (data && [data isKindOfClass:[FAFFilterDistanceData class]]) {
        _nameLabel.text = [Utils isValidStr:data.title] ? data.title : @"";
    }
}
@end
