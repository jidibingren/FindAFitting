//
//  FAFLocationViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/9.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFLocationViewController.h"

#define FAF_LOCATION_MAP_VIEW_HEIGHT (ScreenWidth*(488/750.0))

@interface FAFLocationViewController ()<JKSearchBarDelegate,BMKMapViewDelegate,FAFNearbySearchDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    BMKMapView   *_mapView;
    CLLocationCoordinate2D coordinate;
    FAFUserInfo  *_userInfo;
    BOOL         isPtChanged;
    
    __block NSMutableArray<FAFAddress*> *_searchTableViewDataArray;
}

@property (nonatomic, strong) FAFSearchBar     *headView;
@property (nonatomic, strong) UITableView      *searchTableView;
@property (nonatomic, strong) UIButton         *inputAccessoryButton;

@end

@implementation FAFLocationViewController


- (void)viewDidLoad{
    
    _userInfo = [FAFUserInfo sharedInstance];
    
    [self setupPageControllerBefore];
    
    [super viewDidLoad];
    
    [self setupPageControllerAfter];
    
    [self setupSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
    
}

#pragma mark - Notifications
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat newHeight = ScreenHeight - 64 - kbRect.size.height;
    
    
//    if (!_headView.searchBar.inputAccessoryView) {
//        
//        UIButton *inputAccessoryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, newHeight)];
//        
//        inputAccessoryView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
//        
//        inputAccessoryView.alpha = 0.5;
//        
//        [inputAccessoryView bk_whenTapped:^{
//            
//            [[UIApplication sharedApplication].keyWindow endEditing:YES];
//            
//        }];
//        
//        _headView.searchBar.inputAccessoryView = inputAccessoryView;
//        
//        
//    }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < _searchTableViewDataArray.count) {
        
        _userInfo.curAddress = _searchTableViewDataArray[indexPath.row];
        
        [_searchTableViewDataArray removeAllObjects];
        
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _searchTableViewDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"FAFNearbyAddressCell1";
    
    FAFNearbyAddressCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FAFNearbyAddressCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row < _searchTableViewDataArray.count) {

        [cell setData:_searchTableViewDataArray[indexPath.row]];
    
    }
    
    return cell;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_searchTableView]) {
    
        [super scrollViewDidScroll:scrollView];
    
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_searchTableView]) {
    
        [super scrollViewWillBeginDragging:scrollView];
    
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_searchTableView]) {
    
        [super scrollViewDidEndDecelerating:scrollView];
    
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_searchTableView]) {
    
        [super scrollViewDidEndScrollingAnimation:scrollView];
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (![scrollView isEqual:_searchTableView]) {
        
        [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (![scrollView isEqual:_searchTableView]) {
        [super scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

#pragma mark - JKSearchBarDelegate

- (void)searchBarCancelButtonClicked:(JKSearchBar *)searchBar{
    
    [_inputAccessoryButton setHidden:YES];
    
    [_searchTableView setHidden:YES];
    
    _searchTableView.backgroundColor = [UIColor clearColor];
    
    [_searchTableViewDataArray removeAllObjects];
    
}

-(BOOL)searchBarShouldBeginEditing:(JKSearchBar *)searchBar{
    
    [_searchTableView setHidden:NO];
    
    [_inputAccessoryButton setHidden:NO];
    
    [_searchTableView reloadData];
    
    return YES;
    
}

- (void)searchBarTextDidBeginEditing:(JKSearchBar *)searchBar{
    [_headView resignFirstResponder];
}

- (void)searchBar:(JKSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (![_searchTableView.backgroundColor isEqual:[UIColor whiteColor]]) {
        
        _searchTableView.backgroundColor = [UIColor whiteColor];
        
    }
    
    DEFINE_WEAK(self);
    
    [[FAFPOISearchUtil sharedInstance] nearbySearchByKeyword:searchText location:coordinate callback:^(BOOL isSuccessed, NSMutableArray *addressArray, id additionalInfo) {
        
        if  (isSuccessed){
            
            _searchTableViewDataArray = addressArray;
            
            [wself.searchTableView reloadData];
            
        }
    }];
    
}

- (UIViewController *)initializeViewControllerAtIndex:(NSInteger)index {
    
    FAFNearbySearchViewController *viewController = [FAFNearbySearchViewController new];
    
    viewController.delegate = self;
    
    switch (index) {
        case 0:
            
            viewController.dataArray = _userInfo.nearbyAddressArray;
            
            break;
            
        case 1:
            
            viewController.dataArray = _userInfo.nearbyOfficesArray;
            
            break;
            
        case 2:
            
            viewController.dataArray = _userInfo.nearbyAreaArray;
            
            break;
            
        case 3:
            
            viewController.dataArray = _userInfo.nearbySchoolArray;
            
            break;
            
        default:
            
            break;
    }
    
    return viewController;
}

#pragma mark - WMPageControllerDelegate

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
        
        [self searchByIndex: [info[@"index"] integerValue]];

}

#pragma mark - FAFNearbySearchDelegate

- (void)didSelectAddress:(FAFAddress *)address{
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi{
    
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    
}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate{
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    NSString *AnnotationViewID = [NSString stringWithFormat:@"renameMark%d",1];
    
    BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
    // 设置可拖拽
    ((BMKPinAnnotationView*)newAnnotation).draggable = YES;
    //设置大头针图标
    ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"dingwei"];
    return newAnnotation;
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    coordinate = mapView.centerCoordinate;
    
    [self searchByIndex:self.selectIndex];
}

#pragma mark - private methods

- (void)setupPageControllerBefore{
        self.viewFrame = CGRectMake(0, FAF_LOCATION_MAP_VIEW_HEIGHT, ScreenWidth, ScreenHeight - 64 - FAF_LOCATION_MAP_VIEW_HEIGHT);
    
    self.titles = @[@"全部", @"写字楼", @"小区", @"学校"];
    self.viewControllerClasses = @[[FAFNearbySearchViewController class], [FAFNearbySearchViewController class], [FAFNearbySearchViewController class], [FAFNearbySearchViewController class]];
    // 下划线
    self.menuItemWidth = ScreenWidth/4;
    self.postNotification = YES;
    self.bounces = YES;
    self.title = @"Line";
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = 15;
    self.titleColorSelected = [SCColor getColor:@"53abfd"];
    self.titleColorNormal = [SCColor getColor:@"666666"];
    self.titleSizeSelected = 17;
    self.titleSizeNormal = 17;
    self.menuHeight = 45;
    self.menuBGColor = [SCColor getColor:@"ffffff"];
//    self.menuViewBottom = 0.5;
    self.progressHeight = 1;
    
    self.delegate = self;
}

- (void)setupPageControllerAfter{
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.menuHeight-0.5, ScreenWidth, 0.5)];
    
    bottomLine.backgroundColor = [SCColor getColor:@"ebebeb"];
    
    [self.menuView addSubview:bottomLine];
    
}

- (void)setupSubviews{
    
//    [super setupSubviews];
    
    [self setupNavigationBar];
    
    [self setupMapView];
    
    [self setupPoiSearch];
    
    [self setupSearchTableView];
}

- (void)setupNavigationBar{
    
    DEFINE_WEAK(self);

    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"返回icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [wself performSelector:@selector(onBackButtonPressed)];
    }];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    _headView = [[FAFSearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 45, FAFHSB_HEIGHT)];
    
    _headView.searchBar.placeholder = NSLocalizedString(@"小区、写字楼、学校等", nil);
    
    _headView.searchBar.placeholderColor = [SCColor getColor:@"090909"];
    
    _headView.searchBar.delegate = self;
    
    
    [self.navigationItem setTitleView:_headView];
}

