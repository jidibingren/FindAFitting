//
//  FAFShopViewController.h
//  FindAFitting
//
//  Created by SC on 16/5/7.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"
#import "FAFFilterCategoryData.h"
#import "FAFFilterCategoryCell.h"
#import "FAFFilterSortData.h"
#import "FAFFilterSortCell.h"
#import "FAFFilterDistanceData.h"
#import "FAFFilterDistanceCell.h"
#import "FAFGoodsViewController.h"



@interface FAFShopViewController : SCTableViewController

@property (nonatomic, strong)NSString *filterValue;

@property (nonatomic, strong)NSString *filterName;

+ (FAFShopViewController *)shopViewControllerWith:(NSString*)title url:(NSString *)url category:(NSString *)category;

@end
