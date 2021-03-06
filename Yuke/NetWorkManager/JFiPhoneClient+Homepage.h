//
//  JFiPhoneClient+Homepage.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient.h"

@interface JFiPhoneClient (Homepage)

- (void)login:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)regist:(NSDictionary *)params
      success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)modifyPassword:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getHomePageBanner:(NSDictionary *)params
                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getHomePageHot:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)newHuodongList:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)picShowList:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)zuXunList:(NSDictionary *)params
            success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)zhuanfangList:(NSDictionary *)params
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)videoShowList:(NSDictionary *)params
            success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)duanxin:(NSDictionary *)params
              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)haibao:(NSDictionary *)params
        success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;
@end
