//
//  FAFFilterView.m
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFFilterView.h"

NSDictionary *urlsDict;
NSDictionary *cellClasssDict;
NSDictionary *cellDataClasssDict;
NSArray *sortIds;
NSArray *distanceIds;

@interface FAFFilterView ()

@property (nonatomic, strong)NSArray *titlesArray;

@end

@implementation FAFFilterView

+ (NSString *)urlByCategoryId:(NSString *)categroyId{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        urlsDict = @{@"wjgj" : FAF_SHOP_LIST_BY_TYPE_URL,
                     @"bzj"  : FAF_SHOP_LIST_BY_TYPE_URL,
                     @"jgc"  : @"",//
                     @"zgc"  : @"",//
                     @"wjjc" : FAF_SHOP_LIST_BY_TYPE_URL,
                     @"bxg"  : @"",//
                     @"fphs" : @"",//
                     @"zggr" : FAF_GET_WORKER_LIST_URL};
    });
    
    return [Utils isValidStr:categroyId] && [Utils isValidStr:urlsDict[categroyId]] ? urlsDict[categroyId] : FAF_SHOP_LIST_BY_TYPE_URL;
    
}

+ (Class)cellClassByCategoryId:(NSString *)categroyId{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cellClasssDict = @{@"wjgj" : [FAFShopCell class],
                           @"bzj"  : [FAFShopCell class],
                           @"jgc"  : @"",//
                           @"zgc"  : @"",//
                           @"wjjc" : [FAFShopCell class],
                           @"bxg"  : @"",//
                           @"fphs" : @"",//
                           @"zggr" : [FAFWorkerCell class]};
    });
    
    return [Utils isValidStr:categroyId] && [Utils isNonnull:cellClasssDict[categroyId]] && [cellClasssDict[categroyId] isKindOfClass:[SCTableViewCell class]] ? cellClasssDict[categroyId] : [FAFShopCell class];
    
}

+ (Class)cellDataClassByCategoryId:(NSString *)categroyId{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cellDataClasssDict = @{@"wjgj" : [FAFShopCellData class],
                               @"bzj"  : [FAFShopCellData class],
                               @"jgc"  : @"",//
                               @"zgc"  : @"",//
                               @"wjjc" : [FAFShopCellData class],
                               @"bxg"  : @"",//
                               @"fphs" : @"",//
                               @"zggr" : [FAFWorkerCellData class]};
    });
    
    return [Utils isValidStr:categroyId] && [Utils isNonnull:cellDataClasssDict[categroyId]] && [cellDataClasssDict[categroyId] isKindOfClass:[SCTableViewCellData class]] ? cellDataClasssDict[categroyId] : [FAFShopCellData class];
    
}


+ (NSString *)sortIdByIndex:(NSInteger)index{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sortIds = @[@"znpx", @"jlzj", @"xlzg", @"pfzg"];;
    });
    
    return index < sortIds.count && index >= 0 ? sortIds[index] : @"";
    
}

+ (NSString *)distanceIdByIndex:(NSInteger)index{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        distanceIds = @[@"all", @"wbm", @"sqm", @"wqm", @"sqm", @"esqm"];;
    });
    
    return index < distanceIds.count && index >= 0 ? distanceIds[index] : @"";
    
}

+ (DropdownMenu *)dropdownMenuWithFrame:(CGRect)frame {
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    tempFrame.size.width  = ScreenWidth;
    tempFrame.size.height = FAFHDD_HEIGHT;
    
    NSArray *titlesArray = @[@"分类", @"排序", @"附近"];
    
    NSArray *categorys = [FAFUserInfo sharedInstance].filterCategoryDataArray;
    NSArray *sorts = @[@[@{@"name":@"智能排序", @"icon":@"order_icon_intelligent"},
                       @{@"name":@"距离最近", @"icon":@"order_icon_distances"},
                       @{@"name":@"销量最高", @"icon":@"order_icon_sales"},
                       @{@"name":@"评分最高", @"icon":@"order_icon_rated"},]];
    
    NSArray *distances = @[@[@{@"title":@"全城"},
                           @{@"title":@"500m"},
                           @{@"title":@"3km"},
                           @{@"title":@"5km"},
                           @{@"title":@"10km"},
                           @{@"title":@"20km"},]];
    
    NSMutableArray *menuLists = [NSMutableArray arrayWithObjects:categorys, sorts, distances, nil];
//    NSArray *menuLists = @[@[@[@"全城", @"500m", @"3km", @"5Km", @"10km", @"20km"]],
//                           @[@[@"五金工具", @"标准件", @"加工厂", @"找个车", @"五金建材", @"不锈钢", @"废品回收", @"找个工人"]],
//                           @[@[@"智能排序", @"距离最近", @"销量最高", @"评分最高"]]];
    
    DropdownMenu *dropdownMenu = [[DropdownMenu alloc]initDropdownMenuWithFrame:tempFrame Menutitles:titlesArray MenuLists:menuLists];
    dropdownMenu.normalImage   = @"xiala";
    dropdownMenu.selectedImage = @"xialatubiao";
    dropdownMenu.selectedTitleColor = [SCColor getColor:@"287cca"];
    dropdownMenu.separatorLineHeight = 35;
    dropdownMenu.separatorLineWidth = 0.5;
    dropdownMenu.separatorLineColor = [SCColor getColor:@"ebebeb"];
    dropdownMenu.cellHeight1Array = @[@(40),@(40),@(40),@(40),];
    dropdownMenu.cellHeight2Array = @[@(45),@(45),@(45),@(40),];
    dropdownMenu.cellClass2Array  = @[[FAFFilterCategoryCell class],
                                      [FAFFilterSortCell class],
                                      [FAFFilterDistanceCell class]];
    dropdownMenu.cellDataClass2Array = @[[FAFFilterCategoryData class],
                                         [FAFFilterSortData class],
                                         [FAFFilterDistanceData class]];
    dropdownMenu.contentTypesArray = @[@(DDContentDefault),@(DDContentDefault),@(DDContentDefault),@(DDContentDefault),];

    
    return dropdownMenu;
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    _dropdownMenu = [FAFFilterView dropdownMenuWithFrame:frame];
    [self.contentView addSubview:_dropdownMenu.view];
    UIView *seperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    seperatorLine.backgroundColor = [SCColor getColor:@"ebebeb"];
    [self.contentView addSubview:seperatorLine];
    
    _dropdownMenu.delegate = self.viewController;
}
@end
