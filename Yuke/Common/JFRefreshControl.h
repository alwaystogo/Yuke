//
//  JFRefreshControl.h
//  LinkFinance
//
//  Created by ZhengYi on 16/6/22.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface JFRefreshControl : MJRefreshStateHeader

@property (strong, nonatomic) UIImageView *lionGifView;

+ (instancetype)refreshControlWithTarget:(id)target action:(SEL)action;

- (void)setImages:(NSArray *)images
         duration:(NSTimeInterval)duration
         forState:(MJRefreshState)state;

- (void)setImages:(NSArray *)images
         forState:(MJRefreshState)state;

@end
