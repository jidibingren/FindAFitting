//
//  FAFPOISearch.h
//  FindAFitting
//
//  Created by SC on 16/5/10.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FAFPOISearchBlock)(BOOL isSuccessed, NSMutableArray *addressArray, id additionalInfo);

@interface FAFPOISearchUtil : NSObject

DECLARE_SINGLETON()

- (void)nearbySearchByKeyword:(NSString *)keyword location:(CLLocationCoordinate2D) location callback:(FAFPOISearchBlock)callback;

- (void)nearbySearchByKeyword:(NSString *)keyword location:(CLLocationCoordinate2D) location additionalInfo:(id)additionalInfo callback:(FAFPOISearchBlock)callback;


@end
