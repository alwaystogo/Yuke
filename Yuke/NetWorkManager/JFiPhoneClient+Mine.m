//
//  JFiPhoneClient+Mine.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient+Mine.h"

@implementation JFiPhoneClient (Mine)

- (void)updatePic:(NSDictionary *)params
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Card/update_card" param:params success:success failure:failure];
}

- (void)feedback:(NSDictionary *)params
         success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/User/feedback" param:params success:success failure:failure];

}
- (void)getUserInfo:(NSDictionary *)params
            success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/User/get_user_info" param:params success:success failure:failure];
}
- (void)getHeaderPhoto:(NSDictionary *)params
               success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
     [self enqueueRequestWithMethod:@"index.php/Api/User/get_user_headimg" param:params success:success failure:failure];
}
- (void)getFontAndVIP:(NSDictionary *)params
              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/User/get_font_vip" param:params success:success failure:failure];
}
- (void)isHaveFontAndVIP:(NSDictionary *)params
                 success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                 failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
     [self enqueueRequestWithMethod:@"index.php/Api/User/validate_vip" param:params success:success failure:failure];
}
@end
