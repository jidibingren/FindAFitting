//
//  FAFFilterCategoryData.h
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

@interface FAFFilterCategoryData : CDTableViewCellData

@property (nonatomic        )long          id;
@property (nonatomic, strong)NSString     *name;
@property (nonatomic, strong)NSString     *icon;
@property (nonatomic,       )long          count;
@property (nonatomic, strong)NSString     *descs;

@end
