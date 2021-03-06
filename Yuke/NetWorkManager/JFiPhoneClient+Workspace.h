//
//  JFiPhoneClient+Workspace.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient.h"

@interface JFiPhoneClient (Workspace)


- (void)getQuestionType:(NSDictionary *)params
                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getWorkspaceBanner:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

@end
