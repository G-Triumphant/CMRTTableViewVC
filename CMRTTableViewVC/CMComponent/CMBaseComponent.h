//
//  CMBaseComponent.h
//
//  Created by 7cm-guo on 2019/2/22.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CMTableComponent.h"

typedef void(^RequestSuccessBlock)();

typedef void(^RequestErrorBlock)();

/**
 分区基类
 */
@interface CMBaseComponent : NSObject <CMTableComponent>

@property (nonatomic, weak) id<CMTableComponentDelegate> delegate;

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) NSString *headerIdentifier;

@property (nonatomic, copy) NSString *footerIdentifier;

+ (instancetype)componentWithTableView:(UITableView *)tableView;

+ (instancetype)componentWithTableView:(UITableView *)tableView delegate:(id< CMTableComponentDelegate>)delegate;

- (instancetype)init;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<CMTableComponentDelegate>)delegate;

- (void)registerWithTableView:(UITableView *)tableView;

- (void)setNeedUpdateHeightForSection:(NSInteger)section;

- (void)loadDataSuccess:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

- (void)loadMoreDataSuccess:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

@end
