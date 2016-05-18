//
//  FAFShopDetailController.m
//  FindAFitting
//
//  Created by SC on 16/5/12.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFShopDetailController.h"

#define FAF_SD_HEADER_HEIGHT  105
#define FAF_SD_SB_HEIGHT      50

#define FAF_SD_SCROLL_OFFSET_HEIGHT      FAF_SD_HEADER_HEIGHT
#define FAF_SD_BOTTOM_HEIGHT  57

@interface FAFShopDetailController ()<UIScrollViewDelegate,ConditionDoubleTableViewDelegate,JKSearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    __block NSMutableArray<FAFProductCellData*> *_searchTableViewDataArray;
}

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIView *headerView;

@property (nonatomic, strong)UIImageView *iconView;

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *desLabel;

@property (nonatomic, strong)FAFSearchBar *searchBar;

@property (nonatomic, strong)UIImageView *bottomView;

@property (nonatomic, strong)UILabel     *amountHeaderLabel;

@property (nonatomic, strong)UILabel     *amountLabel;

@property (nonatomic, strong)UIImageView *cartView;

@property (nonatomic, strong)UIButton    *payBtn;

@property (nonatomic, strong)ConditionDoubleTableView *doubleTableVC;

@property (nonatomic, strong)FAFShopCellData *shopDetailInfo;

@property (nonatomic, strong) UITableView      *searchTableView;

@property (nonatomic, strong) UIButton         *inputAccessoryButton;

@end

@implementation FAFShopDetailController

- (instancetype)initWithShopInfo:(FAFShopCellData *)shopInfo{
    
    if (self = [super init]) {
        
        _shopInfo = shopInfo;
        
    }
 
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = _shopInfo.name;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!_searchTableView.isHidden) {
        
        CGPoint contentOffset = _scrollView.contentOffset;
        contentOffset.y = FAF_SD_HEADER_HEIGHT;
        
        [_scrollView setContentOffset:contentOffset animated:NO];
        
    }
    
}

- (void)setupSubviews{
    
    [self setupScrollView];
    
    [self setupHeaderView];
    
    [self setupSearchView];
    
    [self setupDoubleTableVC];
    
    [self setupSearchTableView];
    
    [self setupBottomView];
    
    [self requsetProductCategoryList];
    
}

- (void)setupScrollView {
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    frame.size.height = ScreenHeight - 64;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.scrollsToTop = YES;
    
    scrollView.scrollEnabled = NO;
//    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-64+FAF_SD_SCROLL_OFFSET_HEIGHT);
//    scrollView.otherGestureRecognizerSimultaneously = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupHeaderView{
    
    CGRect tempFrame = CGRectZero;
    tempFrame.size.width  = ScreenWidth;
    tempFrame.size.height = FAF_SD_HEADER_HEIGHT;
    
    _headerView = [[UIView alloc]init];
    [self.scrollView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_scrollView);
        make.height.mas_equalTo(FAF_SD_HEADER_HEIGHT);
    }];
    
    UIView *tempView = _headerView;
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_shopInfo.imageUrl] placeholderImage:[UIImage imageNamed:@"tupian"]];
    [tempView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tempView);
        make.left.mas_equalTo(tempView.mas_left).offset(17);
        make.size.mas_equalTo(CGSizeMake(88, 88));
    }];
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [SCColor getColor:@"333333"];
    _nameLabel.font = [Utils fontWithSize:17];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.text = _shopInfo.name;
    [tempView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView.mas_top).offset(15);
        make.left.mas_equalTo(_iconView.mas_right).offset(17);
        make.right.mas_equalTo(tempView.mas_right).offset(-17);
        make.height.mas_equalTo(20);
    }];
    
    _desLabel = [[UILabel alloc]init];
    _desLabel.textColor = [SCColor getColor:@"666666"];
    _desLabel.font = [Utils fontWithSize:10];
    _desLabel.textAlignment = NSTextAlignmentLeft;
    _desLabel.numberOfLines = 3;
    _desLabel.text = _shopInfo.descs;
    [tempView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.left.mas_equalTo(_nameLabel);
        make.right.mas_equalTo(_nameLabel);
        make.bottom.mas_equalTo(_iconView.mas_bottom);
    }];
    
    
}

