//
//  JFiPhoneClient+Workspace.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient.h"

@interface JFiPhoneClient (Workspace)

/**
 *  首页中，想理财师提问，获取提问的问题类型
 *  @param params
 *  @param success
 *  @param fail
 */
- (void)getQuestionType:(NSDictionary *)params
                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

@end
