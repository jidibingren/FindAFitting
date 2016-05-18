//
//  FAFHomeViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/4.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFHomeViewController.h"


@interface FAFHomeViewController ()<UITableViewDelegate,UITableViewDataSource,JKSearchBarDelegate>

@property (nonatomic) BOOL dataRequestedOnce;

@property (nonatomic, strong)UILabel *addressLabel;

@property (nonatomic, strong) FAFHomeSearchBar *headView;

@end

@implementation FAFHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    if (scrollView.contentOffset.y < 0) {
        if (self.headView.isHidden) {
            [self.headView setHidden:NO];
            [[self.tableView headerViewForSection:0] setHidden:YES];
            
        }
    }else if (scrollView.contentOffset.y > 0){
        if (!self.headView.isHidden) {
            [[self.tableView headerViewForSection:0] setHidden:NO];
            [self.headView setHidden:YES];
        }
    }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3 && indexPath.row < self.dataArray[3].count) {
        
        [self.navigationController pushViewController:[[FAFShopDetailController alloc] initWithShopInfo:self.dataArray[3][indexPath.row]] animated:YES];
        
    }
    
}

#pragma mark - UITableViewDataSource

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [super tableView:tableView viewForHeaderInSection:section];
    
    if (section == 0 && !self.headView.isHidden) {
        
        [headerView setHidden:YES];
        
    }
    
    return headerView;
}

#pragma mark - private methods

- (void) customizeTableView {
    self.cellClassArray = @[
                            [FAFHomeHeadlineCell class],
                            [FAFHomeCategoryCell class],
                            [FAFHomeHotCell class],
                            [FAFShopCell class]
                            ];
    self.headerClassArray = @[[FAFHomeSearchBar class],
                              [SCTableViewHeaderFooterView class],
                              [SCTableViewHeaderFooterView class],
                              [FAFHomeNearbyHeadView class]];
    self.cellDataClassArray = @[[FAFHomeHeadlineData class],
                                [SCTableViewCellData class],
                                [SCTableViewCellData class],
                                [FAFShopCellData class]];
    self.cellHeightArray = @[@(ScreenWidth*(245/750.0)),
                             @(ScreenWidth*(440/750.0)),
                             @(ScreenWidth*(346/750.0)),
                             @(FAF_SHOP_CELL_HEIGHT)];
    self.headerHeightArray = @[@(FAFHSB_HEIGHT),
                               @(0.001),
                               @(0.001),
                               @(FAFHDD_HEIGHT)];
    NSArray *dataArray = @[@[[FAFHomeHeadlineData new]],
                           @[[SCTableViewCellData new]],
                           @[[SCTableViewCellData new]],
                           [NSMutableArray new]];
    self.dataArray = [[NSMutableArray alloc]initWithArray:dataArray];
    self.url = FAF_GET_SHOP_LIST_URL;
    self.listPath = @"data";
    self.dontAutoLoad = YES;
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = -FAFHSB_HEIGHT;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupSubviews{
    [super setupSubviews];
    [self setupNavigationBar];
    [self setupHeadView];
    [self.tableView reloadData];
    [self requestADInfo];
}

- (void)setupHeadView{

    _headView = [[FAFHomeSearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, FAFHSB_HEIGHT)];
    [self.view addSubview:_headView];
    [_headView setHidden:YES];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(FAFHSB_HEIGHT, 0, 0, 0);
}

- (void)setupNavigationBar{
    
    [self.observer observe:[FAFUserInfo sharedInstance] keyPath:@"curAddress" blockForNew:^(FAFHomeViewController *observer, id  _Nonnull object, FAFAddress *change) {
        observer.addressLabel.text = [Utils isValidStr:change.name] ? change.name : @"请选择地址";
        [observer.tableView.mj_header beginRefreshing];
    }];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [self.navigationItem setTitleView:button];
    DEFINE_WEAK(self);
    [button bk_whenTapped:^{
        [wself.navigationController presentViewController:[FAFAddressViewController addressViewController] animated:YES completion:nil];
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [FAFUserInfo sharedInstance].curAddress.name ? : @"请选择地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [Utils fontWithSize:17];
    [button addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(button);
        make.height.mas_equalTo(button);
        make.width.mas_lessThanOrEqualTo(ScreenWidth-20-(12+10)*2);
    }];
    _addressLabel = titleLabel;
    
    UIImageView *leftImageView = [[UIImageView alloc]init];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    leftImageView.image = [UIImage imageNamed:@"location"];
    [button addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-10);
        make.top.equalTo(titleLabel);
        make.height.mas_equalTo(titleLabel);
        make.width.mas_equalTo(12);
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc]init];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    rightImageView.image = [UIImage imageNamed:@"locationxiala"];
    [button addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.top.equalTo(titleLabel);
        make.height.mas_equalTo(titleLabel);
        make.width.mas_equalTo(12);
    }];
}

- (void)requestADInfo{
    [SCHttpTool postWithURL:FAF_GET_AD_LIST_URL params:nil success:^(NSDictionary *json) {
        NSMutableArray *tempDataArray = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray * array = [json valueForKeyPath: @"data"];
        FAFHomeHeadlineData* data = [[FAFHomeHeadlineData alloc] init];
        data.dataArray = array;
        [tempDataArray addObject:data];

        [self.dataArray replaceObjectAtIndex:0 withObject:tempDataArray];
        [self.tableView reloadData];
    } failure:nil];
}

@end
