//
//  UITableView+AdapteiOS11.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/9/21.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (AdapteiOS11)

/*
 *  iOS11中tableview自动开启self-sizing，如果出现tableview底部有留白，可以关闭行高估算模式。
 */
- (void)closeEstimatedHeight;

/*
 *  iOS11中如果想要取消tableview的顶部偏移量计算，可以使用该方法
 */
- (void)closeContentInsetAdjustAutomaicCalculate;

@end
