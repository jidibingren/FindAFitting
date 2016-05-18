//
//  FAFRootViewController.h
//  IHaveACar
//
//  Created by SC on 16/5/5.
//  Copyright (c) 2016年 SC. All rights reserved.
//
@protocol FAFRootViewControllerRefresh

@required

-(void)reloadSelectedViewController;

@optional

@end

@interface FAFRootViewController : RDVTabBarController<RDVTabBarDelegate,RDVTabBarControllerDelegate>
@end
