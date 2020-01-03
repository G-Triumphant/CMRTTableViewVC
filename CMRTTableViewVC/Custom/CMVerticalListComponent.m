//
//  CMVerticalListComponent.m
//  CMRTTableViewVC
//
//  Created by 7cm-guo on 2019/3/4.
//  Copyright © 2019 7cm-guo. All rights reserved.
//

#import "CMVerticalListComponent.h"

@interface CMVerticalListComponent ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation CMVerticalListComponent

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<CMTableComponentDelegate>)delegate {
    self = [super initWithTableView:tableView delegate:delegate];
    if (self) {
    }
    return self;
}

- (void)registerWithTableView:(UITableView *)tableView {

    [super registerWithTableView:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
}

- (NSInteger)numberOfSections {
    
    return self.count;
}

- (NSInteger)numberOfItems {
    return 1;
}

- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index {
    return 64.f;
}

- (CGFloat)heightForComponentHeader {
    return 10.f;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)loadDataSuccess:(RequestSuccessBlock)success error:(RequestErrorBlock)error {
    self.count = 3;
    success();
}

@end
