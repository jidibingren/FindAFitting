//
//  FAFProductCell.h
//  FindAFitting
//
//  Created by SC on 16/5/14.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

@interface FAFProductCell : CDTableViewCell

@property (nonatomic, strong)UIImageView *iconView;

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *priceLabel;

@property (nonatomic, strong)UIButton *addBtn;

@property (nonatomic, strong)UIButton *subBtn;

@property (nonatomic, strong)UILabel  *countLabel;

@property (nonatomic, strong)UIView   *seperatorLine;

@property (nonatomic, strong)FAFProductCellData *goodsData;

@end
