//
//  FAFAddressViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/7.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFAddressViewController.h"

@interface FAFAddressViewController ()<UITableViewDataSource,UITableViewDelegate,JKSearchBarDelegate>{
    
    __block NSMutableArray<FAFAddress*> *_searchTableViewDataArray;
}

@property (nonatomic, strong) FAFHomeSearchBar *headView;

@property (nonatomic, strong) FAFUserInfo      *userInfo;
@property (nonatomic, strong) UITableView      *searchTableView;
@property (nonatomic, strong) UIButton         *inputAccessoryButton;

@end

@implementation FAFAddressViewController

+ (UINavigationController *)addressViewController{
    return [[UINavigationController alloc]initWithRootViewController:[FAFAddressViewController new]];
}

- (void)viewDidLoad {
    
    self.disableHeaderRefresh = YES;
    
    self.disableFooterRefresh = YES;
    
    self.dontAutoLoad = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"请选择收货地址", nil);
    
    _userInfo = [FAFUserInfo sharedInstance];
    
    [self.observer observe:_userInfo keyPath:@"curAddress" blockForNew:^(FAFAddressViewController * observer, id object, id change) {
        
        dispatch_main_sync_safe(^{
            
            [observer.tableView reloadData];
            
        });
    }];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_searchTableView]) {
        
        return 44;
        
    }
    
    return indexPath.section != 2 ? 44 : 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_searchTableView]) {
        
        return 0.01;
        
    }
    
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_searchTableView]) {
        
        return [UIView new];
        
    }
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.text = self.headerTitleArray[section];
    
    titleLabel.font = [Utils fontWithSize:15];
    
    titleLabel.textColor = [SCColor getColor:@"666666"];
    
    titleLabel.backgroundColor = [SCColor getColor:@"eeeeee"];
    
    return titleLabel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_searchTableView]) {
        
        if (indexPath.row < _searchTableViewDataArray.count) {
            
            _userInfo.curAddress = _searchTableViewDataArray[indexPath.row];
            
            [_searchTableViewDataArray removeAllObjects];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
    if (indexPath.section == 0){
        
//        _userInfo.curAddress = _userInfo.shippingAddressArray[indexPath.row];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if ( indexPath.section == 1 && indexPath.row < MIN(_userInfo.nearbyAddressArray.count+1, 4) ) {
        
        if (indexPath.row + 1 == MIN(_userInfo.nearbyAddressArray.count+1, 4)) {
            
            [self.navigationController pushViewController:[FAFLocationViewController new] animated:YES];
            
        }else {
            
            _userInfo.curAddress = _userInfo.nearbyAddressArray[indexPath.row];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        
        }
    
    }else if (indexPath.section == 2 && indexPath.row < _userInfo.shippingAddressArray.count){
        
        _userInfo.curAddress = _userInfo.shippingAddressArray[indexPath.row];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_searchTableView]){
        
        return 1;
        
    }
    
    return _userInfo.isLogined ? 3 : 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:_searchTableView]) {
        
        return _searchTableViewDataArray.count;
        
    }
    
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1){
        
        return MIN(_userInfo.nearbyAddressArray.count+1, 4);
        
    }
    
    return _userInfo.shippingAddressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_searchTableView]) {
        
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
    
    SCTableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
    
        cell = [FAFCurrentAddressCell new];
        
        [((FAFCurrentAddressCell*)cell).relocationBtn bk_whenTapped:^{
            __block UIActivityIndicatorView *activityIndicator =
            [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, -5, 20, 20)];
            activityIndicator.backgroundColor = [UIColor whiteColor];
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [((FAFCurrentAddressCell*)cell).iconView addSubview:activityIndicator];
            [activityIndicator startAnimating];
            [FAFLocationViewController nearbySearchWith:^(BOOL isSuccessed, NSMutableArray *addressArray, id additionalInfo) {
                [activityIndicator stopAnimating];
                _userInfo.curAddress = _userInfo.nearbyAddressArray[0];
            }];
        }];
        
        [cell setData:_userInfo.curAddress];
    
    }else if (indexPath.section == 1 && indexPath.row < MIN(_userInfo.nearbyAddressArray.count+1, 4)){
    
        if (indexPath.row + 1 == MIN(_userInfo.nearbyAddressArray.count+1, 4)) {
            
            cell = [FAFNearbyAddressCell2 new];
            
        }else {
            
            cell = [FAFNearbyAddressCell1 new];
            
            [cell setData:_userInfo.nearbyAddressArray[indexPath.row]];
        }
        
    }else if (indexPath.section == 2 && indexPath.row < _userInfo.shippingAddressArray.count){
        
        cell = [FAFShippingAddressCell new];
        
        [cell setData:_userInfo.shippingAddressArray[indexPath.row]];
        
    }
    
    return cell ? : [SCTableViewCell new];
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
    
    [[FAFPOISearchUtil sharedInstance] nearbySearchByKeyword:searchText location:_userInfo.curAddress.pt callback:^(BOOL isSuccessed, NSMutableArray *addressArray, id additionalInfo) {
        
        if  (isSuccessed){
            
            _searchTableViewDataArray = addressArray;
            
            [wself.searchTableView reloadData];
            
        }
    }];
    
}

