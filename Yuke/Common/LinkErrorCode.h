//
//  LinkErrorCode.h
//  LinkFinance
//
//  Created by ZhengYi on 16/9/6.
//  Copyright © 2016年 JF. All rights reserved.
//

#ifndef LinkErrorCode_h
#define LinkErrorCode_h

typedef enum{
    
    LinkErrorCode_Normal = 200,                   //正常
    LinkErrorCode_InvalidToken = 000500,          //用户token失效
    LinkErrorCode_RequestTimeout = -1001,         //请求超时
    LinkErrorCode_ConnectError = -1009,           //网络连接错误
    LinkErrorCode_CannotConnectToServer = -1004,  //无法连接到服务器
    LinkErrorCode_LostConnect = -1005,            //失去连接

}LinkErrorCode;

#endif /* LinkErrorCode_h */
