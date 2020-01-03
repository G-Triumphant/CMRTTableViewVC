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
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(CMSectionType)type {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.sectionType = type;
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
    switch (self.sectionType) {
            
        case CMSectionTypePlain:
            return 1;
            
        case CMSectionTypeForSingleGrouped:
            return self.components.count;
        
        case CMSectionTypeForMoreGrouped:
            return self.components[0].numberOfSections;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return self.components[section].numberOfItems;
    }
    return self.components[0].numberOfItems;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return self.components[section].heightForComponentHeader;
    }
    return self.components[0].heightForComponentHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return self.components[section].heightForComponentFooter;
    }
    return self.components[0].heightForComponentFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return [self.components[indexPath.section] heightForComponentItemAtIndex:indexPath.row];
    }
    return [self.components[0] heightForComponentItemAtIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return [self.components[section] headerForTableView:tableView];
    }
    return [self.components[0] headerForTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return [self.components[section] footerForTableView:tableView];
    }
    return [self.components[0] footerForTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        return [self.components[indexPath.section] cellForTableView:tableView atIndexPath:indexPath];
    }
    return [self.components[0] cellForTableView:tableView atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view
       forSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        if ([self.components[section] respondsToSelector:@selector(willDisplayHeader:)]) {
            [self.components[section] willDisplayHeader:view];
        }
    }
    if ([self.components[0] respondsToSelector:@selector(willDisplayHeader:)]) {
        [self.components[0] willDisplayHeader:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view
       forSection:(NSInteger)section {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        if ([self.components[section] respondsToSelector:@selector(willDisplayFooter:)]) {
            [self.components[section] willDisplayFooter:view];
        }
    }
    if ([self.components[0] respondsToSelector:@selector(willDisplayFooter:)]) {
        [self.components[0] willDisplayFooter:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionType == CMSectionTypeForSingleGrouped) {
        if ([self.components[indexPath.section] respondsToSelector:@selector(willDisplayCell:forIndexPath:)]) {
            [self.components[indexPath.section] willDisplayCell:cell
                                                   forIndexPath:indexPath];
        }
    }
    if ([self.components[0] respondsToSelector:@selector(willDisplayCell:forIndexPath:)]) {
        [self.components[0] willDisplayCell:cell
                                               forIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionType != CMSectionTypeForMoreGrouped) {
        if ([self.components[indexPath.section] respondsToSelector:@selector(didSelectItemAtIndex:)]) {
            [self.components[indexPath.section] didSelectItemAtIndex:indexPath.row];
        }
    }
    if ([self.components[0] respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.components[0] didSelectItemAtIndex:indexPath.section];
    }
}

@end
