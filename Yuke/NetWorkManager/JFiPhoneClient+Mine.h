//
//  JFiPhoneClient+Mine.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient.h"

@interface JFiPhoneClient (Mine)

- (void)updatePic:(NSDictionary *)params
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)feedback:(NSDictionary *)params
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getUserInfo:(NSDictionary *)params
         success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getHeaderPhoto:(NSDictionary *)params
            success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)getFontAndVIP:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (void)isHaveFontAndVIP:(NSDictionary *)params
              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;
@end
