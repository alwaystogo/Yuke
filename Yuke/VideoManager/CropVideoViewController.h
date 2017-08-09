//
//  CropVideoViewController.h
//  VideoEditDemo
//
//  Created by Damon on 2017/5/13.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropVideoViewController : UIViewController

//裁剪视频  hudongdong
- (void)saveVideoPath:(NSURL*)videoPath withStartTime:(float)startTime withEndTime:(float)endTime withSize:(CGSize)videoSize withVideoDealPoint:(CGPoint)videoDealPoint WithFileName:(NSString*)fileName shouldScale:(BOOL)shouldScale completion:(void (^)(NSURL *outputURL, BOOL isSuccess))completionHandle;
@end
