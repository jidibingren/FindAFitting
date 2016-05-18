//
//  FAFHomeViews.m
//  FindAFitting
//
//  Created by SC on 16/5/5.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFHomeHeadlineCell.h"
#import "FAFHomeHeadlineData.h"

#define kSCPostNotificationNameHeadlineDetail [NSString stringWithFormat:@"%@", wself.viewController.navigationController.topViewController]
#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"banner"]
#define BACKGROUND_IMAGE  [UIImage imageNamed:@"banner"]

#define PAGE_CONTROL_HEIGHT  20
#define PAGE_INDICATORTINT_COLOR [UIColor colorWithRed:0xf3/255.0 green:0xf3/255.0 blue:0xf3/255.0 alpha:0.3]
#define CUR_PAGE_INDICATORTINT_COLOR [UIColor colorWithRed:0xf1/255.0 green:0xf1/255.0 blue:0xf1/255.0 alpha:0.6]
//#define PAGE_INDICATORTINT_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"lunbodian"]]


@implementation FAFHomeHeadlineCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    tempFrame.size.width  = ScreenWidth;
    tempFrame.size.height = FAFHHL_HEIGHT;
    self.backgroundView = [[UIImageView alloc] initWithImage:BACKGROUND_IMAGE];
    _cycleScrollView = [[CycleScrollView alloc]initWithFrame:tempFrame animationDuration:6];
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    UIImageView *pageBackView = [[UIImageView alloc]init];
    pageBackView.contentMode = UIViewContentModeScaleToFill;
    pageBackView.image = [UIImage imageNamed:@"qiehuanbeijing"];
    [self.contentView addSubview:pageBackView];
    [pageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(PAGE_CONTROL_HEIGHT);
    }];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:tempFrame];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = PAGE_INDICATORTINT_COLOR;
    _pageControl.currentPageIndicatorTintColor = CUR_PAGE_INDICATORTINT_COLOR;
    [self.contentView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(PAGE_CONTROL_HEIGHT);
    }];
}


- (void)setData:(SCTableViewCellData *)data{
    
    FAFHomeHeadlineData *cellData = (FAFHomeHeadlineData *)data;
    NSMutableArray * viewArray = [NSMutableArray arrayWithCapacity:1];
    _pageControl.numberOfPages = cellData.dataArray.count;
    
    NSUInteger count = [cellData.dataArray count];
    if (count <=0) {
        return;
    }
    NSUInteger tempCount = count >= 3 ? count : (count == 1 ? 3 : 4);
    for (int i = 0; i < tempCount; i++) {
        CGRect tempRect = self.frame;
        tempRect.origin = CGPointZero;
        tempRect.size.width  = ScreenWidth;
        tempRect.size.height = FAFHHL_HEIGHT;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:tempRect];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[cellData.dataArray objectAtIndex:i%count] objectForKey:keyThumbnail]] placeholderImage:PLACEHOLDER_IMAGE];
        [viewArray addObject:imageView];
    }
    
    DEFINE_WEAK(self);
    self.cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        wself.pageControl.currentPage = pageIndex % wself.pageControl.numberOfPages;
        return viewArray[pageIndex];
    };
    
    self.cycleScrollView.totalPagesCount = ^NSInteger(void){
        return viewArray.count;
    };
    
    self.cycleScrollView.TapActionBlock = ^(NSInteger pageIndex){
        pageIndex = pageIndex % cellData.dataArray.count;
        NSString* url = cellData.dataArray[pageIndex][keyDetailPage];
        NSDictionary* additionalInfo = cellData.dataArray[pageIndex][keyAdditionalInfo];
        if (![Utils isNilOrNSNull:additionalInfo]){
            [[NSNotificationCenter defaultCenter]postNotificationName:kSCPostNotificationNameHeadlineDetail object:additionalInfo];
        }else if (![Utils isNilOrNSNull:url] && url.length > 0) {
            if (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"] ) {
                url = [NSString stringWithFormat:@"%@%@", BASEURL, url];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:kSCPostNotificationNameHeadlineDetail object:url];
            return ;
        }
    };
}

@end