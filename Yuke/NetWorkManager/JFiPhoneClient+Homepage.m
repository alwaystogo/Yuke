//
//  JFiPhoneClient+Homepage.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient+Homepage.h"

@implementation JFiPhoneClient (Homepage)

- (void)login:(NSDictionary *)params
      success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/User/login" param:params success:success failure:failure];
}

- (void)regist:(NSDictionary *)params
       success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
     [self enqueueRequestWithMethod:@"index.php/Api/User/register" param:params success:success failure:failure];
}
- (void)getHomePageBanner:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self enqueueRequestWithMethod:@"index.php/Api/Index/get_banner" param:params success:success failure:failure];
}

- (void)getHomePageHot:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self enqueueRequestWithMethod:@"index.php/Api/Index/get_interview" param:params success:success failure:failure];

}
- (void)modifyPassword:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/User/edit_password" param:params success:success failure:failure];
}
- (void)newHuodongList:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Index/get_activity" param:params success:success failure:failure];
}
- (void)picShowList:(NSDictionary *)params
            success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self enqueueRequestWithMethod:@"index.php/Api/Card/card_list" param:params success:success failure:failure];
}

- (void)updatePic:(NSDictionary *)params
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Card/update_card" param:params success:success failure:failure];
}
@end
