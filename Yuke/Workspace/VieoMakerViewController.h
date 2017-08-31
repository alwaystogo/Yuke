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
@property(nonatomic,strong)UIImage *videoBkImage;

@property(nonatomic,strong)XSMediaPlayer *videoPlayer;//bofangqi

@property(nonatomic,strong)SFDualWaySlider *slider;//huagan

@property(nonatomic,strong)UIView *selectBkView;

@property(nonatomic,assign)CGFloat minTime;//选择的开始时间
@property(nonatomic,assign)CGFloat maxTime;

@property(nonatomic,strong)NSDictionary *infoDic;//信息
@end
