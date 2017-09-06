//
//  Config.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import "AppDelegate.h"


#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define VERSION_CODE @"1.0"

//获取系统版本
#define IOS_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//MD5加密字符串
#define MD5String(string) [JFTools md5Lowercase:(string)]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define NOTIFICATIONCENTER [NSNotificationCenter defaultCenter]
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
#define kUserMoudle  ([UserMoudle shareUserMoudle])
#define kDevice      ([JFDevice shareInstance])
#define kJFClient ([JFiPhoneClient shareClient])
#define kAppContext ([AppContext sharedInstance])
#define kUserInfoManager ([UserInfoManager sharedInstance])

//当前屏幕的宽
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
//当前屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

//tabBar高度
#define TABBAR_HEIGHT 49
//导航栏高度
#define NAVBAR_HEIGHT 64
//状态栏高度
#define STATEBAR_HEIGHT 20

//当前屏幕宽与iPhone6s屏幕宽的比例，并且除以2。这样就可以直接根据标注图标注的尺寸计算控件的宽
#define BiLi_SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width/375/2)
//不除以2的比例
#define BiLi_SCREENWIDTH_NORMAL  ([UIScreen mainScreen].bounds.size.width/375)

//当前屏幕宽与iPhone6s屏幕搞的比例，并且除以2。这样就可以直接根据标注图标注的尺寸计算控件的高
#define BiLi_SCREENHEIGHT  ([UIScreen mainScreen].bounds.size.height/667/2)
//不除以2的比例
#define BiLi_SCREENHEIGHT_NORMAL  ([UIScreen mainScreen].bounds.size.height/667)

//设置颜色
#define COLOR_RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COLOR_RANDOM [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]
#define COLOR_HEX(h,a) COLOR_RGB(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)
//清除背景色
#define CLEARCOLOR [UIColor clearColor]
#define WHITECOLOR [UIColor whiteColor]

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//系统字体
#define SYSTEM_FONT(a) [UIFont systemFontWithSize:(a)]

//苹方常规字体
#define FONT_REGULAR(a)  [UIFont pingFangSC_RegularWithFont:(a)]

//苹方中等字体
#define FONT_MEDIUM(a) [UIFont pingFangSC_MediumWithFont:(a)]

//苹方粗体字体
#define FONT_BOLD(a)  [UIFont pingFangSC_SemiboldWithFont:(a)]

//AppDelegate
#define kAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define kApplication [UIApplication sharedApplication];

//Current NavigationController
#define kCurNavController   \
((UINavigationController *)([[UIViewController currentViewController]  \
isKindOfClass:[UINavigationController class]] \
? [UIViewController currentViewController]    \
: [UIViewController currentViewController]    \
.navigationController))

#define NON(str) (str ? [NSString stringWithFormat:@"%@",str] : @"")

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(self) strongSelf = self;

// 状态栏上的网络指示器 显示
#define NETWORKACTIVITY_YES [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]
// 状态栏上的网络指示器 隐藏
#define NETWORKACTIVITY_NO [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]

#define is3_5InchNormal ((int)[[UIScreen mainScreen] scale] ==1) // iPhone 1、3G、3GS，iPod Touch 1、2、3


//iPhone4 iPod4
#define is3_5InchRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size): NO)

//iPhone5/s/c iPod5 iPhone6放大模式
#define is4_0Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)]? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size): NO)

//iPhone6
#define is4_7Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)]? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size): NO)

//iPhone6 plus 及其放大模式
#define is5_5Inch ((int)[[UIScreen mainScreen] scale] == 3)

#define isiOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#define isiOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define isiOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define isiOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0 ? YES : NO)

//导航栏左侧按钮图片
#define kLeftNavImageName @"black_fanhui"

#define kPickerViewHeight 250

#define testUserId @"527C895A393F4C2DBA7B58139E9268FE"
#define testToken @"1461DBDD782C482F9DFD62C5917F40D5"

//请求不到图片时的占位图
#define PlaceHolderPic @"huodongPic"

//卡片缩放倍数
#define SCALE 6

#define FONT1 @"庞门正道标题体"
#define FONT2 @"站酷快乐体2016修订版"
#define FONT3 @"郑庆科黄油体Regular"
#define FONT4 @"站酷高端黑"
#define FONT5 @"Noto Sans CJK"
#define FONT6 @"思源黑体 CN"
#define FONT7 @"Source Han Sans"

//内购
#define Product_ziti1 @"com.yuke.YukeApp1" //黄油字体 1
#define Product_ziti2 @"com.yuke.YukeApp2"//庞门正道字体 2
#define Product_1yue @"com.yuke.YukeApp3" //3
#define Product_3yue @"com.yuke.YukeApp4" //4
#define Product_6yue @"com.yuke.YukeApp5" //5
#define Product_12yue @"com.yuke.YukeApp6" //6

#endif /* Config_h */
