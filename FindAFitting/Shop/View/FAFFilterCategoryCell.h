//
//  FAFFilterCategoryCell.h
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

#define FAF_FILTER_CATEGORY_CELL_HEIGHT 45

@interface FAFFilterCategoryCell : CDTableViewCell

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel     *nameLabel;
@property (nonatomic, strong)UIButton    *countBtn;
@property (nonatomic, strong)UIImageView *arrow;

@end
