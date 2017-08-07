//
//  XSMediaPlayer.h
//  MovieDemo
//
//  Created by zhao on 16/3/25.
//  Copyright © 2016年 Mega. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XibView.h"
#import "XSMediaPlayer.h"
#import "XSMediaPlayerMaskView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#pragma 制作视频时，使用的播放器

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved, //横向移动
    PanDirectionVerticalMoved    //纵向移动
};

//播放器的几种状态
typedef NS_ENUM(NSInteger, ZFPlayerState) {
    ZFPlayerStateBuffering,  //缓冲中
    ZFPlayerStatePlaying,    //播放中
    ZFPlayerStateStopped,    //停止播放
    ZFPlayerStatePause       //暂停播放
};


@interface XSMediaPlayer : UIView<UIGestureRecognizerDelegate>


@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playerItme;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;

@property(nonatomic,strong)XSMediaPlayerMaskView *maskView;

@property(nonatomic,assign)CGRect smallFrame;
@property(nonatomic,assign)CGRect bigFrame;

/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection     panDirection;
@property(nonatomic,assign)ZFPlayerState playState;


@property(nonatomic,assign)BOOL isDragSlider;
/** 是否被用户暂停 */
@property (nonatomic,assign) BOOL    isPauseByUser;



/** 视频URL */
@property (nonatomic, strong) NSURL   *videoURL;
//-(void)orientationChanged:(NSNotification *)noc;


@end



