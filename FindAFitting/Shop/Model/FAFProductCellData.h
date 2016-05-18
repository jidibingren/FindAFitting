//
//  FAFProductCellData.h
//  FindAFitting
//
//  Created by SC on 16/5/14.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

@interface FAFProductCellData : SCTableViewCellData

@property (nonatomic        )long          id;
@property (nonatomic, strong)NSString     *name;
@property (nonatomic, strong)NSString     *catalogName;
@property (nonatomic, strong)NSString     *descs;
@property (nonatomic,       )CGFloat       price;
@property (nonatomic,       )CGFloat       orginalPrice;
@property (nonatomic,       )NSInteger     stock;
@property (nonatomic, strong)NSString     *imageUrl;
@property (nonatomic,       )long          shoperId;
@property (nonatomic, strong)NSString     *shoper;
@property (nonatomic,       )NSInteger     selectedCount;

@end
