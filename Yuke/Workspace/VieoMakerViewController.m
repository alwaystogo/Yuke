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
#import "SavePicAndVideoViewController.h"

@interface VieoMakerViewController ()

@end

@implementation VieoMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.title = @"编辑";
    [self setLeftBackNavItem];
    // Do any additional setup after loading the view.
    
    self.selectBkView = [[UIView alloc] init];
    self.selectBkView.backgroundColor = COLOR_HEX(0x999999, 1);
    [self.view addSubview:self.selectBkView];
    [self.selectBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(200);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = ImageNamed(@"shipinbofang");
    imageView.userInteractionEnabled = YES;
    [self.selectBkView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBkView.mas_centerY);
        make.centerX.equalTo(self.selectBkView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(selectThreeKuAction)];
    [imageView addGestureRecognizer:tap];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"点击上传视频";
    label1.font = FONT_REGULAR(12);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.userInteractionEnabled = YES;
    [self.selectBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.centerX.equalTo(self.selectBkView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    // AVPlayer播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.videoPlayer.player.currentItem];

}

- (void)clickBofangBtnActiton{
    
    _videoPlayer = [[XSMediaPlayer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 450 * BiLi_SCREENHEIGHT_NORMAL)];
    _videoPlayer.videoURL = self.videoUrl;
    [self.view addSubview:_videoPlayer];
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //总秒数
        CGFloat total   = (CGFloat)_videoPlayer.playerItme.duration.value / _videoPlayer.playerItme.duration.timescale;
        weakSelf.maxTime = total;
        SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 130*BiLi_SCREENHEIGHT_NORMAL - 30, [UIScreen mainScreen].bounds.size.width-40, 130 *BiLi_SCREENHEIGHT_NORMAL) minValue:0 maxValue:total blockSpaceValue:1];
        slider.bkImageView.image = weakSelf.videoBkImage;
        slider.progressRadius = 5;
        [slider.minIndicateView setTitle:@"0:00"];
        [slider.maxIndicateView setTitle:[NSString stringWithFormat:@"0:%02.0f",total]];
        slider.lightColor = CLEARCOLOR;
        slider.minIndicateView.backIndicateColor = COLOR_HEX(0xffa632, 1);
        slider.maxIndicateView.backIndicateColor = COLOR_HEX(0xffa632, 1);
        slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
            
        };
        
        slider.getMinTitle = ^NSString *(CGFloat minValue) {
            weakSelf.minTime = minValue;
            CMTime scriptTime = CMTimeMakeWithSeconds(minValue, 600);
            [weakSelf.videoPlayer.player seekToTime:scriptTime completionHandler:^(BOOL finished) {
                NSLog(@"跳转到%f秒播放",minValue);
            }];
            if (floor(minValue) == 0.f) {
                return @"0:00";
            }else{
                return [NSString stringWithFormat:@"0:%02.0f",minValue];
            }
        
        };
        
        slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
            weakSelf.maxTime = maxValue;
            if (floor(maxValue) == total) {
                return [NSString stringWithFormat:@"0:%02.0f",total];
            }else{
                return [NSString stringWithFormat:@"0:%02.0f",maxValue];
            }
        };
        [self.view addSubview:slider];

        //视频播放的回调方法
        WeakSelf
        [self.videoPlayer.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(0.2, 600) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            
            float current=CMTimeGetSeconds(time);
            
            [slider setCurrentTime:current];//设置回调
            
            if (current >= weakSelf.maxTime) {
                [weakSelf moviePlayDidEnd:nil];
            }
       
        } ];

    });
}

