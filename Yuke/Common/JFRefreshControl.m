//
//  JFRefreshControl.m
//  LinkFinance
//
//  Created by ZhengYi on 16/6/22.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFRefreshControl.h"
#define kLionImageArrayKey @"LionImageArray"

@interface JFRefreshControl ()

/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@property (strong, nonatomic) NSMutableArray *commonRefreshImages;

@end

@implementation JFRefreshControl

+ (instancetype)refreshControlWithTarget:(id)target action:(SEL)action{
    
    JFRefreshControl *refreshControl = [JFRefreshControl headerWithRefreshingTarget:target refreshingAction:action];
    
    [refreshControl setImages:refreshControl.commonRefreshImages forState:MJRefreshStateRefreshing];
    [refreshControl setImages:refreshControl.commonRefreshImages forState:MJRefreshStateIdle];
    [refreshControl setImages:refreshControl.commonRefreshImages forState:MJRefreshStatePulling];
    
    [refreshControl setTitle:@"下拉刷新"      forState:MJRefreshStateIdle];
    [refreshControl setTitle:@"松手刷新..."   forState:MJRefreshStatePulling];
    [refreshControl setTitle:@"正在刷新中..." forState:MJRefreshStateRefreshing];
    
    return refreshControl;
}

- (NSMutableArray *)commonRefreshImages{

    if ([[EGOCache globalCache] objectForKey:kLionImageArrayKey]) {
        
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:(NSArray *)[[EGOCache globalCache] objectForKey:kLionImageArrayKey]];
        if (tmpArr.count == 0) {
            tmpArr = [self getImageArray];
            [[EGOCache globalCache] removeCacheForKey:kLionImageArrayKey];
        }
        return tmpArr;
        
    } else{
        NSMutableArray *refreshImages = [self getImageArray];
        [[EGOCache globalCache] setObject:refreshImages forKey:kLionImageArrayKey];
        
        return refreshImages;
    }
}

- (NSMutableArray *)getImageArray{
    NSMutableArray *refreshImages = [NSMutableArray array];
    
    NSString *imgName;
    
    NSString *filePath = @"";
    
    for (NSInteger i = 1; i < 40; i++) {
        @autoreleasepool {
            
            imgName = [NSString stringWithFormat:@"lion_Animation-0%zd",i];
            filePath = [[NSBundle mainBundle] pathForResource:imgName ofType:@"png"];
            
            UIImage *image = [UIImage imageWithContentsOfFile:filePath];
            
            [refreshImages addObject:image];
        }
    }
    
    return refreshImages;
}

- (UIImageView *)lionGifView{
    if (_lionGifView == nil) {
        _lionGifView = [[UIImageView alloc]init];
        _lionGifView.contentMode = UIViewContentModeScaleToFill;
        _lionGifView.image =  [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1"]];
        [self addSubview:_lionGifView];
    }
    return _lionGifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.03 forState:state];
}

- (void)placeSubviews{
    [super placeSubviews];
    
    self.stateLabel.hidden = NO;
    self.lastUpdatedTimeLabel.hidden = NO;

    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13.0];
    self.lastUpdatedTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.lastUpdatedTimeLabel.text = @"理财师祝您轻松理财";
    
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.stateLabel.textAlignment = NSTextAlignmentLeft;
    self.stateLabel.textColor = COLOR_HEX(0x999999, 1.0);
    
    self.lionGifView.mj_y = 8;
    self.lionGifView.mj_x = self.mj_w / 3 * 0.87;
    self.lionGifView.mj_h = self.mj_h - 10;
    self.lionGifView.mj_w = self.lionGifView.mj_h / 116 * 94;
    
    self.lastUpdatedTimeLabel.mj_x = CGRectGetMaxX(self.lionGifView.frame) + 15;
    self.lastUpdatedTimeLabel.mj_y = self.lionGifView.mj_y + 5;
    self.lastUpdatedTimeLabel.mj_h = 15;
    self.lastUpdatedTimeLabel.mj_w = self.mj_w - self.lastUpdatedTimeLabel.mj_x;
    
    self.stateLabel.mj_x = self.lastUpdatedTimeLabel.mj_x;
    self.stateLabel.mj_y = CGRectGetMaxY(self.lionGifView.frame) - 20;
    self.stateLabel.mj_w = self.lastUpdatedTimeLabel.mj_w;
    self.stateLabel.mj_h = 15;
}


- (void)setState:(MJRefreshState)state{
    
    MJRefreshCheckState
    
    self.lastUpdatedTimeLabel.text = @"理财师祝您轻松理财";
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.lionGifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.lionGifView.image = [images lastObject];
        } else { // 多张图片
            self.lionGifView.animationImages = images;
            self.lionGifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.lionGifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        [self.lionGifView stopAnimating];
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent{
    
    //NSLog(@"setPullingPercent %.3f",pullingPercent);
    
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    
    if (self.state != MJRefreshStateIdle || images.count == 0)
        return;
    
    // 停止动画
    [self.lionGifView stopAnimating];
    
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    
    if (index >= images.count)
        index = images.count - 1;
    
    self.lionGifView.image = images[index];
}

@end
