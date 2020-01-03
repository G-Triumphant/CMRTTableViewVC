//
//  CMBaseComponent.m
//
//  Created by 7cm-guo on 2019/2/22.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import "CMBaseComponent.h"

@interface CMBaseComponent ()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation CMBaseComponent

+ (instancetype)componentWithTableView:(UITableView *)tableView {
    return [self componentWithTableView:tableView
                               delegate:nil];
}

+ (instancetype)componentWithTableView:(UITableView *)tableView delegate:(id<CMTableComponentDelegate>)delegate {
    id<CMTableComponent> component = [[self alloc] initWithTableView:tableView
                                                            delegate:delegate];
    return component;
}

- (instancetype)init {
    return [self initWithTableView:nil];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    return [self initWithTableView:tableView
                          delegate:nil];
}

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<CMTableComponentDelegate>)delegate {
    self = [super init];
    if (self) {
        self.cellIdentifier = [NSString stringWithFormat:@"%@-Cell", NSStringFromClass(self.class)];
        self.headerIdentifier = [NSString stringWithFormat:@"%@-Header", NSStringFromClass(self.class)];
        self.footerIdentifier = [NSString stringWithFormat:@"%@-Footer", NSStringFromClass(self.class)];
        self.tableView = tableView;
        self.delegate = delegate;
        
        [self registerWithTableView:tableView];
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 0;
}

- (CGFloat)heightForComponentHeader {
    return 0.f;
}

- (CGFloat)heightForComponentFooter {
    return CGFLOAT_MIN;
}

- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index {
    return 0.f;
}

- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView
                                   atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    return cell;
}

- (__kindof UIView *)headerForTableView:(UITableView *)tableView {
    return NULL;
}

- (__kindof UIView *)footerForTableView:(UITableView *)tableView {
    return NULL;
}

- (void)didSelectItemAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(tableComponent:didSelectItemAtIndex:)]) {
        [self.delegate tableComponent:self
                    didSelectItemAtIndex:index];
    }
}

- (void)reloadDataWithTableView:(UITableView *)tableView
                      inSection:(NSInteger)section {
    
}

- (void)registerWithTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:self.cellIdentifier];
}

- (void)setNeedUpdateHeightForSection:(NSInteger)section {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, NO, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        [self.tableView reloadData];
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

@end
