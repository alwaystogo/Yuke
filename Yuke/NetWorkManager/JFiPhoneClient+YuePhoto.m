//
//  JFiPhoneClient+YuePhoto.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient+YuePhoto.h"

@implementation JFiPhoneClient (YuePhoto)

- (void)yuePaisheList:(NSDictionary *)params
              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self enqueueRequestWithMethod:@"index.php/Api/Shot/shotList" param:params success:success failure:failure];
}

- (void)yuePaisheBanner:(NSDictionary *)params
                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Shot/topBanner" param:params success:success failure:failure];
}

- (void)yiPaiList:(NSDictionary *)params
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Shot/userShotList" param:params success:success failure:failure];
}
@end
