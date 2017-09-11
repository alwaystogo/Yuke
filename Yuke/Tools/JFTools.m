//
//  JFTools.m
//  LinkFinance
//
//  Created by yangyunfei on 16/5/25.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFTools.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

static UILabel *label = nil;
static dispatch_once_t onceToken;

@implementation JFTools


#pragma mark 验证是否合法密码(6-12位数字或英文字符)
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

#pragma mark 验证手机号是否合法
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以 30~139  145,147 15[012356789] 176,177,178 180~189
    //NSString *phoneRegex = @"^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    //    NSLog(@"phoneTest is %@",phoneTest);
    
    if(mobile.length==11 && [[mobile substringToIndex:1] intValue]==1){
        return YES;
    }else{
        return NO;
    }
    
    
    //return [phoneTest evaluateWithObject:mobile];
}

+(BOOL)checkIsNum:(NSString *)str{
    //    NSString *num = @"^[0-9]+\\.{0,1}[0-9]{0,2}$";
    NSString *num = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    return res;
}

+(BOOL)checkIsWorld:(NSString *)str{
    NSString *num = @"^[a-z]+$";//@"^[A-Za-z]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    return res;
}

//判断字符串是否为纯字符（字母、数字、中文）（不包含半角和全角特殊字符）
+(BOOL)checkIsWorldIncludeChinese:(NSString *)str{
//    NSString *num = @"^(?!_)(?!.*?_$)(?![\uFF00-\uFFEF])[a-zA-Z0-9\u4E00-\u9FA5\uF900-\uFA2D]+$";
//    NSString *num = @"^[a-zA-Z0-9\u4E00-\u9FA5\uF900-\uFA2D][^\uFF00-\uFFEF]+$";
    NSString *num = @"^[a-zA-Z0-9\u4E00-\u9FA5\uF900-\uFA2D]+$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    return res;
}

+(BOOL)checkIsWorldAndNum:(NSString *)str{
    NSString *num = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_]+$";//@"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";//@"^[0-9]+\\.{0,1}[0-9]{0,2}$^[a-z]+$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    
    return res;
}

+(BOOL)checkIsEmail:(NSString*)str{
    BOOL ret=NO;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    ret = [emailTest evaluateWithObject:str];
    return ret;
}

