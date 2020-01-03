//
//  CMComponentController.m
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/2/22.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import "CMComponentController.h"
#import "CMTableComponent.h"

@interface CMComponentController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CMComponentController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tableView.frame = [self tableViewRectForBounds:self.view.bounds];
}

#pragma mark - Custom Methods

- (CGRect)tableViewRectForBounds:(CGRect)bounds {
    return bounds;
}

#pragma mark - UITableView Datasource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.components.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.components[section].numberOfItems;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.components[section].heightForComponentHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.components[section].heightForComponentFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.components[indexPath.section] heightForComponentItemAtIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.components[section] headerForTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.components[section] footerForTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.components[indexPath.section] cellForTableView:tableView atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view
       forSection:(NSInteger)section {
    if ([self.components[section] respondsToSelector:@selector(willDisplayHeader:)]) {
        [self.components[section] willDisplayHeader:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view
       forSection:(NSInteger)section {
    if ([self.components[section] respondsToSelector:@selector(willDisplayFooter:)]) {
        [self.components[section] willDisplayFooter:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.components[indexPath.section] respondsToSelector:@selector(willDisplayCell:forIndexPath:)]) {
        [self.components[indexPath.section] willDisplayCell:cell
                                               forIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.components[indexPath.section] respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.components[indexPath.section] didSelectItemAtIndex:indexPath.row];
    }
}

#pragma mark - getter and setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self tableViewRectForBounds:self.view.bounds]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)setComponents:(NSArray<id<CMTableComponent>> *)components {
    if (_components != components) {
        _components = components;
        [self.tableView reloadData];
    }
}

@end
