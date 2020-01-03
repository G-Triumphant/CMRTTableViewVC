//
//  CMBaseTableView.h
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/4/1.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMTableComponent.h"

typedef NS_ENUM(NSUInteger, CMSectionType) {
    CMSectionTypePlain,
    CMSectionTypeForGrouped,
};

NS_ASSUME_NONNULL_BEGIN

@interface CMBaseTableView : UITableView

@property (nonatomic, strong) NSArray <id<CMTableComponent>> *components;

@end

NS_ASSUME_NONNULL_END
