//
//  FAFPOISearch.m
//  FindAFitting
//
//  Created by SC on 16/5/10.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFPOISearch.h"

@interface FAFPoiSearch : BMKPoiSearch

@property (nonatomic, strong) FAFPOISearchBlock callback;

@property (nonatomic, strong) id additionalInfo;

@end

@implementation FAFPoiSearch

@end

@interface FAFPOISearchUtil ()<BMKPoiSearchDelegate>

@property (nonatomic, strong)NSMutableArray<BMKPoiSearch*>* searcherArray;

@end

@implementation FAFPOISearchUtil

IMPLEMENT_SINGLETON()

-(instancetype) init{
    
    if (self = [super init]) {
        
        self.searcherArray = [NSMutableArray new];
        
    }
    
    return self;
}

- (void)nearbySearchByKeyword:(NSString *)keyword location:(CLLocationCoordinate2D)location callback:(FAFPOISearchBlock)callback{
    
    [self nearbySearchByKeyword:keyword location:location additionalInfo:nil callback:callback];
    
}

- (void)nearbySearchByKeyword:(NSString *)keyword location:(CLLocationCoordinate2D) location additionalInfo:(id)additionalInfo callback:(FAFPOISearchBlock)callback{
    //初始化检索对象
    FAFPoiSearch *poisearch = [[FAFPoiSearch alloc] init];
    
    poisearch.delegate = self;
    
    poisearch.callback = callback;
    
    poisearch.additionalInfo = additionalInfo;
    
    [self.searcherArray addObject:poisearch];
    
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    option.location = location;
    option.sortType = BMK_POI_SORT_BY_DISTANCE;
    option.keyword = keyword;
    option.radius = 2000;
    BOOL flag = [poisearch poiSearchNearBy:option];

    
    if(flag){
        NSLog(@"本地云检索发送成功");
    }else{
        NSLog(@"本地云检索发送失败");
        callback(NO, nil, additionalInfo);
    }
}

- (void)removeSearcherFromArray:(FAFPoiSearch *)searcher{
    
    searcher.callback = nil;
    
    searcher.additionalInfo = nil;
    
    [self.searcherArray removeObject:searcher];
}

#pragma mark - BMKPoiSearchDelegate

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSMutableArray *poiAddressInfoList = [NSMutableArray new];
        for (int i = 0; i < poiResultList.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResultList.poiInfoList objectAtIndex:i];
            FAFAddress *address = [FAFAddress new];
            address.address = poi.address;
            address.pt = poi.pt;
            address.name = poi.name;
            
            if ([Utils isValidStr:address.address] && [Utils isValidStr:address.name])
                [poiAddressInfoList addObject:address];
        }
        
        FAFPoiSearch *poiSearher = (FAFPoiSearch*)searcher;
        if (poiSearher.callback) {
            
            poiSearher.callback(YES, poiAddressInfoList, poiSearher.additionalInfo);
            
            [self removeSearcherFromArray:poiSearher];
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

@end
