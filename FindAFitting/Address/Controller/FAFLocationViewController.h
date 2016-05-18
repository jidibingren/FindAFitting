//
//  FAFLocationViewController.h
//  FindAFitting
//
//  Created by SC on 16/5/9.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCBaseViewController.h"
#import "FAFNearbySearchViewController.h"

//@interface FAFLocationViewController : SCBaseViewController
@interface FAFLocationViewController : WMPageController

+ (void)nearbySearch;

+ (void)nearbySearchWith:(FAFPOISearchBlock)callback;

@end
