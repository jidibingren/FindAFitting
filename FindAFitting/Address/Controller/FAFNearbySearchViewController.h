//
//  FAFNearbySearchViewController.h
//  FindAFitting
//
//  Created by SC on 16/5/9.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "SCTableViewController.h"
#import "FAFNearbyCell.h"

@protocol FAFNearbySearchDelegate <NSObject>

@required

- (void)didSelectAddress:(FAFAddress *)address;

@end

@interface FAFNearbySearchViewController : SCTableViewController

@property (nonatomic, weak) id <FAFNearbySearchDelegate> delegate;

@end
