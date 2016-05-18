//
//  FAFShopViewController.m
//  FindAFitting
//
//  Created by SC on 16/5/7.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFWorkerViewController.h"

@interface FAFWorkerViewController ()<DropdownMenuDelegate>

@property (nonatomic, strong)DropdownMenu *dropdownMenu;

@property (nonatomic, strong)NSString *filterName;
@property (nonatomic,       )NSInteger type;
@property (nonatomic, strong)NSString *distance;

@end

@implementation FAFWorkerViewController

+ (FAFWorkerViewController *)workerViewControllerWithType:(NSInteger)type {
    FAFWorkerViewController *workerVC = [FAFWorkerViewController new];
    workerVC.url = FAF_GET_WORKER_LIST_URL;
    workerVC.listPath = @"data";
    workerVC.type = type;
    workerVC.filterName = @"type";
    workerVC.title = NSLocalizedString(@"找个工人", nil);
    return workerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)customizeTableView{
    CGRect frame = self.tableView.frame;
    frame.origin.y += FAFHDD_HEIGHT;
    frame.size.height -= FAFHDD_HEIGHT;
    self.tableView.frame = frame;

}

- (void)customizeParams:(NSMutableDictionary *)params newer:(BOOL)newer{
    
    NSMutableDictionary *tempParams = params ? : [NSMutableDictionary new];
    
    if ([Utils isValidStr:_filterName]) {
        
        tempParams[_filterName] = @(_type);
    
    }
}

- (void)setupDropdownMenu{
    
    _dropdownMenu = [FAFFilterView dropdownMenuWithFrame:self.view.frame];
    
    _dropdownMenu.delegate = self;
    
    [self.view addSubview:_dropdownMenu.view];
}

@end
