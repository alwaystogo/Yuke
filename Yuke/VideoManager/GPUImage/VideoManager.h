//
//  VideoManager.h
//  Yuke
//
//  Created by yangyunfei on 2017/8/4.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoManager : NSObject

///使用AVfoundation添加水印
- (void)AVsaveVideoPath:(NSURL*)videoPath WithWaterImg:(UIImage*)img WithCoverImage:(UIImage*)coverImg WithQustion:(NSString*)question WithFileName:(NSString*)fileName completion:(void (^)(NSURL *outputURL, BOOL isSuccess))completionHandle;

//视频合成，添加背景音乐
-(void)addFirstVideo:(NSURL*)firstVideoPath andSecondVideo:(NSURL*)secondVideo withMusic:(NSURL*)musicPath completion:(void (^)(NSURL *outputURL, BOOL isSuccess))completionHandle;

//视频裁剪
- (void)cropWithVideoUrlStr:(NSURL *)videoUrl start:(CGFloat)startTime end:(CGFloat)endTime completion:(void (^)(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess))completionHandle;
@end
