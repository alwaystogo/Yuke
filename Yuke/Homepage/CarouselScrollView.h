//
//  CarouselScrollView.h
//  Technology
//
//  Created by user on 30/11/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ImageViewClick)(NSInteger index);

@interface CarouselScrollView : UIScrollView

@property (nonatomic,strong)ImageViewClick click;

/**功能：初始化轮播数组
 * @param array 数据，存储的是字典类型。字典格式｛@“carouseUrl”:value, @"summary":value, @"objectId":value｝
 */
-(void)setCarouseWithArray:(NSArray *)array;

/**功能：停止轮播定时器
 * @param 无
 * return void */

-(void)invalidateTimer;


/**功能：开启定时器
 * @param 无
 * return void
 */
-(void)fireTimer;


@end
