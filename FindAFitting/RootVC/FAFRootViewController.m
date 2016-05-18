//
//  FAFRootViewController.m
//  IHaveACar
//
//  Created by SC on 16/5/5.
//  Copyright (c) 2016年 SC. All rights reserved.
//

#import "FAFRootViewController.h"

@interface FAFRootViewController()
{
    __block BOOL _isRequesting;
}
@property(assign, atomic) BOOL isRequesting;
@end
@implementation FAFRootViewController

- (instancetype)init{
    if (self = [super init]) {
        FAFHomeViewController  *home = [FAFHomeViewController new];
        UINavigationController *homeNavi = [[UINavigationController alloc]initWithRootViewController:home];
        
        FAFOrderViewController *order = [FAFOrderViewController new];
        UINavigationController *orderNavi = [[UINavigationController alloc]initWithRootViewController:order];
        FAFFindViewController *find = [FAFFindViewController new];
        UINavigationController *findNavi = [[UINavigationController alloc]initWithRootViewController:find];

        FAFMineViewController *mine = [FAFMineViewController new];
        UINavigationController *mineNavi = [[UINavigationController alloc]initWithRootViewController:mine];
        
        self.viewControllers = @[homeNavi, orderNavi, findNavi, mineNavi];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
        backgroundView.image = [UIImage imageNamed:@"daohangbeijing"];
        backgroundView.contentMode = UIViewContentModeScaleToFill;
        [self.tabBar.backgroundView addSubview:backgroundView];

        UIImage * normalImage = nil;
        UIImage * selectImage = nil;

        UIOffset titleOffset = UIOffsetMake(0, 3);
        
        RDVTabBarItem *item = nil;
        
        NSArray<NSString*> * normalImages   = @[@"icon_home_normal", @"icon_order_normal", @"icon_find_normal", @"icon_me_normal"];
        NSArray<NSString*> * selectedImages = @[@"icon_home_selected", @"icon_order_selected", @"icon_find_selected", @"icon_me_selected"];
        NSArray<NSString*> * titles         = @[@"首页", @"订单", @"发现", @"我的"];
        
        for (int i = 0; i < self.tabBar.items.count; i++) {
            
            normalImage = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:normalImages[i]]) scale:2+72/50.0];
            selectImage = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:selectedImages[i]]) scale:2+72/50.0];
            
            item = self.tabBar.items[i];
            [item setFinishedSelectedImage:selectImage withFinishedUnselectedImage:normalImage];
            item.title = NSLocalizedString(titles[i], nil);
            item.titlePositionAdjustment = titleOffset;
            item.selectedTitleAttributes = @{
                                             NSFontAttributeName: [UIFont systemFontOfSize:11],
                                             NSForegroundColorAttributeName: [SCColor getColor:@"287cca"],
                                             };
            item.unselectedTitleAttributes = @{
                                               NSFontAttributeName: [UIFont systemFontOfSize:11],
                                               NSForegroundColorAttributeName: [SCColor getColor:@"7f7f7f"],
                                               };
        }
        self.delegate = self;
    }
    
    return self;
}

-(BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    UINavigationController *selectedVC = (UINavigationController *)self.selectedViewController;
    if (selectedVC == viewController) {
        id vc = [[selectedVC viewControllers] objectAtIndex:0];
        if ([vc conformsToProtocol:NSProtocolFromString(@"SCRootViewControllerRefresh")]) {
            [vc reloadSelectedViewController];
        }
    }
    return YES;
}

@end