+ (NSString *)base64:(NSString*)abc
{
    // Create NSData object
    NSData *nsdata = [abc dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    return base64Encoded;
}

+ (NSString *)encodebase64:(NSString*)base64String{
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", decodedString);
    
    return decodedString;
}
//输出大写
+ (NSString *)md5Uppercase:(NSString *)string{
    
    //string = [string uppercaseString];
    
    const char* original_str = [string UTF8String];
    
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [outPutStr appendFormat:@"%02X", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    //NSLog(@"toMD5Str : %@\nMD5Str : %@",string, [outPutStr uppercaseString]);
    
    return [outPutStr uppercaseString];
}

//输出小写
+ (NSString *)md5Lowercase:(NSString *)string{
    
    //string = [string lowercaseString];
    
    const char* original_str = [string UTF8String];
    
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    //NSLog(@"toMD5Str : %@\nMD5Str : %@",string, [outPutStr lowercaseString]);
    
    return [outPutStr lowercaseString];
}

+ (NSString *)URLEncodedString:(NSString*)url
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    NSLog(@"encodedString:%@", encodedString);
    return encodedString;
}


+ (NSString *)getNoneEmptyStringWithString:(NSString *)string
{
    return (string==nil?@"":string);
}


+ (UIColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue
{
    char *stopstring;
    long hex = strtol([hexValue cStringUsingEncoding:NSUTF8StringEncoding], &stopstring, 16);
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHex:(NSString *)hexValue{
    char *stopstring;
    long hex = strtol([hexValue cStringUsingEncoding:NSUTF8StringEncoding], &stopstring, 16);
    int r, g, b;
    r = ( 0xff <<16 & hex ) >> 16;
    g = ( 0xff <<8 & hex ) >> 8;
    b = 0xff & hex;
    return [UIColor colorWithRed:(0.0f + r)/255 green:(0.0f + g)/255 blue:(0.0f + b)/255 alpha:1.0];
}

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage*)sourceImage
{
    if (!sourceImage) {
        return nil;
    }
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

+(NSString*) getRNToken:(const char* ) buffer length:(int)buf_len {
    char hexchar[] = "0123456789ABCDEF";
    size_t i;
    char *p;
    int len = (buf_len * 2) + 1;
    p = malloc(len);
    for (i = 0; i < buf_len; i++) {
        p[i * 2] = hexchar[(unsigned char)buffer[i] >> 4 & 0xf];
        p[i * 2 + 1] = hexchar[((unsigned char)buffer[i] ) & 0xf];
    }
    p[i * 2] = '\0';
    NSString * result = [NSString stringWithCString:p encoding:NSUTF8StringEncoding];
    free(p);
    return result;
}

+ (BOOL) isChildWithBirthday:(NSString *)birthday travelDay:(NSString*)travelDay
{
    NSInteger birthYear=[[birthday substringToIndex:4] integerValue];
    birthYear+=12;
    NSString *adultDay=[NSString stringWithFormat:@"%ld%@",(long)birthYear,[birthday substringFromIndex:4]];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *adultDate=[dateFormatter dateFromString:adultDay];
    NSDate *travelDate=[NSDate date];
    if (travelDay && travelDay.length>0) {
        travelDate=[dateFormatter dateFromString:travelDay];
    }
    NSLog(@"adultDate = %@ travelDate = %@",adultDate,travelDate);
    return [adultDate compare:travelDate]>0;
}

+ (BOOL) validateIdentityCard: (NSString *)cardNo
{
    
    NSString *idCard = cardNo;
    
    idCard = [idCard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!idCard) {
        return NO;
    }
    else {
        length = idCard.length;
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    
    // 省份代码
    
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [idCard substringToIndex:2];
    
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        
        return false;
    }
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    int year = 0;
    
    switch (length) {
        case 15:
            year = [idCard substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:idCard
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCard.length)];
            if( numberofMatch > 0 ) {
                return YES;
            }
            else {
                return NO;
            }
            
        case 18:
            year = [idCard substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
                
            }
            else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCard
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCard.length)];
            if(numberofMatch >0) {
                int S = ([idCard substringWithRange:NSMakeRange(0,1)].intValue + [idCard substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([idCard substringWithRange:NSMakeRange(1,1)].intValue + [idCard substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([idCard substringWithRange:NSMakeRange(2,1)].intValue + [idCard substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([idCard substringWithRange:NSMakeRange(3,1)].intValue + [idCard substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([idCard substringWithRange:NSMakeRange(4,1)].intValue + [idCard substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([idCard substringWithRange:NSMakeRange(5,1)].intValue + [idCard substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([idCard substringWithRange:NSMakeRange(6,1)].intValue + [idCard substringWithRange:NSMakeRange(16,1)].intValue) *2 + [idCard substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCard substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCard substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                if ([M isEqualToString:[idCard substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                }
                else {
                    return NO;
                }
                
            }
            else {
                return NO;
            }
            
        default:
            return false;
    }
    
}

+(CGSize )getTextSizeWithText:(NSString *)text WithFont:(CGFloat)fontSize WithTextWidth:(CGFloat)textWidth
{
    //Lable自动换行并且自适应
    // 列宽度
    CGFloat contentWidth = textWidth;
    // 用何種字體進行顯示
    UIFont *font         = [UIFont systemFontOfSize:fontSize];
    // 該行要顯示的內容
    NSString *content    = text;
    // 計算出顯示完內容需要的最小尺寸
    /*
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
     paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
     NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
     CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 1334) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
     
     */
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 10000)  options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    CGSize endSize = CGSizeMake(size.width, size.height);
    return endSize;
}
+(CGSize )getTextSizeWithText:(NSString *)text AndFont:(UIFont *)fontNew WithTextWidth:(CGFloat)textWidth{
    //Lable自动换行并且自适应
    // 列宽度
    CGFloat contentWidth = textWidth;
    // 該行要顯示的內容
    NSString *content    = text;
    // 計算出顯示完內容需要的最小尺寸
    
    UIFont *font = fontNew;
    /*
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
     paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
     NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
     CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 1334) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
     
     */
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 10000)  options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    CGSize endSize = CGSizeMake(size.width, size.height);
    return endSize;
}
+ (void)makePhoneCall:(NSString *)telephoneNum
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",telephoneNum]];
    [[UIApplication sharedApplication] openURL:phoneURL];
    
}


+ (NSArray *)reverseBackProvince
{
    
    //获取到存储本地的字典
    NSString *filePath         = [[NSBundle mainBundle] pathForResource:@"cityOfIndex" ofType:@"plist"];
    NSDictionary *cityOfIndex  = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *indexArray        = [cityOfIndex.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    
    NSMutableArray * soureArray = [[NSMutableArray alloc] init];
    for (NSString * key in indexArray) {
        NSArray * cityOfIndexArray = [cityOfIndex objectForKey:key];
        for (NSString * city in cityOfIndexArray) {
            [soureArray addObject:city];
        }
    }
    
    NSArray * resultArray = [[NSArray alloc] initWithArray:soureArray];
    
    return resultArray;
    
}

//计算是周几
+(NSString *)changedStringToWeak:(NSString *)timestamp
{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger weekday = [components weekday];
#pragma clang diagnostic pop    
    
    NSString *weakString = @"";
    switch (weekday) {
        case 1:{
            weakString = @"周日";
        }
            
            break;
        case 2:{
            weakString = @"周一";
        }
            
            break;
        case 3:{
            weakString = @"周二";
        }
            
            break;
        case 4:{
            weakString = @"周三";
        }
            
            break;
        case 5:{
            weakString = @"周四";
        }
            
            break;
        case 6:{
            weakString = @"周五";
        }
            
            break;
        case 7:{
            weakString = @"周六";
        }
            
            break;
        default:
            break;
    }
    
    return weakString;
    
}
//返回年-月-日样式的时间
+ (NSString *)yearMonthDayWithString:(NSString *)time
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init] ;
    NSTimeZone *timeZone        = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
//返回年-月-日-时-分-秒样式的时间
+ (NSString *)yearMontrhDayHourMinatueScend:(NSString *)time
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init] ;
    //NSTimeZone *timeZone        = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //[formatter setTimeZone:timeZone];
    //这里需要除以1000，因为后台传过来的是毫秒，iOS中使用的是秒
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[time longLongValue]/1000];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)getCurrenttime
{
    
    NSDate *currentDate           =[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime   =[dateformatter stringFromDate:currentDate];
    
    return currentTime;
}

+ (void)alertViewWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
                otherTitle:(NSString *)otherTitle
                completion:(JFToolsAlertBlock)completion{
    
    PXAlertView *alert = [PXAlertView showAlertWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
     completion:^(BOOL cancelled, NSInteger buttonIndex) {
         if (completion) {
             completion(cancelled, buttonIndex);
         }
    }];
    //[alert setTapToDismissEnabled:NO];
    [alert useCommonStyle];
}

+ (void)showAlertYYFWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
                otherTitle:(NSString *)otherTitle
                completion:(JFToolsAlertBlock)completion{
    
    PXAlertView *alert = [PXAlertView showAlertWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
                                              completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                                  if (completion) {
                                                      completion(cancelled, buttonIndex);
                                                  }
                                              }];
    
    [alert setTitleColor:COLOR_HEX(0x333333, 1.0)];
    [alert setBackgroundColor:COLOR_HEX(0xffffff, 1)];
    [alert setMessageColor:COLOR_HEX(0x333333, 1.0)];
    [alert setCornerRadius:6.0];
    [alert setAllButtonsBackgroundColor:COLOR_HEX(0xffffff, 1.0)];
    [alert setCancelButtonTextColor:COLOR_HEX(0x333333, 1.0)];
    [alert setOtherButtonTextColor:COLOR_HEX(0xff4444, 1.0)];

}


//根据字数，随机生成验证码（数字和字母的组合）
+ (NSString*)getRandomAuthCodeWithCharNum:(NSInteger)charNum{
    
    //字符串素材
    static dispatch_once_t onceToken;
    static NSArray *charsArray = nil;
    dispatch_once(&onceToken, ^{
        if (charsArray == nil) {
            charsArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];

        }
    });
    
    NSString * authCodeStr = [[NSMutableString alloc] initWithCapacity:charNum];
    //随机从数组中选取需要个数的字符串，拼接为验证码字符串
    for (int i = 0; i < charNum; i++)
    {
        NSInteger index = arc4random() % (charsArray.count-1);
        NSString *tempStr = [charsArray objectAtIndex:index];
        authCodeStr = (NSMutableString *)[authCodeStr stringByAppendingString:tempStr];
    }
    return authCodeStr;
}

@end



/**********  Doucument   **********/
#pragma mark - JFTool+Doucument
@implementation JFTools (Doucument)

+(NSString *)documentDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)createDirectoryInDocumentDirectory:(NSString *)pathName
{
    NSString *doc = [JFTools documentDirectory];
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *path = [doc stringByAppendingPathComponent:pathName];
    if(![fileHandle fileExistsAtPath:path]) {
        NSError *error;
        if([fileHandle createDirectoryAtPath:path withIntermediateDirectories:false attributes:nil error:&error]) {
            
        }
        else {
            return nil;
        }
    }
    return path;
}

+(NSString *)createFileInDocumentDirectory:(NSString *)fileName
{
    
    NSString *doc = [JFTools documentDirectory];
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *path = [doc stringByAppendingPathComponent:fileName];
    if(![fileHandle fileExistsAtPath:path]) {
        if([fileHandle createFileAtPath:path contents:nil attributes:nil]) {
            
        }
        else {
            return nil;
        }
    }
    return path;
}

@end


#pragma mark - JFTool+Runtime
@implementation JFTools (Runtime)

+ (void)printIvarListForClass:(Class)cls{
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList(cls, &count);
    for (int i = 0 ; i < count; i++) {
        Ivar var = varList[i];
        printf("varName : %s\n",ivar_getName(var));
    }
}

@end

#pragma mark - JFTool+UIUtil

@implementation JFTools (UIUtil)

+ (CGFloat)labelWidthWithText:(NSString*)str minWidth:(CGFloat)minWidth{
    dispatch_once(&onceToken, ^{
        label = [UILabel new];
    });
    
    label.text = str;
    CGFloat width = label.intrinsicContentSize.width;
    return width < minWidth ? minWidth : width;
    
}

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            maxWidth:(CGFloat)maxWidth
                       lineBreakMode:(NSLineBreakMode)breakMode {
    dispatch_once(&onceToken, ^{
        label = [UILabel new];
    });
    label.text = str;
    label.font = [UIFont systemFontOfSize:size];
    label.lineBreakMode = breakMode;
    label.numberOfLines = 1;
    CGFloat width = label.intrinsicContentSize.width;
    if (maxWidth) {
        return width < maxWidth ? width : maxWidth;
    } else {
        return width;
    }
}

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            minWidth:(CGFloat)minWidth
                       lineBreakMode:(NSLineBreakMode)breakMode {
    dispatch_once(&onceToken, ^{
        label = [UILabel new];
    });
    label.text = str;
    label.font = [UIFont systemFontOfSize:size];
    label.lineBreakMode = breakMode;
    label.numberOfLines = 1;
    CGFloat width = label.intrinsicContentSize.width;
    if (minWidth) {
        return width > minWidth ? width : minWidth;
    } else {
        return width;
    }
}

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            maxWidth:(CGFloat)maxWidth{
    return [self oneLineLabelWidthWithText:str size:size maxWidth:maxWidth lineBreakMode:NSLineBreakByCharWrapping];
}

+ (CGFloat)oneLineLabelWidthWithText:(NSString*)str
                                size:(int)size
                            minWidth:(CGFloat)minWidth{
    return [self oneLineLabelWidthWithText:str size:size minWidth:minWidth lineBreakMode:NSLineBreakByCharWrapping];
}

+ (CGFloat)labelHeightWithText:(NSString*)str
                          size:(int)size
                         width:(CGFloat)width
                      richText:(BOOL)richText
                       maxLine:(NSInteger)maxLine {
    dispatch_once(&onceToken, ^{
        label = [UILabel new];
    });
    
    label.text = str;
    label.font = [UIFont systemFontOfSize:size];
    label.preferredMaxLayoutWidth = width;
    label.lineBreakMode = maxLine ? NSLineBreakByTruncatingTail : NSLineBreakByCharWrapping;
    label.numberOfLines = maxLine;
    [label setContentMode:UIViewContentModeTop];
    CGFloat height = label.intrinsicContentSize.height;
    // IOS9下富文本中文高度总是不够
    return isiOS9 && richText ? height + 2 : height;
    return height;
}

+ (CGFloat)labelHeightWithText:(NSString*)str
                          size:(int)size
                         width:(CGFloat)width
                      richText:(BOOL)richText {
    return [self labelHeightWithText:str size:size width:width richText:richText maxLine:0];
}

+ (CGFloat)labelHeightWithAttributeText:(NSMutableAttributedString *)str
                                  width:(CGFloat)width{
    dispatch_once(&onceToken, ^{
        label = [UILabel new];
    });
    label.attributedText = str;
    label.numberOfLines = 0;
    CGSize maxSize = [label sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return maxSize.height;
}

@end


@implementation JFTools (Formate)

+ (NSString *)stringForTimeIntervalStr:(NSString *)timeIntervalString
                           withFormate:(NSString *)formate{

    if (IsEmpty(timeIntervalString)) {
        return nil;
    }
    if (IsEmpty(formate)) {
        formate = @"yyyy-MM-dd";
    }
    NSTimeInterval timeInterval = timeIntervalString.doubleValue;
    if (timeIntervalString.length == 13) { //毫秒
        timeInterval /= 1000; //转换成秒数
    }
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    
    [formater setTimeZone:zone];
    
    [formater setDateFormat:formate];
    
    return [formater stringFromDate:date];
}

//获取当天0点的date
+ (NSDate *)zeroDateOfCurrentDay{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDate *currDate = [[NSDate alloc]init];
    
    NSDateComponents *components = [calender components:NSUIntegerMax fromDate:currDate];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calender dateFromComponents:components];
}

+ (id)getJsonObjectFromJsonFile:(NSString *)jsonFileName;{
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:nil];
    NSData *jsonData   = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject      = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    return JsonObject;
}

+ (NSMutableDictionary *)getURLParametersFromURL:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+ (UIFont *)fontWithSize:(NSInteger)size withType:(NSInteger)type{
    if (type == 0) {
        if (SCREEN_WIDTH == 320) {
            return FONT_REGULAR(size - 1);
        }
        if (SCREEN_WIDTH == 375) {
            return FONT_REGULAR(size);
        }
        if (SCREEN_WIDTH == 414) {
            return FONT_REGULAR(size);
        }
    }
    if (type == 1) {
        if (SCREEN_WIDTH == 320) {
            return FONT_MEDIUM(size - 1);
        }
        if (SCREEN_WIDTH == 375) {
            return FONT_MEDIUM(size);
        }
        if (SCREEN_WIDTH == 414) {
            return FONT_MEDIUM(size);
        }
    }
    
    if (type == 2) {
        if (SCREEN_WIDTH == 320) {
            return FONT_BOLD(size - 1);
        }
        if (SCREEN_WIDTH == 375) {
            return FONT_BOLD(size);
        }
        if (SCREEN_WIDTH == 414) {
            return FONT_BOLD(size);
        }
    }
    
    return nil;
}

@end


