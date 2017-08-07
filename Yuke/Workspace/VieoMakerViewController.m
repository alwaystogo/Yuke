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
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "CGPlayer.h"
#import "XSMediaPlayer.h"

#import "VideoManager.h"

@interface VieoMakerViewController ()

@end

@implementation VieoMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(300, 150, 50, 30);
    [btn4 setTitle:@"播放" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor grayColor];
    [btn4 addTarget:self action:@selector(clickBofangBtnActiton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 100, 100, 30);
    [btn3 setTitle:@"相册选择" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor grayColor];
    [btn3 addTarget:self action:@selector(selectThreeKuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 150, 100, 30);
    [btn setTitle:@"裁剪+水印+拼接" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(clickBtnActiton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 200, 200)];
    [self.view addSubview:_imageView];
}

- (void)clickBofangBtnActiton{
    
    _videoPlayer = [[XSMediaPlayer alloc] initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH - 20, 250)];
    _videoPlayer.videoURL = self.videoUrl;
    [self.view addSubview:_videoPlayer];
    
    //总秒数
    CGFloat total   = (CGFloat)_videoPlayer.playerItme.duration.value / _videoPlayer.playerItme.duration.timescale;
    SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(10, 400, [UIScreen mainScreen].bounds.size.width-20, 270) minValue:0 maxValue:total blockSpaceValue:2];
    slider.progressRadius = 5;
    [slider.minIndicateView setTitle:@"0:00"];
    [slider.maxIndicateView setTitle:[NSString stringWithFormat:@"0:%.2f",total]];
    slider.lightColor = [UIColor yellowColor];
    slider.minIndicateView.backIndicateColor = [UIColor greenColor];
    slider.maxIndicateView.backIndicateColor = [UIColor greenColor];
    //    slider.indicateViewOffset = 10;
    //    slider.indicateViewWidth = 80;
    slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        
        
    };
    
    slider.getMinTitle = ^NSString *(CGFloat minValue) {
        if (floor(minValue) == 0.f) {
            return @"不限";
        }else{
            return [NSString stringWithFormat:@"%.fK",floor(minValue)];
        }
        
    };
    
    slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
        if (floor(maxValue) == 80.f) {
            return @"不限";
        }else{
            return [NSString stringWithFormat:@"%.fK",floor(maxValue)];
        }
    };
    [self.view addSubview:slider];
}

//方式一：
-  (void)selectThreeKuAction{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    
    //展示相册中的视频
    imagePickerVc.allowPickingVideo = YES;
    //不展示图片
    imagePickerVc.allowPickingImage = NO;
    //不显示原图选项
    imagePickerVc.allowPickingOriginalPhoto = NO;
    //按时间排序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    //选择完视频之后的回调
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage,id asset){
        
        self.imageView.image = coverImage;
        //iOS8以后返回PHAsset
        PHAsset *phAsset = asset;
        
        if (phAsset.mediaType == PHAssetMediaTypeVideo) {
            //从PHAsset获取相册中视频的url
            PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                
                NSURL *url = urlAsset.URL;
                self.videoUrl = url;
                NSLog(@"%@",url);
            }];
        }
    }];
    [kCurNavController presentViewController:imagePickerVc animated:YES completion:nil];
}

//测试的
- (void)clickBtnActiton2{
    
    //    NSURL * videoUrl = [NSURL URLWithString:@"http://flv3.bn.netease.com/videolib3/1707/31/NVeMJ1940/SD/NVeMJ1940-mobile.mp4"];
    
    VideoManager *mangerV = [[VideoManager alloc] init];
    [mangerV cropWithVideoUrlStr:self.videoUrl start:3 end:20 completion:^(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"裁剪视频成功");
            
            if (isSuccess) {
                NSURL *pathUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfH" ofType:@"MOV"]];
                [mangerV addFirstVideo:outputURL andSecondVideo:pathUrl withMusic:nil completion:^(NSURL *outputURL, BOOL isSuccess) {
                    
                    if (isSuccess) {
                        NSLog(@"视频合成成功");
                        [self writeVideoToPhotoLibrary:outputURL];
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [JFTools showFailureHUDWithTip:@"视频合成失败"];
                        });
                        
                    }
                    
                }];
            }
        }
        }];
}

- (void)clickBtnActiton{
    
//    NSURL * videoUrl = [NSURL URLWithString:@"http://flv3.bn.netease.com/videolib3/1707/31/NVeMJ1940/SD/NVeMJ1940-mobile.mp4"];
    
    VideoManager *mangerV = [[VideoManager alloc] init];
    [mangerV cropWithVideoUrlStr:self.videoUrl start:3 end:20 completion:^(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"裁剪视频成功");
            
            
            [mangerV AVsaveVideoPath:outputURL WithWaterImg:ImageNamed(@"pengyouquan") WithCoverImage:ImageNamed(@"QQ") WithQustion:@"这个水印加的棒不棒" WithFileName:@"shuiyin" completion:^(NSURL *outputURL, BOOL isSuccess) {
                
                if (isSuccess) {
                    NSURL *pathUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfH" ofType:@"MOV"]];
                    [mangerV addFirstVideo:outputURL andSecondVideo:pathUrl withMusic:nil completion:^(NSURL *outputURL, BOOL isSuccess) {
                        
                        if (isSuccess) {
                            NSLog(@"视频合成成功");
                            [self writeVideoToPhotoLibrary:outputURL];
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [JFTools showFailureHUDWithTip:@"视频合成失败"];
                            });
                            
                        }
                    }];
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [JFTools showTipOnHUD:@"添加水印失败"];

                    });

                }
            }];
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                 [JFTools showTipOnHUD:@"裁剪视频失败"];
            });

        };
    }];
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
