//
//  FAFProductCategoryCellData.h
//  FindAFitting
//
//  Created by SC on 16/5/14.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

@interface FAFProductCategoryCellData : SCTableViewCellData

@property (nonatomic        )long          id;
@property (nonatomic, strong)NSString     *name;
@property (nonatomic,       )long          shopId;
@property (nonatomic, strong)NSString     *descs;

@end
