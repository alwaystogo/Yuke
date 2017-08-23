//
//  JFiPhoneClient+Workspace.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "JFiPhoneClient+Workspace.h"

@implementation JFiPhoneClient (Workspace)

- (void)getQuestionType:(NSDictionary *)params
                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self enqueueRequestWithMethod:@"mb/askEvaluate/askGetPrdCat.action" param:params success:success failure:failure];
}

- (void)getWorkspaceBanner:(NSDictionary *)params
                   success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self enqueueRequestWithMethod:@"index.php/Api/Index/get_work_banner" param:params success:success failure:failure];

}
@end
