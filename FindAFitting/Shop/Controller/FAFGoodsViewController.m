//
//  FAFGoodsViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/16.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFGoodsViewController.h"

@interface FAFGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIView *bottomView;

@property (nonatomic, strong)UIImageView *titleImageView;

@property (nonatomic,       )CGRect  cachedImageViewSize;

@end

@implementation FAFGoodsViewController

+ (void)pushViewControllerWithData:(FAFProductCellData *)data fromViewController:(UIViewController*)viewController{
    
    FAFGoodsViewController *goodVC = [FAFGoodsViewController new];
    
    goodVC.data = data;
    
    [viewController.navigationController pushViewController:goodVC animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self resetNavigation];
    
}

- (void)setupSubviews{
    
    [super setupSubviews];
    
    [self setupNavigation];
    
    [self setupTableView];
    
    [self setupBottomView];
    
    [self requestGoodsDetail];
    
}

- (void)setupNavigation{
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    DEFINE_WEAK(self)
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    leftImageView.image = [UIImage imageNamed:@"goog_icon_back"];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftImageView];
    
    leftImageView.userInteractionEnabled = YES;
    
    [leftImageView bk_whenTapped:^{
        
        [wself.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIImageView *right1ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    right1ImageView.image = [UIImage imageNamed:@"good_icon_more"];
    
    UIBarButtonItem *right1Item = [[UIBarButtonItem alloc]initWithCustomView:right1ImageView];
    
    right1ImageView.userInteractionEnabled = YES;
    
    [right1ImageView bk_whenTapped:^{
        
    }];
    
    UIImageView *right2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    right2ImageView.image = [UIImage imageNamed:@"good_icon_car"];
    
    UIBarButtonItem *right2Item = [[UIBarButtonItem alloc]initWithCustomView:right2ImageView];
    
    right2ImageView.userInteractionEnabled = YES;
    
    [right2ImageView bk_whenTapped:^{
        
    }];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItems = @[right1Item, right2Item];;
}

- (void)resetNavigation{
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    UIColor* bgColor = [SCColor getColor:SC_COLOR_NAV_BG];
    UIColor* textColor = [SCColor getColor:SC_COLOR_NAV_TEXT];
    //navigationBar background
    if (iOS7) {
        self.navigationController.navigationBar.barTintColor = bgColor;
        // textColor
        self.navigationController.navigationBar.tintColor = textColor;
    } else {
        self.navigationController.navigationBar.tintColor = bgColor;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topdaohangbeijing"] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    
}

- (void)setupTableView{
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    CGRect frame = self.view.frame;
    
    frame.origin = CGPointZero;
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 375)];
    
    self.cachedImageViewSize = self.titleImageView.frame;
    self.titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:_data.imageUrl]];
    [self.tableView addSubview:self.titleImageView];
    self.titleImageView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:self.cachedImageViewSize];
}

