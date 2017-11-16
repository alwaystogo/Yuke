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
- (void)AVsaveVideoPath:(NSURL*)videoPath WithWaterImg:(UIImage*)img WithInfoDic:(NSDictionary*)infoDic WithFileName:(NSString*)fileName completion:(void (^)(NSURL *outputURL, BOOL isSuccess))completionHandle;

//视频合成，添加背景音乐
-(void)addFirstVideo:(NSURL*)firstVideoPath andSecondVideo:(NSURL*)secondVideo withMusic:(NSURL*)musicPath completion:(void (^)(NSURL *outputURL, BOOL isSuccess))completionHandle;

//视频裁剪
- (void)cropWithVideoUrlStr:(NSURL *)videoUrl start:(CGFloat)startTime end:(CGFloat)endTime completion:(void (^)(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess))completionHandle;


//新加的
/// 压缩视频
///视频名字
@property (nonatomic,strong) NSString *videoName;

-(void)compressVideo:(NSURL *)path andVideoName:(NSString *)name andSave:(BOOL)saveState
     successCompress:(void(^)(NSURL *))newUrl;

/// 获取视频的首帧缩略图
- (UIImage *)imageWithVideoURL:(NSURL *)url;

@end
