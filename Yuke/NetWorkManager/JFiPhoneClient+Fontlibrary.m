//
//  JFiPhoneClient+Fontlibrary.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient+Fontlibrary.h"

@implementation JFiPhoneClient (Fontlibrary)

- (void)fontList:(NSDictionary *)params
         success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Shot/fontList" param:params success:success failure:failure];
}
@end