- (void)setupSearchView{
    
    _searchBar = [[FAFSearchBar alloc]initWithFrame:CGRectMake(0, FAF_SD_HEADER_HEIGHT, ScreenWidth, FAF_SD_SB_HEIGHT)];
    
    _searchBar.searchBar.placeholder = NSLocalizedString(@"请输入商品名称", nil);
    
    _searchBar.searchBar.placeholderColor = [SCColor getColor:@"999999"];
    
    _searchBar.searchBar.backgroundColor = [SCColor getColor:@"eeeeee"];
    
    _searchBar.searchBar.tfBorderColor = [UIColor clearColor];
    
    _searchBar.searchBar.delegate = self;
    
    _searchBar.searchBar.cancelButtonDisabled = NO;
    
    [self.scrollView addSubview:_searchBar];
    
}

- (void)setupDoubleTableVC{

    
    _doubleTableVC = [[ConditionDoubleTableView alloc] initWithFrame:CGRectMake(0, FAF_SD_SCROLL_OFFSET_HEIGHT+FAF_SD_SB_HEIGHT, ScreenWidth, ScreenHeight - 64 - FAF_SD_SB_HEIGHT-FAF_SD_BOTTOM_HEIGHT)];
    
    _doubleTableVC.conditionDoubleTableViewType = CDTableViewTypeCustom;
    
    _doubleTableVC.isReachBottom = YES;
    
    _doubleTableVC.maxHeight = ScreenHeight - 64 ;
    
    _doubleTableVC.widthRatio = 87.0/ScreenWidth;
    
    _doubleTableVC.cellClass1 = [FAFProductCategoryCell class];
    
    _doubleTableVC.cellClass2 = [FAFProductCell class];
    
    _doubleTableVC.cellDataClass1 = [FAFProductCategoryCellData class];
    
    _doubleTableVC.cellDataClass2 = [FAFProductCellData class];
    
    _doubleTableVC.cellHeight1 = 45;
    
    _doubleTableVC.cellHeight2 = 74;
    
    _doubleTableVC.leftArray = [NSMutableArray new];
    
    _doubleTableVC.rightItems = [NSMutableArray new];
    
    _doubleTableVC.firstTableView.backgroundColor = [UIColor whiteColor];
    
    _doubleTableVC.delegate = self;
    
    _doubleTableVC.firstTableView.backgroundColor = [SCColor getColor:@"f5f5f5"];
    
    _doubleTableVC.secondTableView.backgroundColor = [SCColor getColor:@"f5f5f5"];

    
    [self.scrollView addSubview:_doubleTableVC.view];
    
}

- (void)setupSearchTableView{
    
    _searchTableViewDataArray = [NSMutableArray new];
    
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FAF_SD_SB_HEIGHT, ScreenWidth, ScreenHeight - FAF_SD_SB_HEIGHT - 64 - FAF_SD_BOTTOM_HEIGHT) style:UITableViewStylePlain];
    
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

