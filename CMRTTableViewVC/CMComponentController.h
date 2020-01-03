//
//  CMComponentController.h
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/2/22.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMTableComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMComponentController : UIViewController

@property (nonatomic, readonly, strong) UITableView *tableView;


@property (nonatomic, strong) NSArray <id<CMTableComponent>> *components;

- (CGRect)tableViewRectForBounds:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