- (void)onBackButtonPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupMapView{
    
    coordinate = [SCLocationAdapter sharedInstance].baiduLocation;
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    frame.size.height = FAF_LOCATION_MAP_VIEW_HEIGHT;
    _mapView = [[BMKMapView alloc] initWithFrame:frame];
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.delegate = self;
    _mapView.zoomLevel = 17.0;
    [self.view addSubview:_mapView];
    
    // 定位
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coor = [SCLocationAdapter sharedInstance].baiduLocation;
    
    annotation.coordinate = coor;
    annotation.title = @"test";
    
    [_mapView addAnnotation:annotation];
    [_mapView setCenterCoordinate:coor animated:NO];
}

- (void)setupSearchTableView{
    
    _searchTableViewDataArray = [NSMutableArray new];
    
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    
    _searchTableView.backgroundColor = [UIColor clearColor];
    
    _searchTableView.delegate = self;
    
    _searchTableView.dataSource = self;
    
    _searchTableView.scrollEnabled = YES;
    
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_searchTableView];
    
    [_searchTableView setHidden:YES];
    
    
    _inputAccessoryButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    _inputAccessoryButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    _inputAccessoryButton.alpha = 0.5;
    
    DEFINE_WEAK(self);
    
    [_inputAccessoryButton bk_whenTapped:^{
        
        [_inputAccessoryButton setHidden:YES];
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
    }];
    
    [self.view addSubview:_inputAccessoryButton];
    
    [_inputAccessoryButton setHidden:YES];
}

