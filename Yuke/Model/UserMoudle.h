//
//  UserMoudle.h
//  LinkFinance
//
//  Created by ZhengYi on 16/5/31.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kUserDidLoginNotificationName @"UserDidLoginNotificationName"

@interface UserMoudle : NSObject

//用户ID
@property (copy, nonatomic) NSString *user_Id;

//用户校验token
@property (copy, nonatomic) NSString *user_Token;

//用户昵称
@property (copy, nonatomic) NSString *user_Nick;

//个性签名
@property (copy, nonatomic) NSString *user_Autograph;

//用户头像url
@property (copy, nonatomic) NSString *user_avatar;

//用户头像-背景大图url
@property (copy, nonatomic) NSString *user_avatarBg;

//用户的手机号码
@property (copy, nonatomic) NSString * user_mobile;

#pragma mark - methods

+ (instancetype)shareUserMoudle;

- (void)saveDataToUserMoudle:(NSDictionary *)dic;

- (void)saveToFile;

//清除UserMoudle的数据，覆盖沙盒中的数据
- (void)removeUserLoginInfo;

@end


