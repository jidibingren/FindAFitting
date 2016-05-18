//
//  FAFAddressBaseCell.h
//  FindAFitting
//
//  Created by SC on 16/5/8.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

#define FAF_ADDRESS_BASE_HEIGHT 44

@interface FAFCurrentAddressCell : SCTableViewCell

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UIButton    *relocationBtn;

@end

@interface FAFNearbyAddressCell1 : SCTableViewCell

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UIButton    *relocationBtn;

@end

@interface FAFNearbyAddressCell2 : SCTableViewCell

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UIButton    *relocationBtn;

@end
