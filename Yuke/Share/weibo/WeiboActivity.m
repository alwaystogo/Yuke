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

- (void)shareImageWithImage:(UIImage *)image{
    
    UIImage *shareImage = image;
    
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

//- (void)shareVideoWithVideoUrl:(NSURL *)videoUrl{
//    WBMessageObject *message = [WBMessageObject message];
//    
//    WBVideoObject *videoObject = [WBVideoObject object];
//    videoObject.objectID = @"33333";
//    videoObject.title = @"1";
//    videoObject.description = @"";
//    //videoObject.thumbnailData = paramObj.param5;
//    videoObject.videoUrl = [videoUrl absoluteString];
//    videoObject.videoStreamUrl = [videoUrl absoluteString];
//    
//    message.mediaObject = videoObject;
//    
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = @"https://www.sina.com";
//    authRequest.scope = @"all";
//    
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
//    [WeiboSDK sendRequest:request];
//
//    //[WeiboSDK sendRequest:[WBSendMessageToWeiboRequest requestWithMessage:message]];
//}

- (void)shareVideoWithVideoUrl:(NSURL *)videoUrl{
    
    WBMessageObject *message = [WBMessageObject message];
    
    WBNewVideoObject *videoObject = [WBNewVideoObject object];
    //videoObject.isShareToStory = YES;
    videoObject.delegate = self;
    [videoObject addVideo:videoUrl];
    
    message.videoObject = videoObject;
    
    self.messageObject = message;
    
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = @"https://www.sina.com";
//    authRequest.scope = @"all";
//    
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
//    [WeiboSDK sendRequest:request];
    
    //[WeiboSDK sendRequest:[WBSendMessageToWeiboRequest requestWithMessage:message]];
}

#pragma delegate
-(void)wbsdk_TransferDidReceiveObject:(id)object
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://www.sina.com";
    authRequest.scope = @"all";
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];

    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:self.messageObject authInfo:authRequest access_token:myDelegate.wbtoken];
//    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

}

-(void)wbsdk_TransferDidFailWithErrorCode:(WBSDKMediaTransferErrorCode)errorCode andError:(NSError*)error{
    
}

//- (void)shareVideoWithVideoUrl:(NSURL *)videoUrl{
//    
//    NSString *shareTitleString =@"视频";
//    NSString *shareDescriptionString = @"";
//    NSString *shareUrlString = [videoUrl absoluteString];
//    
//    UIImage *image = ImageNamed(@"分享");
//    
//    NSData *imageData = UIImagePNGRepresentation(image);
//    
//    WBMessageObject *message = [WBMessageObject message];
//    message.text = [[[shareTitleString stringByAppendingString:@"--"] stringByAppendingString:shareDescriptionString] stringByAppendingString:shareUrlString];
//    
//    WBImageObject *wbImage = [WBImageObject object];
//    wbImage.imageData = imageData;
//    message.imageObject = wbImage;
//    
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = @"https://www.sina.com";
//    authRequest.scope = @"all";
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
//    [WeiboSDK sendRequest:request];
//
//}

@end
