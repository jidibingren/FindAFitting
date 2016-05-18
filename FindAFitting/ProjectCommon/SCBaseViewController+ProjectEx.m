//
//  SCBaseViewController+ProjectEx.m
//  FindAFitting
//
//  Created by SC on 16/5/10.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCBaseViewController+ProjectEx.h"

@implementation SCBaseViewController (ProjectEx)

- (void)customizeTabbar{
    
    [(RDVTabBarController*)self.navigationController.parentViewController setTabBarHidden:[self shouldShowBackButton]];
    
}

@end
