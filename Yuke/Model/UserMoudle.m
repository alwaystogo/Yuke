//
//  UserMoudle.m
//  LinkFinance
//
//  Created by ZhengYi on 16/5/31.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "UserMoudle.h"
#import "JFiPhoneClient.h"

#define kUserSaveFileName @"saveUser.archive"
#define kUserArchiveKey   @"JFUserInfo_ArchiveKey"

#define kUser_userId    @"user_id"
#define kUser_token     @"token"
#define kUSer_status    @"status"
#define kUSer_nick      @"userNick"
#define kUser_Autograph @"userAutograph"
#define kUser_Avatar    @"userAvatar"
#define kUser_AvatarBg  @"userAvatarBg"
#define kUser_Mobile    @"userMobile"
#define kUser_Gender    @"user_gender"

@interface UserMoudle ()<NSCoding>

@end

@implementation UserMoudle

+ (instancetype)shareUserMoudle{
    static dispatch_once_t onceToken;
    static UserMoudle *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        
        NSString *userPath = [UserMoudle userSavePath];
        NSString *filePath = [userPath stringByAppendingPathComponent:kUserSaveFileName];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        if (data == nil) {
            
            shareInstance = [[UserMoudle alloc]init];
    
        } else {
            
            //当UserMoudle的数据已经存到硬盘中，此时应用在后台被停止。
            //当再次进入程序并调用shareUserMoudle时，会走这个分支，从硬盘中取出并解档，然后return
            NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
            shareInstance = [unarchive decodeObjectForKey:kUserArchiveKey];
            [unarchive finishDecoding];
        }
    });
    return shareInstance;
}

#pragma mark - NSCoding 

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
    
        NSString *userId = [aDecoder decodeObjectForKey:kUser_userId];
        if (userId) {
            _user_Id = userId;
        }
        
        NSString *token = [aDecoder decodeObjectForKey:kUser_token];
        if (token) {
            _user_Token = token;
        }
        
        NSString *userNick = [aDecoder decodeObjectForKey:kUSer_nick];
        if (userNick) {
            _user_Nick = userNick;
        }
        
        NSString *autograph = [aDecoder decodeObjectForKey:kUser_Autograph];
        if (autograph) {
            _user_Autograph = autograph;
        }
        
        NSString *avatar = [aDecoder decodeObjectForKey:kUser_Avatar];
        if (avatar) {
            _user_avatar = avatar;
        }
        
        NSString *avatarBg = [aDecoder decodeObjectForKey:kUser_AvatarBg];
        if (avatarBg) {
            _user_avatarBg = avatarBg;
        }
        
        NSString *mobile = [aDecoder decodeObjectForKey:kUser_Mobile];
        if (mobile) {
            _user_mobile = mobile;
        }
        }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_user_Id forKey:kUser_userId];
    [aCoder encodeObject:_user_Token  forKey:kUser_token];
    [aCoder encodeObject:_user_Nick forKey:kUSer_nick];
    [aCoder encodeObject:_user_Autograph forKey:kUser_Autograph];
    [aCoder encodeObject:_user_avatar forKey:kUser_Avatar];
    [aCoder encodeObject:_user_avatarBg forKey:kUser_AvatarBg];
    [aCoder encodeObject:_user_mobile forKey:kUser_Mobile];
}

#pragma mark -

//获取UserMoudle在沙盒中的路径
+ (NSString *)userSavePath{
    NSString * path = [JFTools createDirectoryInDocumentDirectory:@"LinkUser"];
    return path;
}

//将UserMoudle存到沙盒中指定的目录中去
- (void)saveToFile{
    
    NSString *path = [UserMoudle userSavePath];
    NSString *filePath = [path stringByAppendingPathComponent:kUserSaveFileName];
    [JFTools createFileInDocumentDirectory:filePath];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    //先归档，然后存入沙盒文件中
    [archiver encodeObject:self forKey:kUserArchiveKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
}

//登录的接口返回的数据
- (void)saveDataToUserMoudle:(NSDictionary *)dic{
    _user_Id = dic[@"user_id"];
    _user_Token  = dic[@"token"];
    _user_Nick = NON(dic[@"nickName"]);
    _user_avatar = dic[@"headimg"];
    [self saveToFile];
}

//用户中心首页获取用户基本信息
- (void)saveBaseInfoToUSerMoudle:(NSDictionary *)dic{
    _user_Nick = NON(dic[@"nickName"]);
    _user_Autograph = NON(dic[@"autograph"]);
    _user_avatar = dic[@"headimg"];
    _user_avatarBg = dic[@"bgUrl"];
    [self saveToFile];
}

#pragma mark - 登录注册等方法

#pragma mark - 个人中心，获取用户信息相关方法

//清除UserMoudle的数据，覆盖沙盒中的数据
- (void)removeUserLoginInfo{
    _user_Id = nil;
    _user_Token = nil;
    _user_Autograph = nil;
    _user_Nick = nil;
    _user_avatar = nil;
    _user_mobile = nil;
    _user_avatarBg = nil;
    [self saveToFile];
}

@end
