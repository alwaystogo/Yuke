//
//  UITableView+AdapteiOS11.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/9/21.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "UITableView+AdapteiOS11.h"

@implementation UITableView (AdapteiOS11)

- (void)closeEstimatedHeight{
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

- (void)closeContentInsetAdjustAutomaicCalculate{
    
    if (@available(iOS 11.0, *)) {

        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        
    }
}

@end
