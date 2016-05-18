//
//  FAFShopViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/7.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFShopViewController.h"

@interface FAFShopViewController ()<DropdownMenuDelegate>{
    
    __block FAFUserInfo *_userInfo;
    
    NSInteger _selectedIndex;
    NSString *_selectedCategroyId;
    NSString *_selectedSortId;
    NSString *_selectedDistanceId;
    
}

@property (nonatomic, strong)DropdownMenu *dropdownMenu;

@property (nonatomic, strong)NSString *distance;

@end

@implementation FAFShopViewController

+ (FAFShopViewController *)shopViewControllerWith:(NSString*)title url:(NSString *)url category:(NSString *)category {
    FAFShopViewController *shopVC = [[FAFShopViewController alloc]init];
    shopVC.title = title;
    shopVC.url = url;
    shopVC.listPath = @"data";
    shopVC.filterValue = category;
    shopVC.filterName = @"type";
    shopVC.cellClass = [FAFShopCell class];
    shopVC.cellDataClass = [FAFShopCellData class];
    shopVC.cellHeight = FAF_SHOP_CELL_HEIGHT;
    return shopVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _userInfo = [FAFUserInfo sharedInstance];
    
    _selectedIndex = 0;
    
    _selectedCategroyId = @"";
    
    _selectedSortId     = @"";
    
    _selectedDistanceId = @"";
    
    NSDictionary *param = @{@"lng": @([FAFUserInfo sharedInstance].curAddress.pt.longitude),
                            @"lat": @([FAFUserInfo sharedInstance].curAddress.pt.latitude)};
    
    [SCHttpTool postWithURL:FAF_SHOP_CATEGORY_URL params:param success:^(NSDictionary *json) {

        if ([Utils isValidArray:json[@"data"]]) {
            _userInfo.filterCategoryDataArray = [NSArray arrayWithObject:json[@"data"]];
        }
        
    } failure:nil];
}

- (void)customizeTableView{
    CGRect frame = self.tableView.frame;
    frame.origin.y += FAFHDD_HEIGHT;
    frame.size.height -= FAFHDD_HEIGHT;
    self.tableView.frame = frame;
    self.customFrame = frame;

}

- (void)customizeParams:(NSMutableDictionary *)params newer:(BOOL)newer{
    
    NSMutableDictionary *tempParams = params ? : [NSMutableDictionary new];
    
    if ([Utils isValidStr:_filterName] && [Utils isValidStr:_filterValue]) {
    
        tempParams[_filterName] = _filterValue;
    
    }
    
    if ([Utils isValidStr:_filterName] && [Utils isValidStr:_selectedCategroyId]) {
        
        tempParams[_filterName] = _selectedCategroyId;
        
    }
    
    if ([Utils isValidStr:_selectedSortId]) {
        
        tempParams[@"order"] = _selectedSortId;
        
    }
    
    if ([Utils isValidStr:_selectedDistanceId]) {
        
        tempParams[@"distance"] = _selectedDistanceId;
        
    }
    
}


- (void)onDidFirstLayout{
    
    [self setupDropdownMenu];
    
}

- (void)setupDropdownMenu{
    
    _dropdownMenu = [FAFFilterView dropdownMenuWithFrame:self.view.frame];
    
    [_dropdownMenu.observer observe:_userInfo keyPath:@"filterCategoryDataArray" blockForInitial:^(DropdownMenu*  _Nullable observer, id  _Nonnull object, id  _Nonnull newValue, id  _Nonnull oldValue) {
        NSMutableArray *temp = observer.menuItems;
        [temp setObject:newValue atIndexedSubscript:0];
    }];
    
    _dropdownMenu.delegate = self;
    
    [self.view addSubview:_dropdownMenu.view];
    
}

#pragma mark - 

- (void)dropdownMenuTap:(NSInteger)index{
    
    _selectedIndex = index;
    
}

- (void)dropdownMenuClose{
    
}

- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right{
    
    switch (_selectedIndex) {
        case 0:
            if (right.integerValue < [(NSArray*)(_userInfo.filterCategoryDataArray[0]) count]) {
                _selectedCategroyId = _userInfo.filterCategoryDataArray[0][right.integerValue][@"idsc"];
            }
            self.url           = [FAFFilterView urlByCategoryId:_selectedCategroyId];
            self.cellClass     = [FAFFilterView cellClassByCategoryId:_selectedCategroyId];
            self.cellDataClass = [FAFFilterView cellDataClassByCategoryId:_selectedCategroyId];
            break;
        case 1:
            _selectedSortId     = [FAFFilterView sortIdByIndex:right.integerValue];
            break;
        case 2:
            _selectedDistanceId = [FAFFilterView distanceIdByIndex:right.integerValue];
            break;
            
        default:
            break;
    }
    
    [self.tableView.mj_header beginRefreshing];
}

@end
