
//
//  FAFHomeSearchBar.m
//  FindAFitting
//
//  Created by SC on 16/5/5.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFHomeSearchBar.h"

@implementation FAFHomeSearchBar

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
    tempFrame.size.height = FAFHSB_HEIGHT;
    _searchBar = [[JKSearchBar alloc]initWithFrame:tempFrame];
    _searchBar.backgroundImage = [UIImage imageNamed:@"topdaohangbeijing"];
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.cancelButtonDisabled = YES;
    _searchBar.iconAlign = JKSearchBarIconAlignCenter;
    _searchBar.placeholder = NSLocalizedString(@"请输入商家或商品名称", nil);
    _searchBar.placeholderColor = [SCColor getColor:@"090909"];
    _searchBar.textFont = [Utils fontWithSize:12];
    [self.contentView addSubview:_searchBar];
    _searchBar.delegate = self;
}

#pragma mark - 

-(BOOL)searchBarShouldBeginEditing:(JKSearchBar *)searchBar{
    [self.viewController.navigationController pushViewController:[SCBaseViewController new] animated:YES];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(JKSearchBar *)searchBar{
    [_searchBar resignFirstResponder];
}

@end

@implementation FAFSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubviewsWithFrame:(CGRect)frame{
    CGRect tempFrame = frame;
    tempFrame.origin = CGPointZero;
    _searchBar = [[JKSearchBar alloc]initWithFrame:tempFrame];
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.iconAlign = JKSearchBarIconAlignCenter;
    _searchBar.placeholder = NSLocalizedString(@"请输入商家或商品名称", nil);
    _searchBar.placeholderColor = [SCColor getColor:@"090909"];
    _searchBar.textFont = [Utils fontWithSize:12];
    [self addSubview:_searchBar];
    _searchBar.delegate = self;
}

#pragma mark -

-(BOOL)searchBarShouldBeginEditing:(JKSearchBar *)searchBar{
    [self.viewController.navigationController pushViewController:[SCBaseViewController new] animated:YES];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(JKSearchBar *)searchBar{
    [_searchBar resignFirstResponder];
}

@end
