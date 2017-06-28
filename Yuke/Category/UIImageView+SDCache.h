//
//  UIImageView+SDCache.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/4/27.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDCache)

/**
 *  加载网络图片，如果本地有缓存则使用缓存图片。 从占位图切换到实际图片时会有一个渐显的动画
 *
 *  @param url              图片url
 *  @param placeholder      占位图
 */
-(void)getImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholder;


@end
