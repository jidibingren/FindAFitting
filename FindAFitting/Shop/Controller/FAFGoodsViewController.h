//
//  FAFGoodsViewController.h
//  FindAFitting
//
//  Created by SC on 16/5/16.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCBaseViewController.h"
#import "FAFGoodsTitleCell.h"

@interface FAFGoodsViewController : SCBaseViewController

@property (nonatomic, strong)FAFProductCellData *data;


+ (void)pushViewControllerWithData:(FAFProductCellData *)data fromViewController:(UIViewController*)viewController;

@end
