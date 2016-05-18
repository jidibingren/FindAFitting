//
//  FAFHomeSearchBar.h
//  FindAFitting
//
//  Created by SC on 16/5/5.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import <JKSearchBar/JKSearchBar.h>

#define FAFHSB_RATIO (84/750.0)
//#define FAFHSB_HEIGHT (ScreenWidth*FAFHSB_RATIO)
#define FAFHSB_HEIGHT 44

@interface FAFHomeSearchBar : SCTableViewHeaderFooterView<JKSearchBarDelegate>
@property (nonatomic, strong)JKSearchBar *searchBar;
@end

@interface FAFSearchBar : UIView<JKSearchBarDelegate>
@property (nonatomic, strong)JKSearchBar *searchBar;
@end
