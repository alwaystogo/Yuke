//
//  QQActivity.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/7/5.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "QQActivity.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation QQActivity

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
    return @"QQ好友";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"folder_detail_QQ"];
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
    
    QQApiNewsObject *urlObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareUrlString] title:shareTitleString description:shareDescriptionString previewImageData:UIImageJPEGRepresentation(image, 1.0)];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObj];
    //将内容分享到qq
    [QQApiInterface sendReq:req];
}

@end
