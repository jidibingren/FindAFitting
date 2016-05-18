//
//  FAFUserInfo.h
//  FindAFitting
//
//  Created by SC on 16/5/8.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FAFAddress;
@class FAFProductCellData;

@interface FAFUserInfo : NSObject

DECLARE_SINGLETON()

@property (atomic, strong) NSString *name;
@property (atomic, strong) NSString *phone;
@property (atomic, strong) FAFAddress *curAddress;
@property (atomic, strong) NSMutableArray<FAFAddress*> *shippingAddressArray;
@property (atomic, strong) NSMutableArray<FAFAddress*> *nearbyAddressArray;
@property (atomic, strong) NSMutableArray<FAFAddress*> *nearbyOfficesArray;
@property (atomic, strong) NSMutableArray<FAFAddress*> *nearbyAreaArray;
@property (atomic, strong) NSMutableArray<FAFAddress*> *nearbySchoolArray;
@property (atomic        ) BOOL      isLogined;
@property (atomic, strong) NSMutableArray              *filterCategoryDataArray;


@property (nonatomic, strong) NSMutableDictionary<NSNumber *, FAFProductCellData *> *cartGoodsDict;
@property (nonatomic,       )CGFloat  totalAmount;

@end
