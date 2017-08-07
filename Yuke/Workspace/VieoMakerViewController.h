//
//  VieoMakerViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CGPlayer.h"
#import "XSMediaPlayer.h"
#import "SFDualWaySlider.h"

@interface VieoMakerViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)NSURL *videoUrl;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)XSMediaPlayer *videoPlayer;//bofangqi

@property(nonatomic,strong)SFDualWaySlider *slider;//huagan

@property(nonatomic,strong)UIView *selectBkView;

@end
