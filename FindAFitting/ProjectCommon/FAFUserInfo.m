//
//  FAFUserInfo.m
//  FindAFitting
//
//  Created by SC on 16/5/8.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFUserInfo.h"

@implementation FAFUserInfo{
//    NSMutableArray<FAFAddress *> *_nearbyAddressArray;
//    NSMutableArray<FAFAddress *> *_nearbyOfficesArray;
//    NSMutableArray<FAFAddress *> *_nearbyAreaArray;
//    NSMutableArray<FAFAddress *> *_nearbySchoolArray;
}

IMPLEMENT_SINGLETON()

@synthesize nearbyAddressArray;
@synthesize nearbyOfficesArray;
@synthesize nearbyAreaArray;
@synthesize nearbySchoolArray;
@synthesize filterCategoryDataArray;

-(instancetype) init{
    
    if (self = [super init]) {
        
        self.shippingAddressArray = [NSMutableArray new];
        
        nearbyAddressArray   = [NSMutableArray new];
        
        nearbyOfficesArray   = [NSMutableArray new];
        
        nearbyAreaArray      = [NSMutableArray new];
        
        nearbySchoolArray    = [NSMutableArray new];
        
        _cartGoodsDict = [NSMutableDictionary new];
        
        FAFAddress *data = [FAFAddress new];
        data.name = @"都发发的方法发疯";
        data.address = @"都发发的方法发疯";
        data.buyer = @"dfadfasd";
        data.telephone = @"12222222222";
        self.curAddress = data;
        
        [[SCLocationAdapter sharedInstance] getLocationOnceWithCallback:^(NSError *e) {
            self.curAddress.lng = [NSString stringWithFormat:@"%f", [SCLocationAdapter sharedInstance].baiduLocation.longitude];
            self.curAddress.lat = [NSString stringWithFormat:@"%f", [SCLocationAdapter sharedInstance].baiduLocation.latitude];
            self.curAddress.pt = [SCLocationAdapter sharedInstance].baiduLocation;
            [FAFLocationViewController nearbySearch];
        }];
        
        filterCategoryDataArray = @[@[@{@"name":@"五金工具", @"count":@(0)},
                                      @{@"name":@"标准件", @"count":@(0)},
                                      @{@"name":@"加工厂", @"count":@(0)},
                                      @{@"name":@"找个车", @"count":@(0)},
                                      @{@"name":@"五金建材", @"count":@(0)},
                                      @{@"name":@"不锈钢", @"count":@(0)},
                                      @{@"name":@"废品回收", @"count":@(0)},
                                      @{@"name":@"找个工人", @"count":@(0)},]];
    
    }
    
    return self;
}

//- (NSMutableArray<FAFAddress *> *)nearbyAddressArray{
//    
//    @synchronized (self){
//        
//        return nearbyAddressArray;
//        
//    }
//}
//
//- (NSMutableArray<FAFAddress *> *)nearbyOfficesArray{
//    
//    @synchronized (self){
//    
//        return nearbyOfficesArray;
//    
//    }
//}
//
//
//- (NSMutableArray<FAFAddress *> *)nearbyAreaArray{
//    
//    @synchronized (self){
//        
//        return nearbyAreaArray;
//    
//    }
//}
//
//
//- (NSMutableArray<FAFAddress *> *)nearbySchoolArray{
//    
//    @synchronized (self){
//        
//        return nearbySchoolArray;
//        
//    }
//}


- (void)setNearbyOfficesArray:(NSMutableArray<FAFAddress *> *)officesArray{
    
    @synchronized (self){
        
        [nearbyAddressArray removeObjectsInArray:nearbyOfficesArray];
        
        nearbyOfficesArray = officesArray;
        
        [nearbyAddressArray addObjectsFromArray:officesArray];

    }
}

- (void)setNearbyAreaArray:(NSMutableArray<FAFAddress *> *)areaArray{
    
    @synchronized (self){
        
        [nearbyAddressArray removeObjectsInArray:nearbyAreaArray];
        
        nearbyAreaArray = areaArray;
        
        [nearbyAddressArray addObjectsFromArray:areaArray];
    }
    
}

- (void)setNearbySchoolArray:(NSMutableArray<FAFAddress *> *)schoolArray{
    
    @synchronized (self){
        
        [nearbyAddressArray removeObjectsInArray:nearbySchoolArray];
        
        nearbySchoolArray = schoolArray;
        
        [nearbyAddressArray addObjectsFromArray:schoolArray];
    }
    
}

- (void)setFilterCategoryDataArray:(NSMutableArray *)filterCategoryDatas{
    @synchronized (self) {
        
        filterCategoryDataArray = filterCategoryDatas;
        
    }
}

@end
