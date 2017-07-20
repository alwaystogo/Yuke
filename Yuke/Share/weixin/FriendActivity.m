//
//  FriendActivity.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/8.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "FriendActivity.h"
#import "WXApi.h"

@implementation FriendActivity

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
    return @"朋友圈";
}
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"朋友圈"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)activityDidFinish:(BOOL)completed
{
}

- (void)prepareWithActivityItems:(NSArray *)activityItems{

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
    req.scene = 1;                          // 1是朋友圈 0是微信消息发送
    [WXApi sendReq:req];
}

@end
