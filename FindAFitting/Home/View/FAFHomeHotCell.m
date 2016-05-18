//
//  FAFHomeHotCell.m
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFHomeHotCell.h"

@interface FAFHomeHotItemCell1 : SCCollectionViewCell
@property (nonatomic, strong)UIImageView *iconView;
@end

@implementation FAFHomeHotItemCell1

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
    UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:tempFrame];
    backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    backgroundImageView.image = [UIImage imageNamed:@"daohangbeijing"];
    [self setBackgroundView:backgroundImageView];
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView).offset(30);
        make.height.mas_equalTo(self.contentView).offset(-30);
    }];
}

@end


@interface FAFHomeHotItemCell2 : SCCollectionViewCell
@property (nonatomic, strong)UIImageView *iconView;
@end

@implementation FAFHomeHotItemCell2

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
    
    UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:tempFrame];
    backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    backgroundImageView.image = [UIImage imageNamed:@"daohangbeijing"];
    [self setBackgroundView:backgroundImageView];
    
    _iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconView];
    [self.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

@end

@interface FAFHomeHotCell ()<UICollectionViewDataSource,FAFCollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSArray<NSString*>* iconArray;
@property (nonatomic, strong)NSArray<Class>* classArray;
@property (nonatomic, strong)NSArray<NSString*>* urlArray;
@property (nonatomic, strong)NSArray<NSString*>* titleArray;

@end

@implementation FAFHomeHotCell

- (void)setupSubviewsWithFrame:(CGRect)frame{
    _iconArray   = @[@"pifaremai", @"xindiantehui", @"xindiankaiye", @"pinpaiguan", @"tuijianyoujiang"];
    _titleArray  = @[@"批发热卖", @"新店特惠", @"新店开业", @"品牌馆", @"推荐有奖"];
    _classArray  = @[[FAFShopViewController class],
                     [SCBaseViewController class],
                     [FAFShopViewController class],
                     [SCBaseViewController class],
                     [SCBaseViewController class],];
    
    _urlArray = @[FAF_GET_WHOLESALE_LIST_URL,
                  @"",
                  FAF_GET_NEW_OPEN_URL,
                  @"",
                  @"",];
    
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    FAFCollectionViewFlowLayout *layout = [[FAFCollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.delegate = self;
//    layout.itemSize = CGSizeMake(ScreenWidth/4, ScreenWidth/4);
    
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
    [_collectionView registerClass:[FAFHomeHotItemCell1 class] forCellWithReuseIdentifier:NSStringFromClass([FAFHomeHotItemCell1 class])];
    [_collectionView registerClass:[FAFHomeHotItemCell2 class] forCellWithReuseIdentifier:NSStringFromClass([FAFHomeHotItemCell2 class])];
    
    _collectionView.backgroundColor = [SCColor getColor:@"dcdcdc"];
    
    self.contentView.backgroundColor = [SCColor getColor:@"eeeeee"];
}

- (void)setData:(SCTableViewCellData *)data{
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _iconArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = indexPath.row == 0 ? NSStringFromClass([FAFHomeHotItemCell1 class]) : NSStringFromClass([FAFHomeHotItemCell2 class]);
    FAFHomeHotItemCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.iconView.image  = [UIImage imageNamed:_iconArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout offsetForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row == 3 ? ScreenWidth*(300/750.0)+1 : 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return indexPath.row == 0 ? CGSizeMake(ScreenWidth*(300/750.0), ScreenWidth*(328/750.0)) : CGSizeMake(ScreenWidth*(222/750.0), ScreenWidth*(162/750.0));
    return indexPath.row == 0 ? CGSizeMake(ScreenWidth*(300/750.0), ScreenWidth*(328/750.0)) : CGSizeMake((ScreenWidth-ScreenWidth*(300/750.0)-3)/2, ScreenWidth*(162/750.0));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < _classArray.count) {
        Class class = _classArray[indexPath.row];
        SCBaseViewController *viewController = nil;
        if ([class respondsToSelector:@selector(shopViewControllerWith:url:category:)]) {
            viewController = [class shopViewControllerWith:_titleArray[indexPath.row] url:_urlArray[indexPath.row] category:nil];
            [(FAFShopViewController *)viewController setFilterName:@"category"];
        }else{
            viewController = [class new];
        }
        [self.viewController.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Methods to Override

@end
