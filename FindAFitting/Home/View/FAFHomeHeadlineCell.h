//
//  FAFHomeViews.h
//  FindAFitting
//
//  Created by SC on 16/5/5.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

#define kSCNotificationNameHeadlineDetail [NSString stringWithFormat:@"%@",self]

#define keyThumbnail  @"url"
#define keyDetailPage @"detailPage"
#define keyAdditionalInfo @"additionalInfo"

#define FAFHHL_RATIO (245/750.0)
#define FAFHHL_HEIGHT ScreenWidth*FAFHHL_RATIO

@interface FAFHomeHeadlineCell : SCTableViewCell

STD_PROP CycleScrollView *cycleScrollView;
STD_PROP UIPageControl *pageControl;

@end
