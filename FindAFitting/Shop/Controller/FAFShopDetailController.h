//
//  FAFShopDetailController.h
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCBaseViewController.h"
#import "FAFProductCellData.h"
#import "FAFProductCategoryCellData.h"
#import "FAFProductCell.h"
#import "FAFProductCategoryCell.h"


@interface FAFShopDetailController : SCBaseViewController

@property (nonatomic, strong) FAFShopCellData *shopInfo;

- (instancetype)initWithShopInfo:(FAFShopCellData *)shopInfo;

@end
