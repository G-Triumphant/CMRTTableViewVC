//
//  ViewController.m
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/3/1.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import "ViewController.h"

#import "CMComponent/CMBaseTableView.h"
#import "Custom/CMVerticalListComponent.h"

@interface ViewController ()<CMTableComponentDelegate>

@property (nonatomic, strong) CMBaseTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

- (void)tableComponent:(id<CMTableComponent>)component didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}

- (CMBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[CMBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped type:CMSectionTypeForMoreGrouped];
        CMVerticalListComponent *verComponent = [CMVerticalListComponent componentWithTableView:self.tableView delegate:self];
        [verComponent loadDataSuccess:^{
            [self.tableView reloadData];
        } error:^{
        }];
        _tableView.components = @[verComponent];
        
    }
    return _tableView;
}

@end