//方式一：
-  (void)selectThreeKuAction{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    
     __weak TZImagePickerController *weakImagePickerVc = imagePickerVc;
    
    //展示相册中的视频
    imagePickerVc.allowPickingVideo = YES;
    //不展示图片
    imagePickerVc.allowPickingImage = NO;
    //不显示原图选项
    imagePickerVc.allowPickingOriginalPhoto = NO;
    //按时间排序
    imagePickerVc.sortAscendingByModificationDate = YES;
    WeakSelf
    //选择完视频之后的回调
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage,id asset){
        
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
               float second = urlAsset.duration.value / urlAsset.duration.timescale;
                if (second > 20.0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [JFTools showTipOnHUD:@"请选择小于20秒的视频"];
                        
                    });
                    return ;
                }
                //判断是不是微信录制的视频
                if (![weakSelf isWeXinVideo:urlAsset]) {
                    //移除
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.selectBkView removeFromSuperview];
                    });
                    
                    weakSelf.videoBkImage = coverImage;
                    weakSelf.videoUrl = url;
                    NSLog(@"%@",url);
                    //播放视频
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf setupRightNavButton:@"完成" withTextFont:FONT_REGULAR(16) withTextColor:COLOR_HEX(0xffa632, 1) target:weakSelf
                                               action:@selector(wanchengBtnAction)];
                        [weakSelf clickBofangBtnActiton];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [JFTools showTipOnHUD:@"请选择系统拍摄的视频"];
                    });
                }
                
            }];
        }
    }];
    [kCurNavController presentViewController:imagePickerVc animated:YES completion:nil];
}

//保存视频到相册
- (void)writeVideoToPhotoLibrary:(NSURL *)url
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    WeakSelf
    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error){
        if (error == nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.videoPlayer removeFromSuperview];
                SavePicAndVideoViewController *vc = [[SavePicAndVideoViewController alloc] init];
                vc.videoUrl = url;
                [kCurNavController pushViewController:vc animated:YES];
            });
//            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频保存成功" preferredStyle:UIAlertControllerStyleAlert];
//            
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            [weakSelf presentViewController:alert animated:true completion:nil];
            
        }else{
//            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频保存失败" preferredStyle:UIAlertControllerStyleAlert];
//            
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            [weakSelf presentViewController:alert animated:true completion:nil];
        }
    }];
}

#pragma mark - NSNotification Action
// 播放完了
- (void)moviePlayDidEnd:(NSNotification *)notification
{
    WeakSelf
    NSLog(@"播放完了");
    CMTime scriptTime = CMTimeMakeWithSeconds(self.minTime, 600);
    [self.videoPlayer.player seekToTime:scriptTime completionHandler:^(BOOL finished) {
        NSLog(@"跳转到%f秒播放",weakSelf.minTime);
        [weakSelf.videoPlayer.player play];
    }];

}
- (void)wanchengBtnActionyoupinjie{
    
//    WeakSelf
//    VideoManager *mangerV = [[VideoManager alloc] init];
//    [mangerV cropWithVideoUrlStr:self.videoUrl start:self.minTime end:self.maxTime completion:^(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"裁剪视频成功");
//            
//            [mangerV AVsaveVideoPath:outputURL WithWaterImg:ImageNamed(@"pengyouquan") WithCoverImage:ImageNamed(@"QQ") WithQustion:@"这个水印加的棒不棒" WithFileName:@"shuiyin" completion:^(NSURL *outputURL, BOOL isSuccess) {
//                
//                if (isSuccess) {
//                    NSURL *pathUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfH" ofType:@"MOV"]];
//                    [mangerV addFirstVideo:outputURL andSecondVideo:pathUrl withMusic:nil completion:^(NSURL *outputURL, BOOL isSuccess) {
//                        
//                        if (isSuccess) {
//                            NSLog(@"视频合成成功");
//                            [weakSelf writeVideoToPhotoLibrary:outputURL];
//                            //上传视频
//                            [weakSelf shangChuanVideoWith:outputURL];
//                        }else{
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [JFTools showFailureHUDWithTip:@"视频合成失败"];
//                            });
//                            
//                        }
//                    }];
//                    
//                }else{
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [JFTools showTipOnHUD:@"添加水印失败"];
//                        
//                    });
//                    
//                }
//            }];
//            
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [JFTools showTipOnHUD:@"裁剪视频失败"];
//            });
//            
//        };
//    }];
    
    
}

