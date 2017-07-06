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

- (void)getHomePageBanner:(NSDictionary *)params
                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getHomePageHot:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


@end