- (void)setupBottomView{
    
    UIView *tempView = self.view;
    
    _bottomView = [UIImageView new];
    _bottomView.image = [UIImage imageNamed:@"dibu"];
    _bottomView.userInteractionEnabled = YES;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tempView.mas_bottom);
        make.left.mas_equalTo(tempView);
        make.right.mas_equalTo(tempView);
        make.height.mas_equalTo(FAF_SD_BOTTOM_HEIGHT);
    }];
    
    _cartView = [UIImageView new];
    _cartView.image = [UIImage imageNamed:@"购物车"];
    _cartView.userInteractionEnabled = YES;
    [_bottomView addSubview:_cartView];
    [_cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bottomView).offset(17);
        make.centerY.mas_equalTo(_bottomView);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    [_cartView bk_whenTapped:^{
        ;
    }];
    
    
    _payBtn = [UIButton new];
    [_payBtn setBackgroundImage:[UIImage imageNamed:@"dianji"] forState:UIControlStateNormal];
    [_payBtn setTitleColor:[SCColor getColor:@"ffffff"] forState:UIControlStateNormal];
    _payBtn.titleLabel.font = [Utils fontWithSize:17];
    [_payBtn setTitle:@"结算" forState:UIControlStateNormal];
    [_bottomView addSubview:_payBtn];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_bottomView);
        make.right.mas_equalTo(_bottomView);
        make.height.mas_equalTo(FAF_SD_BOTTOM_HEIGHT-4);
        make.width.mas_equalTo(117);
    }];
    [_payBtn bk_whenTapped:^{
        ;
    }];
    
    _amountLabel = [UILabel new];
    _amountLabel.textColor = [SCColor getColor:@"ff1a1a"];
    _amountLabel.font = [Utils fontWithSize:17];
    _amountLabel.text = @"0.00";
    [_bottomView addSubview:_amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_bottomView);
        make.right.mas_equalTo(_payBtn.mas_left).offset(-20);
        make.height.mas_equalTo(_bottomView);
        make.width.mas_lessThanOrEqualTo(ScreenWidth - 117*2);
    }];
    
    _amountHeaderLabel = [UILabel new];
    _amountHeaderLabel.textColor = [SCColor getColor:@"ff1a1a"];
    _amountHeaderLabel.font = [Utils fontWithSize:15];
    _amountHeaderLabel.text = @"合计:¥";
    [_bottomView addSubview:_amountHeaderLabel];
    [_amountHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_bottomView);
        make.right.mas_equalTo(_amountLabel.mas_left);
        make.width.mas_equalTo(50);
    }];
    
    [_amountLabel.observer observe:[FAFUserInfo sharedInstance] keyPath:@"totalAmount" blockForNew:^(UILabel * observer, id  _Nonnull object, NSNumber* change) {
        observer.text = [NSString stringWithFormat:@"%.2f", change.floatValue];
    }];
    
    [self.view bringSubviewToFront:_bottomView];
    
}

- (void)requsetShopDetailInfo{
    
    DEFINE_WEAK(self);
    
    [SCHttpTool postWithURL:FAF_SHOP_INFO_URL params:@{@"shopId": @(_shopInfo.id)} success:^(NSDictionary *json) {
        
        wself.shopDetailInfo = [[FAFShopCellData alloc]initWithDictionary:json[@"data"]];
        
    } failure:nil];
    
}

