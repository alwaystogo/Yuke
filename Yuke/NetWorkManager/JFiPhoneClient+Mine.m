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
@end
