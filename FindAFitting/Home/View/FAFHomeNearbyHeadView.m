//
//  FAFHomeNearbyHeadView.m
//  FindAFitting
//
//  Created by SC on 16/5/10.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFHomeNearbyHeadView.h"

@implementation FAFHomeNearbyHeadView

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    
    UIImageView *imageView = [UIImageView new];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.image = [UIImage imageNamed:@"shangjia"];
    
    [self.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(15);
    }];
    
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.textColor = [SCColor getColor:@"212121"];
    
    titleLabel.font = [Utils fontWithSize:13];
    
    titleLabel.text = @"附近商家";
    
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(imageView.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    UIView *separatorLine = [UIView new];
    
    separatorLine.backgroundColor = [SCColor getColor:@"ebebeb"];
    
    [self.contentView addSubview:separatorLine];
    
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.contentView).offset(-0.5);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}
@end
