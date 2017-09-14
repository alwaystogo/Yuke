//
//  WeixinActivity.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/8.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "WeixinActivity.h"
#import "WXApi.h"

@implementation WeixinActivity

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
    return @"微信好友";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"weixin"];
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
    
    [self sendRequestWithImage:image title:shareTitleString description:shareDescriptionString urlString:shareUrlString];
}

- (void)sendRequestWithImage:(UIImage *) image title:(NSString *) title description:(NSString *) desc urlString:(NSString *) urlString{
    
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
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    
    message.title = title;
    
    message.description = desc;
    
    message.thumbData = imageData;
    
    WXWebpageObject *webPage = [WXWebpageObject object];
    webPage.webpageUrl = urlString;
    
    message.mediaObject = webPage;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = 0;
    [WXApi sendReq:req];
}

- (void)shareImageWithImage:(UIImage *)image{
    
    UIImage *shareImage = image;
    NSData *imageData = UIImageJPEGRepresentation(shareImage, 1.0);
    NSData *thumbData = UIImageJPEGRepresentation(shareImage, 0.1);
    
    // 控制缩略图大小不能超过32k
    if (thumbData.length > 32000) {
        
        CGSize imageSize = CGSizeMake(320, 568);
        
        UIGraphicsBeginImageContext(imageSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        [shareImage drawInRect:imageRect];
        UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        thumbData = UIImageJPEGRepresentation(thumbImage, 0.1);
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    
    message.thumbData = thumbData;
    
    WXImageObject *imageObject = [WXImageObject object];
    
    imageObject.imageData = imageData;
    
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = 0;                          // 1是朋友圈 0是微信消息发送
    [WXApi sendReq:req];
    return;
}

@end
