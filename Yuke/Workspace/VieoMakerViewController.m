//
//  VieoMakerViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "VieoMakerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import <Photos/PHPhotoLibrary.h>

@interface VieoMakerViewController ()

@end

@implementation VieoMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 保存视频到相册
    UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视频裁剪
- (void)cropWithVideoUrlStr:(NSURL *)videoUrl start:(CGFloat)startTime end:(CGFloat)endTime completion:(void (^)(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess))completionHandle
{
    AVURLAsset *asset =[[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    
    //获取视频总时长
    Float64 duration = CMTimeGetSeconds(asset.duration);
    
//    NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"dafei"];
//    NSURL *outputFileUrl = [NSURL fileURLWithPath:outputFilePath];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *outputPath = paths[0];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtPath:outputPath withIntermediateDirectories:YES attributes:nil error:nil];
    outputPath = [outputPath stringByAppendingPathComponent:@"output.mp4"];
    // Remove Existing File
    [manager removeItemAtPath:outputPath error:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
    {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]
                                               initWithAsset:asset presetName:AVAssetExportPresetPassthrough];
        
        NSURL *outputURL = [NSURL fileURLWithPath:outputPath];
    
        exportSession.outputURL =  outputURL;
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        CMTime start = CMTimeMakeWithSeconds(startTime, asset.duration.timescale);
        CMTime duration = CMTimeMakeWithSeconds(endTime - startTime,asset.duration.timescale);
        CMTimeRange range = CMTimeRangeMake(start, duration);
        exportSession.timeRange = range;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    NSLog(@"合成失败：%@", [[exportSession error] description]);
                    completionHandle(outputURL, endTime, NO);
                }
                    break;
                case AVAssetExportSessionStatusCancelled:
                {
                    completionHandle(outputURL, endTime, NO);
                }
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    //成功
                    completionHandle(outputURL, endTime, YES);
                    [self writeVideoToPhotoLibrary:outputURL];
                }
                    break;
                default:
                {
                    completionHandle(outputURL, endTime, NO);
                } break;
            }
        }];
    }
}

// 视频保存回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    
    if (error == nil) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频保存成功" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:true completion:nil];
        
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频保存失败" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
       [self presentViewController:alert animated:true completion:nil];
    }
}

//保存视频到相册
- (void)writeVideoToPhotoLibrary:(NSURL *)url
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error){
        if (error == nil) {
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频保存成功" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:true completion:nil];
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频保存失败" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
}

@end
