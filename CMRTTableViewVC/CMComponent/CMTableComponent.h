//
//  CMTableComponent.h
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/2/22.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol CMTableComponent;

@protocol CMTableComponentDelegate <NSObject>

@optional

- (void)tableComponent:(id<CMTableComponent>)component didSelectItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 注册协议
 */
@protocol CMTableComponent <NSObject>

@required

// 分区header标识
- (NSString *)headerIdentifier;

// 分区footer标识
- (NSString *)footerIdentifier;

// 分区cell标识
- (NSString *)cellIdentifier;

// 分区section个数
- (NSInteger)numberOfSections;

// 分区row个数
- (NSInteger)numberOfItems;

// 分区header的高度
- (CGFloat)heightForComponentHeader;

// 分区footer的高度
- (CGFloat)heightForComponentFooter;

// 分区每一个row的高度
- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index;

// 获取当前行cell
- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView
                                   atIndexPath:(NSIndexPath *)indexPath;
// 加载分区数据
- (void)reloadDataWithTableView:(UITableView *)tableView
                    inSection:(NSInteger)section;
// 注册cell
- (void)registerWithTableView:(UITableView *)tableView;

@optional

// 获取头分区
- (__kindof UIView *)headerForTableView:(UITableView *)tableView;

// 获取尾分区
- (__kindof UIView *)footerForTableView:(UITableView *)tableView;

- (void)willDisplayHeader:(__kindof UIView *)header;

- (void)willDisplayFooter:(__kindof UIView *)footer;

- (void)willDisplayCell:(__kindof UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

- (void)didSelectItemAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
