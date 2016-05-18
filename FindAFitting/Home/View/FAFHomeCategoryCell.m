//
//  FAFHomeCategoryCell.m
//  FindAFitting
//
//  Created by SC on 16/5/5.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFHomeCategoryCell.h"

@interface FAFHomeCategoryItemCell : SCCollectionViewCell
@property (nonatomic, strong)UILabel     *titleLabel;
@property (nonatomic, strong)UIImageView *iconView;
@end

@implementation FAFHomeCategoryItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView).offset(-5);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_lessThanOrEqualTo(tempFrame.size.height-5);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [SCColor getColor:@"4c4c4c"];
    _titleLabel.font = [Utils boldFontWithSize:12];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(_iconView.mas_bottom).offset(0);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
}

@end

@interface FAFHomeCategoryCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong)NSArray<NSString*>* typeArray;
@property (nonatomic, strong)NSArray<NSString*>* titleArray;
@property (nonatomic, strong)NSArray<NSString*>* iconArray;
@property (nonatomic, strong)NSArray<NSString*>* urlArray;
@property (nonatomic, strong)NSArray<Class>* classArray;

@end

@implementation FAFHomeCategoryCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    
    _typeArray  = @[@"wjgj", @"bzj", @"jgc", @"zgc", @"wjjc", @"bxg", @"fphs", @"zggr",];
    
    _titleArray = @[@"五金工具", @"标准件", @"加工厂", @"找个车", @"五金建材", @"不锈钢", @"废品回收", @"找个工人"];
    
    _iconArray  = @[@"wujingongju", @"biaozhunjian", @"jiagongchang", @"zhaogeche", @"wujinjiancai", @"buxiugang", @"feipinhuishou", @"zhaogegongren"];
    
    _urlArray = @[FAF_SHOP_LIST_BY_TYPE_URL,
                  FAF_SHOP_LIST_BY_TYPE_URL,
                  @"",
                  @"",
                  FAF_SHOP_LIST_BY_TYPE_URL,
                  @"",
                  @"",
                  FAF_GET_WORKER_LIST_URL];
    
    _classArray  = @[[FAFShopViewController class], [FAFShopViewController class], [SCBaseViewController class], [SCBaseViewController class], [FAFShopViewController class], [SCBaseViewController class], [SCBaseViewController class], [FAFWorkerViewController class],];
    
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(ScreenWidth/4, ScreenWidth/4);

    _collectionView = [[UICollectionView alloc]initWithFrame:tempFrame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
    [_collectionView registerClass:[FAFHomeCategoryItemCell class] forCellWithReuseIdentifier:NSStringFromClass([FAFHomeCategoryItemCell class])];
    
    UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:tempFrame];
    backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    backgroundImageView.image = [UIImage imageNamed:@"daohangbeijing"];
//    self.backgroundView = backgroundImageView;
    [_collectionView setBackgroundView:backgroundImageView];
    
    self.contentView.backgroundColor = [SCColor getColor:@"eeeeee"];
}

- (void)setData:(SCTableViewCellData *)data{
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titleArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FAFHomeCategoryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FAFHomeCategoryItemCell class]) forIndexPath:indexPath];
    
    cell.iconView.image  = [UIImage imageNamed:_iconArray[indexPath.row]];
    cell.titleLabel.text = _titleArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < _classArray.count) {
        Class class = _classArray[indexPath.row];
        SCBaseViewController *viewController = nil;
        if ([class respondsToSelector:@selector(shopViewControllerWith:url:category:)]) {
            viewController = [class shopViewControllerWith:_titleArray[indexPath.row] url:_urlArray[indexPath.row] category:_typeArray[indexPath.row]];
        }else if ([class respondsToSelector:@selector(workerViewControllerWithType:)]){
            viewController = [class workerViewControllerWithType:1];
        }else{
            viewController = [class new];
        }
        [self.viewController.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
