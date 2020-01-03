//
//  CMCellComponent.h
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/4/3.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CMCellComponent <NSObject>

- (NSString *)registCellStringWithCell:(UITableViewCell *)cell;

- (CGFloat)height;

@end

NS_ASSUME_NONNULL_END