- (void)wanchengBtnAction{
    
//    [self shangChuanVideoWith:self.videoUrl];
//    return;
    WeakSelf
    [JFTools showLoadingHUD];
    VideoManager *mangerV = [[VideoManager alloc] init];
    [mangerV cropWithVideoUrlStr:self.videoUrl start:self.minTime end:self.maxTime completion:^(NSURL *outputURL, Float64 videoDuration, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"裁剪视频成功");
            
            [mangerV AVsaveVideoPath:outputURL WithWaterImg:ImageNamed(@"水印1") WithInfoDic:weakSelf.infoDic WithFileName:@"shuiyin" completion:^(NSURL *outputURL, BOOL isSuccess) {
                    if (isSuccess) {
                        NSLog(@"水印合成成功");
                        
                        //上传视频和保存到相册
                        [weakSelf shangChuanVideoWith:outputURL];
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [JFTools showFailureHUDWithTip:@"视频不符合要求，换个视频试试吧"];
                        });
                        
                    }

            }];
                }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [JFTools showTipOnHUD:@"视频不符合要求，换个视频试试吧"];
            });
            
        };
    }];
    

}

- (void)dealloc{
    
     [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"dealloc 关闭了");
}

//判断是否是微信录制的视频
- (BOOL)isWeXinVideo:(AVURLAsset *)urlAsset{
    
    bool isWXVideo = false;
    for (int i=0; i<urlAsset.metadata.count; i++) {
        AVMetadataItem * item = [urlAsset.metadata objectAtIndex:i];
        //NSLog(@"======metadata:%@,%@,%@,%@",item.identifier,item.extraAttributes,item.value,item.dataType);
        NSDictionary *dic = [self StrToArrayOrNSDictionary:[NSString stringWithFormat:@"%@",item.value]];
        //WXVer 是微信的标志
        if ([dic isKindOfClass:[NSDictionary class]]) {
            if ([[dic.allKeys objectAtIndex:0] isEqualToString: @"WXVer"]) {
                isWXVideo = true;
            };
        }
        
    }

        return isWXVideo;
}
// 将JSONDATA转化为字典或者数组
- (id)DataToArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}
// 将JSON串转化为字典或者数组
- (id)StrToArrayOrNSDictionary:(NSString *)jsonStr {
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [self DataToArrayOrNSDictionary:jsonData];
}

//- (void)shangChuanVideoWith:(NSURL *)url{
//
//
//    WeakSelf
//     [weakSelf writeVideoToPhotoLibrary:url];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
//        //[JFTools showLoadingHUD];
//        //先保存到相册
//
//        NSString *beginUrl = @"index.php/Api/Card/video_upload";
//      NSString *urlString = [beginUrl  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [kJFClient uploadVideoWithMethod:urlString param:dic videoUrl:url paramName:@"image" success:^(NSURLSessionDataTask *task, id responseObject) {
//            [JFTools showSuccessHUDWithTip:@"上传成功"];
//            [weakSelf.videoPlayer removeFromSuperview];
//            SavePicAndVideoViewController *vc = [[SavePicAndVideoViewController alloc] init];
//            vc.videoUrl = url;
//            [kCurNavController pushViewController:vc animated:YES];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [JFTools showFailureHUDWithTip:error.localizedDescription];
//        }];
//    });
//
//}
- (void)shangChuanVideoWith:(NSURL *)url{
    
    
    WeakSelf
    [weakSelf writeVideoToPhotoLibrary:url];
   
        NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
        
        VideoManager *videoServer = [[VideoManager alloc] init];
        [videoServer compressVideo:url andVideoName:@"23384" andSave:NO successCompress:^(NSURL *newUrl) {
           
            if (newUrl == nil) {
                NSLog(@"压缩未成功");
            }else{
                NSString *beginUrl = @"index.php/Api/Card/video_upload";
                NSString *urlString = [beginUrl  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [kJFClient uploadVideoWithMethod:urlString param:dic videoUrl:newUrl paramName:@"image" success:^(NSURLSessionDataTask *task, id responseObject) {
                    //[JFTools showSuccessHUDWithTip:@"上传成功"];
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    //[JFTools showFailureHUDWithTip:error.localizedDescription];
                }];
            }
        }];
}
@end
