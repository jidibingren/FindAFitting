//
//  FAFNearbySearchViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/9.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFNearbySearchViewController.h"

@implementation FAFNearbySearchViewController


- (void)viewDidLoad {
    
    self.disableHeaderRefresh = YES;
    
    self.disableFooterRefresh = YES;
    
    self.dontAutoLoad = YES;
    
    self.cellClass = [FAFNearbyCell class];
    
    self.cellDataClass = [FAFAddress class];
    
    self.cellHeight = 70;
    
    [super viewDidLoad];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < self.dataArray.count) {
        
        [FAFUserInfo sharedInstance].curAddress = self.dataArray[indexPath.row];
        
        if (self.delegate) {
            
            [self.delegate didSelectAddress:self.dataArray[indexPath.row]];
            
        }
    }
    
}

#pragma mark - UITableViewDataSource


@end