- (void)setupBottomView{
    
    
    
    UIView *tempView = self.view;
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [SCColor getColor:@"dddddd"];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tempView.mas_bottom);
        make.left.mas_equalTo(tempView);
        make.right.mas_equalTo(tempView);
        make.height.mas_equalTo(49);
    }];
    
    NSDictionary *selectedAttr = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:11],
                                    NSForegroundColorAttributeName: [SCColor getColor:@"287cca"],
                                    };
    NSDictionary *unselectedAttr = @{
                                      NSFontAttributeName: [UIFont systemFontOfSize:11],
                                      NSForegroundColorAttributeName: [SCColor getColor:@"7f7f7f"],
                                      };
    
    UIOffset titleOffset = UIOffsetMake(0, 3);
    
    RDVTabBarItem *service = [RDVTabBarItem new];
    service.backgroundColor = [UIColor whiteColor];
    [service setFinishedSelectedImage:[UIImage imageNamed:@"goog_icon_wang"] withFinishedUnselectedImage:[UIImage imageNamed:@"goog_icon_wang"]];
    service.title = NSLocalizedString(@"客服", nil);
    service.titlePositionAdjustment = titleOffset;
    service.selectedTitleAttributes = selectedAttr;
    service.unselectedTitleAttributes = unselectedAttr;
    [_bottomView addSubview:service];
    [service mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bottomView.mas_top).offset(1);
        make.left.mas_equalTo(_bottomView);
        make.width.mas_equalTo(50);
        make.bottom.mas_equalTo(_bottomView.mas_bottom);
    }];
    
    [service bk_whenTapped:^{
        ;
    }];
    
    
    RDVTabBarItem *shop = [RDVTabBarItem new];
    shop.backgroundColor = [UIColor whiteColor];
    [shop setFinishedSelectedImage:[UIImage imageNamed:@"goog_icon_shop"] withFinishedUnselectedImage:[UIImage imageNamed:@"goog_icon_shop"]];
    shop.title = NSLocalizedString(@"店铺", nil);
    shop.titlePositionAdjustment = titleOffset;
    shop.selectedTitleAttributes = selectedAttr;
    shop.unselectedTitleAttributes = unselectedAttr;
    [_bottomView addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bottomView.mas_top).offset(1);
        make.left.mas_equalTo(service.mas_right).offset(0.5);
        make.width.mas_equalTo(50);
        make.bottom.mas_equalTo(_bottomView.mas_bottom);
    }];
    
    [shop bk_whenTapped:^{
        ;
    }];
    
    
    RDVTabBarItem *collect = [RDVTabBarItem new];
    collect.backgroundColor = [UIColor whiteColor];
    [collect setFinishedSelectedImage:[UIImage imageNamed:@"goog_icon_collect"] withFinishedUnselectedImage:[UIImage imageNamed:@"goog_icon_collect"]];
    collect.title = NSLocalizedString(@"收藏", nil);
    collect.titlePositionAdjustment = titleOffset;
    collect.selectedTitleAttributes = selectedAttr;
    collect.unselectedTitleAttributes = unselectedAttr;
    [_bottomView addSubview:collect];
    [collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bottomView.mas_top).offset(1);
        make.left.mas_equalTo(shop.mas_right).offset(0.5);
        make.width.mas_equalTo(50);
        make.bottom.mas_equalTo(_bottomView.mas_bottom);
    }];
    
    [collect bk_whenTapped:^{
        ;
    }];
    
    selectedAttr = @{
                     NSFontAttributeName: [UIFont systemFontOfSize:15],
                     NSForegroundColorAttributeName: [SCColor getColor:@"ffffff"],
                     };
    unselectedAttr = @{
                       NSFontAttributeName: [UIFont systemFontOfSize:15],
                       NSForegroundColorAttributeName: [SCColor getColor:@"ffffff"],
                       };
    titleOffset = UIOffsetZero;
    
    RDVTabBarItem *cart = [RDVTabBarItem new];
    cart.backgroundColor = [SCColor getColor:@"ff9402"];
    cart.title = NSLocalizedString(@"加入购物车", nil);
    cart.titlePositionAdjustment = titleOffset;
    cart.selectedTitleAttributes = selectedAttr;
    cart.unselectedTitleAttributes = unselectedAttr;
    [_bottomView addSubview:cart];
    [cart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bottomView.mas_top).offset(1);
        make.left.mas_equalTo(collect.mas_right);
        make.width.mas_equalTo((ScreenWidth-50*3-1)/2);
        make.bottom.mas_equalTo(_bottomView.mas_bottom);
    }];
    
    [cart bk_whenTapped:^{
        ;
    }];
    
    RDVTabBarItem *pay = [RDVTabBarItem new];
    pay.backgroundColor = [SCColor getColor:@"ff5000"];
    pay.title = NSLocalizedString(@"立即购买", nil);
    pay.titlePositionAdjustment = titleOffset;
    pay.selectedTitleAttributes = selectedAttr;
    pay.unselectedTitleAttributes = unselectedAttr;
    [_bottomView addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bottomView.mas_top).offset(1);
        make.left.mas_equalTo(cart.mas_right);
        make.right.mas_equalTo(_bottomView.mas_right);
        make.bottom.mas_equalTo(_bottomView.mas_bottom);
    }];
    
    [pay bk_whenTapped:^{
        ;
    }];
    
    [self.view bringSubviewToFront:_bottomView];
    
}

- (void)requestGoodsDetail{
    
    NSDictionary *params = @{@"id":@(_data.id),
                             @"shopId": @(_data.shoperId)};
    DEFINE_WEAK(self);
    
    [SCHttpTool postWithURL:FAF_GET_GOODS_DETAIL_URL params:params success:^(NSDictionary *json) {
        
        wself.data = json;
        
    } failure:nil];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FAFGoodsTitleCell *cell = [FAFGoodsTitleCell new];
    
    cell.nameLabel.text = _data.name;
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f",_data.price];
    
    
    
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2f",_data.price]];
    
    
    [aAttributedString addAttribute:NSForegroundColorAttributeName
                              value:[SCColor getColor:@"999999"]
                              range:NSMakeRange(0, aAttributedString.length)];
    
    [aAttributedString addAttribute:NSFontAttributeName
                              value:[Utils fontWithSize:15]
                              range:NSMakeRange(0, aAttributedString.length)];
    
    [aAttributedString addAttribute:NSStrikethroughStyleAttributeName
                              value:[NSNumber numberWithUnsignedInteger:1]
                              range:NSMakeRange(0, aAttributedString.length)];
    
    cell.orginalPriceLabel.attributedText = aAttributedString;
    
    return cell;
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollOffset = -scrollView.contentOffset.y;
    CGFloat newScale = 1 + scrollOffset / self.cachedImageViewSize.size.height;
    
    if (scrollOffset > 0) {
        self.titleImageView.frame = CGRectMake(self.view.bounds.origin.x,
                                               scrollView.contentOffset.y,
                                               self.cachedImageViewSize.size.width+scrollOffset,
                                               self.cachedImageViewSize.size.height+scrollOffset);
        
        self.titleImageView.center = CGPointMake(self.tableView.center.x, self.titleImageView.center.y);
    }
    
}

@end
