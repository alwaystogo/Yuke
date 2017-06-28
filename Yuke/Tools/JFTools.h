//
//  JFTools.h
//  LinkFinance
//
//  Created by yangyunfei on 16/5/25.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JFToolsAlertBlock) (BOOL canceled, NSInteger buttonIndex);

/**
 *  @brief  判断字符串是否为空
 *
 *  @param  thing 传入字符串
 *
 *  @return 是否为空
 */
static inline BOOL IsEmpty(id thing) {
    if ([thing isKindOfClass:[NSString class]]) {
        thing = [thing stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return ((NSString*)thing).length==0;
    }
    return thing == nil|| [thing isMemberOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

@interface JFTools : NSObject


/**
 *  @brief  正则表达式验证字符串是否由数字组成
 *
 *  @param  str 传入字符串
 *
 */
+(BOOL)checkIsNum:(NSString *)str;

/**
 *  @brief  正则表达式验证字符串是否由字母组成
 *
 *  @param  str 传入字符串
 *
 */
+(BOOL)checkIsWorld:(NSString *)str;

/**
 *  @brief  正则表达式验证字符串是否由数字或字母组成
 *
 *  @param  str 传入字符串
 *
 */
+(BOOL)checkIsWorldAndNum:(NSString *)str;

/**
 *  验证密码是否合法(6-12位数字或英文字符)
 *
 *  @param passWord 传入字符串
 *
 */
+ (BOOL) validatePassword:(NSString *)passWord;

/**
 *  验证手机号是否合法
 *
 *  @param mobile 传入字符串
 *
 */
+ (BOOL) isValidateMobile:(NSString *)mobile;

/**
 *  @brief  验证邮箱格式
 *
 *  @param  str 传入字符串
 *
 */
+(BOOL)checkIsEmail:(NSString*)str;

/**
 *  @brief  base64加密
 *
 *  @param  string 传入字符串
 *
 */
+ (NSString *)base64:(NSString*)string;

/**
 *  @brief  base64解密
 *
 *  @param  base64String 传入字符串
 *
 */
+ (NSString *)encodebase64:(NSString*)base64String;

/**
 *  @brief  对字符串进行MD5加密 （大写）
 *
 *  @param  string 传入字符串
 *
 */
+ (NSString *)md5Uppercase:(NSString *)string;

/**
 *  @brief  对字符串进行MD5加密 （小写）
 *
 *  @param  string 传入字符串
 *
 */
+ (NSString *)md5Lowercase:(NSString *)string;

/**
 *  @brief  URLEncoded编码
 *
 *  @param  url 传入字符串
 *
 */
+ (NSString *)URLEncodedString:(NSString*)url;

/**
 *  @brief  避免获取空字符串
 *
 *  @param  string 传入字符串
 *
 */
+ (NSString *)getNoneEmptyStringWithString:(NSString *)string;

/**
 *  @brief  根据16进制字符串获取颜色值，能调节透明度
 *
 *  @param  hexValue 传入的16进制数
 *
 *  @param  alphaValue 透明度
 *
 */
+ (UIColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue;

/**
 *  @brief  根据16进制字符串获取颜色值
 *
 *  @param  hexValue 传入的16进制数
 *
 */
+ (UIColor*)colorWithHex:(NSString *)hexValue;

/**
 *  @brief  压缩图片到指定大小
 *
 *  @param  targetSize 压缩后的大小
 *
 *  @param  sourceImage 需要压缩的图片
 *
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage*)sourceImage;

/**
 *  @brief  缩放uiimage
 *
 *  @param  size 缩放后的大小
 *
 *  @param  img 需要缩放的图片
 *
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *  @brief  图片截取方法
 *
 *  @param  rect 需要截取的位置和大小
 *
 *  @param  imageToCrop 需要截取的图片
 *
 */
+(UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect;

/**
 *  @brief  将推送token转换成字符串
 *
 *  @param  buffer token串
 *
 *  @param  buf_len token串的长度
 *
 */
+(NSString*) getRNToken:(const char* ) buffer length:(int)buf_len;

/**
 *  @brief  身份号是否合法
 *
 *  @param  cardNo 身份证号
 *
 */
+ (BOOL) validateIdentityCard: (NSString *)cardNo;

/**
 *  @brief  根据号码，拨打电话
 *
 *  @param  telephoneNum  手机号
 *
 */
+ (void)makePhoneCall:(NSString *)telephoneNum;

/**
 *  @brief 返回给定日期是星期几
 *
 *  @return 返回值为“周一、周二、周三、周四、周五、周六、周日”
 */
+(NSString *)changedStringToWeak:(NSString *)timestamp;
/**
 *  @brief 返回年-月-日
 *
 *  @return 返回值为“2015-12-24”
 */
+ (NSString *)yearMonthDayWithString:(NSString *)time;
/**
 *  @brief 返回年-月-日-时-分-秒
 *
 *
 *  @return 返回值为“2015-12-24 15:21:50”
 */
+ (NSString *)yearMontrhDayHourMinatueScend:(NSString *)time;
/**
 *  @brief 返回年-月-日
 *
 *  @return 返回值为“2015-12-24”
 */
+(NSString *)getCurrenttime;

/**
 *  自动计算文本高度(Lable自动换行并且自适应)
 *
 *  @param text      字符串
 *  @param fontSize  字体大小
 *  @param textWidth 宽度
 *
 *  @return 返回size
 */
+(CGSize )getTextSizeWithText:(NSString *)text WithFont:(CGFloat)fontSize WithTextWidth:(CGFloat)textWidth;
/**
 *  自动计算文本高度(Lable自动换行并且自适应)
 *
 *  @param text      字符串
 *  @param  fontNew 字体
 *  @param textWidth 宽度
 *
 *  @return 返回size
 */
+(CGSize )getTextSizeWithText:(NSString *)text AndFont:(UIFont *)fontNew WithTextWidth:(CGFloat)textWidth;

/**
 *  通用的alertView
 *
 *  @param message alertView显示的message
 */
+ (void)alertViewWithMessage:(NSString *)message;


/**
 *  alertView扩展
 *左边按钮红色，右边按钮黑色
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
                otherTitle:(NSString *)otherTitle
                completion:(JFToolsAlertBlock)completion;

//左边按钮黑色，右边按钮红色
+ (void)showAlertYYFWithTitle:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   otherTitle:(NSString *)otherTitle
                   completion:(JFToolsAlertBlock)completion;
/**
 *  根据字数，随机生成验证码（数字和字母的组合）
 *
 *  @param charNum 生成的字符串的长度
 *
 *  @return 返回验证码
 */
+ (NSString*)getRandomAuthCodeWithCharNum:(NSInteger)charNum;


/**
 *  判断字符串是否为纯字符（字母、数字、中文）（不包含半角和全角特殊字符）
 *
 *  @param str 待验证的字符串
 *
 *  @return 返回是否符合所需格式
 */
+(BOOL)checkIsWorldIncludeChinese:(NSString *)str;

@end


/**********  Doucument   **********/

@interface JFTools (Doucument)

+(NSString *)documentDirectory;
+(NSString *)createDirectoryInDocumentDirectory:(NSString *)pathName;
+(NSString *)createFileInDocumentDirectory:(NSString *)fileName;

@end


/**********  Runtime   **********/
@interface JFTools (Runtime)

/**
 *  打印一个类的所有实例变量名
 *
 *  @param cls 指定的类
 */
+ (void)printIvarListForClass:(Class)cls;

@end

/**********  UIUtil   **********/
@interface JFTools (UIUtil)

+ (CGFloat)labelWidthWithText:(NSString*)str minWidth:(CGFloat)minWidth;

+ (CGFloat)labelHeightWithText:(NSString*)str
                          size:(int)size
                         width:(CGFloat)width
                      richText:(BOOL)richText;

+ (CGFloat)labelHeightWithText:(NSString*)str
                          size:(int)size
                         width:(CGFloat)width
                      richText:(BOOL)richText
                       maxLine:(NSInteger)maxLine;

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            maxWidth:(CGFloat)maxWidth
                       lineBreakMode:(NSLineBreakMode)breakMode;

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            minWidth:(CGFloat)minWidth
                       lineBreakMode:(NSLineBreakMode)breakMode;

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            maxWidth:(CGFloat)maxWidth;

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            minWidth:(CGFloat)minWidth;

+ (CGFloat)labelHeightWithAttributeText:(NSMutableAttributedString *)str
                                  width:(CGFloat)width;

@end

/**********  Formate   **********/
@interface JFTools (Formate)

+ (NSString *)stringForTimeIntervalStr:(NSString *)timeIntervalString
                           withFormate:(NSString *)formate;

//获取当天0点的date
+ (NSDate *)zeroDateOfCurrentDay;

//从json文件中读取json数据
+ (id)getJsonObjectFromJsonFile:(NSString *)jsonFileName;

// 截取URL中的参数
+ (NSMutableDictionary *)getURLParametersFromURL:(NSString *)urlStr;
@end
