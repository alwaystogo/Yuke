//
//  WeiboActivity.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/7/5.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "WeiboActivity.h"
#import "WeiboSDK.h"

@implementation WeiboActivity


+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

-(NSString *)activityType
{
    return @"Share";
}

- (NSString *)activityTitle
{
    return @"新浪微博";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"folder_detail_weibo"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)activityDidFinish:(BOOL)completed
{
    
}

-(void)prepareWithActivityItems:(NSArray *)activityItems{
    
    if (activityItems.count < 4) {
        return;
    }
    
    NSString *shareTitleString = [activityItems firstObject];
    NSString *shareDescriptionString = activityItems[1];
    NSString *shareUrlString = activityItems[2];
    
    UIImage *image = [activityItems lastObject];
    
    // 分享的图片大小不能超过32k
    CGSize imageSize = image.size;
    
    if (imageSize.width > 100) {
        imageSize = CGSizeMake(100, imageSize.height);
    }
    
    if (imageSize.height > 100) {
        imageSize = CGSizeMake(imageSize.width, 100);
    }
    
    UIGraphicsBeginImageContext(imageSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = shareTitleString;
    
    WBWebpageObject *webpage = [WBWebpageObject object];
    
    webpage.title = shareTitleString;
    webpage.description = shareDescriptionString;
    webpage.thumbnailData = imageData;
    webpage.webpageUrl = shareUrlString;
    
    message.mediaObject = webpage;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
}



@end
