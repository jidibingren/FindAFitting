//
//  FAFFilterView.h
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"

//#define FAFHDD_HEIGHT  (ScreenWidth*(88/750.0))
#define FAFHDD_HEIGHT  (40)

@interface FAFFilterView : SCTableViewHeaderFooterView

@property (nonatomic, strong) DropdownMenu *dropdownMenu;

//@property (nonatomic, strong) NSDictionary *urlsDict;
//
//@property (nonatomic, strong) NSArray *sortIds;
//
//@property (nonatomic, strong) NSArray *distanceIds;

+ (NSString *)urlByCategoryId:(NSString *)categroyId;

+ (Class)cellClassByCategoryId:(NSString *)categroyId;

+ (Class)cellDataClassByCategoryId:(NSString *)categroyId;

+ (NSString *)sortIdByIndex:(NSInteger)index;

+ (NSString *)distanceIdByIndex:(NSInteger)index;

+ (DropdownMenu *)dropdownMenuWithFrame:(CGRect)frame;

@end
