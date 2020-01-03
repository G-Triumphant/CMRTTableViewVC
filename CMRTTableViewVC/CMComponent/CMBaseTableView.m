//
//  CMBaseTableView.m
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/4/1.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import "CMBaseTableView.h"

@interface CMBaseTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CMSectionType sectionType;

@end

@implementation CMBaseTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        switch (style) {
            case UITableViewStylePlain:
                self.sectionType = CMSectionTypePlain;
                break;
                
            case UITableViewStyleGrouped:
                self.sectionType = CMSectionTypeForGrouped;
                break;
                
            default:
                break;
        }
        [self setup];
    }
    return self;
}

- (void)setup {
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark - UITableView Datasource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sectionType == CMSectionTypePlain) {
        return 1;
    }
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

@end
