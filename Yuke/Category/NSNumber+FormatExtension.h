//
//  NSNumber+FormatExtension.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/28.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (FormatExtension)

/*
 *  将number类型的数字格式化成 形如 123,456.00格式
 */
- (NSString *) formatTo_Y;

@end