#pragma mark - private methods

- (void)customizeTableView{
    
    CGRect frame = self.tableView.frame;
    
    frame.origin.y += FAFHSB_HEIGHT;
    
    frame.size.height -= FAFHSB_HEIGHT;
    
    self.customFrame = frame;
    
    self.tableView.backgroundColor = [SCColor getColor:@"eeeeee"];
    
    self.headerTitleArray = @[@"    当前位置",
                              @"    附近地址",
                              @"    收货地址"];
}

- (void)setupSubviews{
    
    [super setupSubviews];
    
    [self setupNavigationBar];
    
    [self setupHeadView];
    
    [self setupSearchTableView];
    
    [self requestNearbyAddress];
    
    [self requestShippingAddress];
    
}

- (void)setupNavigationBar{
    
    DEFINE_WEAK(self);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]bk_initWithImage:[UIImage imageNamed:@"tuichu"] style:UIBarButtonItemStylePlain handler:^(id sender) {
    
        [wself dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setupHeadView{
    
    _headView = [[FAFHomeSearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FAFHSB_HEIGHT)];
    
    _headView.searchBar.placeholder = NSLocalizedString(@"请输入地址", nil);
    
    _headView.searchBar.placeholderColor = [SCColor getColor:@"090909"];
    
    _headView.searchBar.delegate = self;
    
    _headView.searchBar.cancelButtonDisabled = NO;
    
    [self.view addSubview:_headView];

}

- (void)setupSearchTableView{
    
    _searchTableViewDataArray = [NSMutableArray new];
    
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FAFHSB_HEIGHT, ScreenWidth, ScreenHeight - FAFHSB_HEIGHT - 64) style:UITableViewStylePlain];
    
    _searchTableView.backgroundColor = [UIColor clearColor];
    
    _searchTableView.delegate = self;
    
    _searchTableView.dataSource = self;
    
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_searchTableView];
    
    [_searchTableView setHidden:YES];
    
    
    _inputAccessoryButton = [[UIButton alloc]initWithFrame:_searchTableView.frame];
    
    _inputAccessoryButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
//    _inputAccessoryButton.alpha = 0.5;
    
    DEFINE_WEAK(self);
    
    [_inputAccessoryButton bk_whenTapped:^{
        
        [_inputAccessoryButton setHidden:YES];
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
    }];
    
    [self.view addSubview:_inputAccessoryButton];
    
    [_inputAccessoryButton setHidden:YES];
}

- (void)requestNearbyAddress{
    
}


- (void)requestShippingAddress{
    
    DEFINE_WEAK(self);
    
    if (_userInfo.isLogined) {
        
        [SCHttpTool postWithURL:FAF_ADDRESS_LIST_URL params:nil success:^(NSDictionary *json) {
            
            [wself.tableView reloadData];
            
        } failure:nil];
    }
}

@end
