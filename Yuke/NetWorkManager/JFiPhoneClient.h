//
//  JFiPhoneClient.h
//  LinkFinance
//
//  Created by ZhengYi on 16/6/6.
//  Copyright © 2016年 JF. All rights reserved.
//

#define kCachePolicyKey @"rqCachePolicy"
#define kCheckTokenType @"CheckTokenType"

typedef enum{
    
    LinkErrorCode_Normal = 200,                   //正常
    LinkErrorCode_InvalidToken = 000500,          //用户token失效
    LinkErrorCode_RequestTimeout = -1001,         //请求超时
    LinkErrorCode_ConnectError = -1009,           //网络连接错误
    LinkErrorCode_CannotConnectToServer = -1004,  //无法连接到服务器
    LinkErrorCode_LostConnect = -1005,            //失去连接
    
}LinkErrorCode;

//SSL证书名
#define kSSLCertName @""

//生产环境
FOUNDATION_EXPORT NSString * const JFiPhoneClient_PrdBaseUrl;

//测试环境
FOUNDATION_EXPORT NSString * const JFiPhoneClient_DebugBaseUrl;

//外网环境
FOUNDATION_EXPORT NSString * const JFiPhoneClient_NetBaseUrl;


@interface JFiPhoneClient : NSObject

@property (copy, nonatomic) NSString *devBaseUrl;
@property (copy, nonatomic) NSString *prodBaseUrl;
@property (copy, nonatomic) NSString * baseUrl;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

+ (instancetype) shareClient;

//post请求
- (NSURLSessionDataTask *)enqueueRequestWithMethod:(NSString *)method
                                             param:(NSDictionary *)data
                                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                           failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure;


- (NSMutableDictionary *)configCommonParams:(NSDictionary *)param;

- (id)parseResponse:(id)response;

//解析错误代码，自定义错误描述
- (NSError *)parseFailureError:(NSError *)error;
//网络监测
+(void)netWorkReachability;

@end
