//
//  JFiPhoneClient.m
//  LinkFinance
//
//  Created by ZhengYi on 16/6/6.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFiPhoneClient.h"
//#import "JFiPhoneClient+HandleInvalidUserToken.h"

#define PARAM_SALT @"iamlink"

//测试环境
//NSString * const JFiPhoneClient_DebugBaseUrl   = @"http://116.62.194.17/yuke";
//NSString * const JFiPhoneClient_DebugBaseUrl   = @"http://47.95.210.218/yuke";//刘
//NSString * const JFiPhoneClient_DebugBaseUrl   = @"http://47.92.92.140/yuke";//gu
NSString * const JFiPhoneClient_DebugBaseUrl   = @"http://yukein.com/yuke";//yuming

//生产环境
//NSString * const JFiPhoneClient_PrdBaseUrl   = @"http://116.62.194.17/yuke";
//NSString * const JFiPhoneClient_PrdBaseUrl   = @"http://47.95.210.218/yuke";//刘
//NSString * const JFiPhoneClient_PrdBaseUrl   = @"http://47.92.92.140/yuke";//gu
NSString * const JFiPhoneClient_PrdBaseUrl   =  @"http://yukein.com/yuke";//gu

static NSString *const JFErrorDomain = @"Yuke.com";

@interface JFiPhoneClient ()


@end

@implementation JFiPhoneClient

+ (instancetype) shareClient{
    
    static dispatch_once_t onceToken;
    static JFiPhoneClient *client = nil;
    dispatch_once(&onceToken, ^{
        client = [[JFiPhoneClient alloc]init];
    });
    return client;
}

- (instancetype)init{
    
    if (self = [super init]) {
        [self configClient];
    }
    return self;
}

- (void)configClient{

    self.devBaseUrl  = JFiPhoneClient_DebugBaseUrl;
    self.prodBaseUrl = JFiPhoneClient_PrdBaseUrl;
    
#ifdef DEBUG
    self.baseUrl = self.devBaseUrl;
#else
    self.baseUrl = self.prodBaseUrl;
#endif
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
    
    //设置超时时间
    [self.manager.requestSerializer setTimeoutInterval:300];
    
    //设置相应数据可以接收的类型
    self.manager.responseSerializer.acceptableContentTypes =
            [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    
    //为支持https请求，添加SSL认证
    //self.manager.securityPolicy = [self customSecurityPolicy];
    
    //...
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    //是否允许CA不信任的证书通过
//    policy.allowInvalidCertificates = YES;
//    //是否验证主机名
//    policy.validatesDomainName = NO;
//    self.manager.securityPolicy = policy;
}

- (NSURLSessionDataTask *)enqueueRequestWithMethod:(NSString *)method
                           param:(NSDictionary *)data
                         success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure{
    
    NSParameterAssert(method != nil);
    
    NSMutableDictionary *temp = [self configCommonParams:data];
    NSURLSessionDataTask *task =
    [self.manager POST:method parameters:temp progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        id result = [self parseResponse:responseObject];
        
        NSLog(@"---- PARAMETER %@",temp);
        //NSLog(@"---- RESPONSE OBJECT : %@",(NSDictionary *)result);
        if ([result isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)result;
            NSLog(@"REQUEST ERROR CODE : %zd",error.code);
            //token失效
            failure(task, (NSError *)result);
            
        } else{
            success(task ,result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        error = [self parseFailureError:error];
        NSLog(@"REQUEST ERROR CODE : %zd",error.code);
        //NSLog(@"ERROR DESC : %@",error.localizedDescription);

        //token失效
        failure(task, error);

}];
    
    NSLog(@"---- REQUEST URL : %@",task.currentRequest.URL.absoluteString);
    return task;
}

- (NSMutableDictionary *)configCommonParams:(NSDictionary *)param{
    
    NSMutableDictionary *temp;
    if (param) {
        temp = [NSMutableDictionary dictionaryWithDictionary:param];
    } else {
        temp = [NSMutableDictionary dictionary];
    }
    
    return temp;
}

- (id)parseResponse:(id)response{
    
    //response = [response safeAllEx];
    response = [NSDictionary changeType:response];
    if ([response[@"status"] intValue] == 200 || [response[@"status"] intValue] == 2003) {
        if (response[@"data"]) {
            return response[@"data"];
        }
        return response;
    } else {
        NSInteger errorCode = [response[@"status"] integerValue];
        NSString *failureReason = response[@"message"];
        NSError *error = [self paringErrorWithFailureReason:failureReason
                                                  errorCode:errorCode];
        return error;
    }
}

//解析错误代码，自定义错误描述
- (NSError *)parseFailureError:(NSError *)error{
    
    NSString *localizedDescription;
    //请求超时
    if (error.code == LinkErrorCode_RequestTimeout) {
        localizedDescription = @"请求超时";
    }
    //网络未连接
    if (error.code == LinkErrorCode_ConnectError) {
        localizedDescription = @"网络连接错误";
    }
    //无法连接到服务器
    if (error.code == LinkErrorCode_CannotConnectToServer) {
        localizedDescription = @"无法连接到服务器";
    }
    //失去连接
    if (error.code == LinkErrorCode_LostConnect) {
        localizedDescription = @"失去连接";
    }
    //token失效，需要重新登录（该账号在其他设备上登录）
    if (error.code == LinkErrorCode_InvalidToken) {
        localizedDescription = @"该账号在其他设备上登录，请重新登录";
    }
    return [self paringErrorWithFailureReason:localizedDescription
                                    errorCode:error.code];
}

//定制NSError来封装服务器返回的特定的错误信息
- (NSError *)paringErrorWithFailureReason:(NSString *)failureReason
                                errorCode:(NSInteger)errorCode{
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[NSLocalizedDescriptionKey] = failureReason;
    NSError *error = [NSError errorWithDomain:JFErrorDomain
                                         code:errorCode
                                     userInfo:userInfo];
    return error;
}

+ (void)netWorkReachability{
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络");
            }
            case AFNetworkReachabilityStatusNotReachable:{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请检查你的网络状态" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                NSLog(@"请检查网络状态");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"WWAN");
                break;
            }
            default:
                break;
        }
    }];
}
@end