- (void)setupPoiSearch{
    
}

- (void)searchByIndex:(NSInteger )index{
    
    NSArray *keywords = @[@"写字楼", @"小区", @"学校"];
    
    if (index == 0) {
        
        for (int i = 0; i < keywords.count; i++) {
            
            [self searchWithKeyword:keywords[i] index:i+1];
            
        }
        
    }else{
    
        [self searchWithKeyword:keywords[index-1] index:index];
        
    }
}

- (void)searchWithKeyword:(NSString *)keyword index:(NSInteger)index{
    
    [[FAFPOISearchUtil sharedInstance] nearbySearchByKeyword:keyword location:coordinate additionalInfo:[NSNumber numberWithInteger:index] callback:^(BOOL isSuccessed, NSMutableArray *addressArray, NSNumber* index) {
        if (isSuccessed) {
            
            switch (index.integerValue) {
                case 1:
                    _userInfo.nearbyOfficesArray = addressArray;
                    break;
                case 2:
                    _userInfo.nearbyAreaArray = addressArray;
                    break;
                case 3:
                    _userInfo.nearbySchoolArray = addressArray;
                    break;
                    
                default:
                    
                    break;
            }
            FAFNearbySearchViewController *curVC = (FAFNearbySearchViewController*)[self performSelector:@selector(displayVC)][@(index.integerValue)];
            
            curVC.dataArray = addressArray;
                
            ((FAFNearbySearchViewController*)[self performSelector:@selector(displayVC)][@(0)]).dataArray = _userInfo.nearbyAddressArray;
            [((FAFNearbySearchViewController*)[self performSelector:@selector(displayVC)][@(0)]).tableView reloadData];
            
            
            [curVC.tableView reloadData];
        }
    }];
}

+ (void)nearbySearch{
    
    [self nearbySearchWith:nil];
    
}

+ (void)nearbySearchWith:(FAFPOISearchBlock)callback{
    
    NSArray *keywords = @[@"写字楼", @"小区", @"学校"];
    
    
    
    for (int i = 0; i < keywords.count; i++) {
        FAFUserInfo *uesrInfo = [FAFUserInfo sharedInstance];
        [[FAFPOISearchUtil sharedInstance] nearbySearchByKeyword:keywords[i] location:uesrInfo.curAddress.pt additionalInfo:[NSNumber numberWithInteger:i+1] callback:^(BOOL isSuccessed, NSMutableArray *addressArray, NSNumber* index) {
            if (isSuccessed) {
                
                switch (index.integerValue) {
                    case 1:
                        uesrInfo.nearbyOfficesArray = addressArray;
                        break;
                    case 2:
                        uesrInfo.nearbyAreaArray = addressArray;
                        break;
                    case 3:
                        uesrInfo.nearbySchoolArray = addressArray;
                        break;
                        
                    default:
                        
                        break;
                }
                
                if (index.integerValue == 3 && callback){
                    
                    callback(YES, addressArray, index);
                    
                }
            }
        }];
        
    }
}

@end
