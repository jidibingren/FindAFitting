//
//  FAFShopCellData.h
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

@interface FAFShopCellData : SCTableViewCellData

@property (nonatomic        )long          id;
@property (nonatomic, strong)NSString     *name;
@property (nonatomic, strong)NSString     *shoper;
@property (nonatomic, strong)NSString     *address;
@property (nonatomic, strong)NSString     *imageUrl;
@property (nonatomic,       )CGFloat       score;
@property (nonatomic, strong)NSString     *descs;
@property (nonatomic, strong)NSArray      *goods;

@end