- (void)requsetProductCategoryList{
    
    DEFINE_WEAK(self);
    
    [SCHttpTool postWithURL:FAF_GET_GOODS_CATEGORY_URL params:@{@"shoperId": @(_shopInfo.id)} success:^(NSDictionary *json) {

        
        if ([Utils isValidArray:json[@"data"]]) {
            wself.doubleTableVC.leftArray = [_doubleTableVC mappingItems:json[@"data"] dataClass:[FAFProductCategoryCellData class]];
            wself.doubleTableVC.rightItems = [[NSMutableArray alloc]initWithCapacity:wself.doubleTableVC.leftArray.count];
        }
        
        
        if (wself.doubleTableVC.leftArray.count > 0) {
            
            dispatch_main_async_safe(^{
            
                [wself.doubleTableVC.firstTableView reloadData];
                
                [wself.doubleTableVC.firstTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                
            });
            
            [wself requestGoodsListByIndex:0];
        }
        
    } failure:nil];
    
}

- (void)requestGoodsListByIndex:(NSInteger)index{
    
    if (index < _doubleTableVC.leftArray.count) {
        
        long categoryId = [[self.doubleTableVC.leftArray[index] valueForKeyPath:@"id"] longValue];
        NSDictionary *params = @{@"shopId" : @(_shopInfo.id),
                                 @"catalogId" : @(categoryId)};
        
        DEFINE_WEAK(self);
        [SCHttpTool postWithURL:FAF_GET_GOODS_LIST_URL params:params success:^(NSDictionary *json) {
            
            
            dispatch_main_async_safe(^{
            
                NSMutableArray *goodsList = [NSMutableArray new];
                
                if ([Utils isValidArray:json[@"data"]]) {
                    
                    [goodsList addObjectsFromArray:json[@"data"]];
                }
                
                [wself.doubleTableVC.rightItems setObject:goodsList atIndexedSubscript:index];
                
                [wself.doubleTableVC mappingRightArrayByIndex:index];
                
                [wself.doubleTableVC.secondTableView reloadData];
                
            });
            
        } failure:nil];
    }
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 74;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([tableView isEqual:_searchTableView] && indexPath.row < _searchTableViewDataArray.count) {
        

        [FAFGoodsViewController pushViewControllerWithData:_searchTableViewDataArray[indexPath.row] fromViewController:self];
        
        
    }
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _searchTableViewDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
        static NSString *identifier = @"FAFProductCell";
        
        FAFProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[FAFProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if (indexPath.row < _searchTableViewDataArray.count) {
            
            [cell setData:_searchTableViewDataArray[indexPath.row]];
            
        }
        
        return cell;
    
}

#pragma mark - JKSearchBarDelegate

- (void)searchBarCancelButtonClicked:(JKSearchBar *)searchBar{
    
    [_inputAccessoryButton setHidden:YES];
    
    [_searchTableView setHidden:YES];
    
    _searchTableView.backgroundColor = [UIColor clearColor];
    
    [_searchTableViewDataArray removeAllObjects];
    
}

-(BOOL)searchBarShouldBeginEditing:(JKSearchBar *)searchBar{
    
    CGPoint contentOffset = _scrollView.contentOffset;
    
    contentOffset.y = FAF_SD_HEADER_HEIGHT;
    
    [_scrollView setContentOffset:contentOffset animated:NO];
    
    [_searchTableView setHidden:NO];
    
    [_inputAccessoryButton setHidden:NO];
    
    [_searchTableView reloadData];
    
    return YES;
    
}

- (void)searchBarTextDidBeginEditing:(JKSearchBar *)searchBar{
    
    [_headerView resignFirstResponder];
    
}

- (void)searchBar:(JKSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (![_searchTableView.backgroundColor isEqual:[UIColor whiteColor]]) {
        
        _searchTableView.backgroundColor = [UIColor whiteColor];
        
    }
    
    DEFINE_WEAK(self);
    
    NSDictionary *params = @{@"shopId" : @(_shopInfo.id),
                             @"name" : [NSString stringWithFormat:@"%@", searchText]};
    
    [SCHttpTool postWithURL:FAF_GET_GOODS_LIST_URL params:params success:^(NSDictionary *json) {
        
        NSMutableArray *goodsList = [NSMutableArray new];
        
        if ([Utils isValidArray:json[@"data"]]) {
            
            [goodsList addObjectsFromArray:json[@"data"]];
        }
        
        _searchTableViewDataArray = [wself.doubleTableVC mappingItems:goodsList dataClass:[FAFProductCellData class]];
        
        [wself.searchTableView reloadData];
        
    } failure:nil];
    
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_scrollView]) {
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_scrollView]) {
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_scrollView]) {
        
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (![scrollView isEqual:_scrollView]) {
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (![scrollView isEqual:_scrollView]) {
        
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (![scrollView isEqual:_scrollView]) {
        
    }
}


#pragma mark - ConditionDoubleTableViewDelegate


- (void)selectedLeftViewAtIndexPath:(NSIndexPath *)indexPath{
    
    [self requestGoodsListByIndex:indexPath.row];
    
    [_doubleTableVC mappingRightArrayByIndex:indexPath.row];
    
    [_doubleTableVC.secondTableView reloadData];
}

- (void)deselectedLeftViewAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)selectedRightViewAtIndexPath:(NSIndexPath *)indexPathRight leftViewIndexPath:(NSIndexPath *)indexPathLeft{
    
    if (indexPathRight.row < _doubleTableVC.rightArray.count) {
        
        
        [FAFGoodsViewController pushViewControllerWithData:_doubleTableVC.rightArray[indexPathRight.row] fromViewController:self];
        
        
    }
    
}

- (void)leftTableView:(UITableView *)tableView didScrollToOffset:(CGFloat)offset{
    
    
    if (offset > 0) {
        
        CGFloat talbeViewOffsetY = tableView.contentSize.height - tableView.frame.size.height;
        
        talbeViewOffsetY = talbeViewOffsetY < 0 ? 0 : talbeViewOffsetY;
        
        if (offset > talbeViewOffsetY) {
            
            if (_scrollView.contentOffset.y < FAF_SD_SCROLL_OFFSET_HEIGHT){
                
                CGPoint contentOffset = _scrollView.contentOffset;
                contentOffset.y += offset - talbeViewOffsetY;
                contentOffset.y = MIN(FAF_SD_SCROLL_OFFSET_HEIGHT, contentOffset.y);
                _scrollView.contentOffset = contentOffset;
                
                contentOffset = tableView.contentOffset;
                
                contentOffset.y = talbeViewOffsetY;
                
                tableView.contentOffset = contentOffset;
                
            }
            
        }else if (_scrollView.contentOffset.y < 0){
            
            CGPoint contentOffset = _scrollView.contentOffset;
            contentOffset.y += offset;
            contentOffset.y = MIN(FAF_SD_SCROLL_OFFSET_HEIGHT, contentOffset.y);
            _scrollView.contentOffset = contentOffset;
            
            contentOffset = tableView.contentOffset;
            
            contentOffset.y = 0;
            
            tableView.contentOffset = contentOffset;
            
        }
        
    }else if (offset < 0){
        
        if (tableView.contentOffset.y < 0){
            
            CGPoint contentOffset = _scrollView.contentOffset;
            CGFloat maxOffsetY = -50.0;
            
            CGFloat coefficient = contentOffset.y > maxOffsetY ? 1 : (1 - (contentOffset.y - maxOffsetY)/maxOffsetY);
            
            contentOffset.y += offset * coefficient;
            
            _scrollView.contentOffset = contentOffset;
            
            contentOffset = tableView.contentOffset;
            
            contentOffset.y = 0;
            
            tableView.contentOffset = contentOffset;
            
        }
        
    }
    
}

- (void)rightTableView:(UITableView *)tableView didScrollToOffset:(CGFloat)offset{
    
    if (offset > 0) {
        
        if (_scrollView.contentOffset.y < FAF_SD_SCROLL_OFFSET_HEIGHT){
            
            CGPoint contentOffset = _scrollView.contentOffset;
            contentOffset.y += offset;
            contentOffset.y = MIN(FAF_SD_SCROLL_OFFSET_HEIGHT, contentOffset.y);
            _scrollView.contentOffset = contentOffset;
            
            contentOffset = tableView.contentOffset;
            
            contentOffset.y = 0;
            
            tableView.contentOffset = contentOffset;
            
        }
        
    }else if (offset < 0){
        
        if (tableView.contentOffset.y < 0){
            
            CGPoint contentOffset = _scrollView.contentOffset;
            
            CGFloat maxOffsetY = -50.0;
            
            CGFloat coefficient = contentOffset.y > maxOffsetY ? 1 : (1 - (contentOffset.y - maxOffsetY)/maxOffsetY);
            
            contentOffset.y += offset * coefficient;

            _scrollView.contentOffset = contentOffset;
            
            contentOffset = tableView.contentOffset;
            
            contentOffset.y = 0;
            
            tableView.contentOffset = contentOffset;
            
        }

    }
    
}

- (void)leftTableViewDidEndDragging:(UITableView *)tableView willDecelerate:(BOOL)decelerate{
    
    if (_scrollView.contentOffset.y < 0){
        
        CGPoint contentOffset = _scrollView.contentOffset;
        contentOffset.y = 0;
        
        [_scrollView setContentOffset:contentOffset animated:YES];
        
    }
    
}

- (void)rightTableViewDidEndDragging:(UITableView *)tableView willDecelerate:(BOOL)decelerate{
    
    if (_scrollView.contentOffset.y < 0){
        
        CGPoint contentOffset = _scrollView.contentOffset;
        contentOffset.y = 0;

        [_scrollView setContentOffset:contentOffset animated:YES];
        
    }
    
}

- (void)leftTableViewDidScrollToTop:(UITableView *)tableView{
    
}

- (void)rightTableViewDidScrollToTop:(UITableView *)tableView{
    
}

@end
