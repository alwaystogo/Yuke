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
    
    if (activityItems.count == 1) {
        
        UIImage *shareImage = activityItems.firstObject;
        
        if (![shareImage isMemberOfClass:[UIImage class]]) {
            return;
        }
        
        NSData *imageData = UIImageJPEGRepresentation(shareImage, 1.0);
        
        WBMessageObject *message = [WBMessageObject message];
        
        WBImageObject *wbImage = [WBImageObject object];
        wbImage.imageData = imageData;
        message.imageObject = wbImage;
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"https://www.sina.com";
        authRequest.scope = @"all";
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
        [WeiboSDK sendRequest:request];
        
        return;
    }
    
    
    if (activityItems.count < 4) {
        return;
    }
    
    NSString *shareTitleString = [activityItems firstObject];
    NSString *shareDescriptionString = activityItems[1];
    NSString *shareUrlString = activityItems[2];
    
    UIImage *image = [activityItems lastObject];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = [[[shareTitleString stringByAppendingString:@"--"] stringByAppendingString:shareDescriptionString] stringByAppendingString:shareUrlString];
    
    WBImageObject *wbImage = [WBImageObject object];
    wbImage.imageData = imageData;
    message.imageObject = wbImage;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
}



@end
