//
//  MovieDemo
//
//  Created by zhao on 16/3/25.
//  Copyright © 2016年 Mega. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellMediaPlayerMaskView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

//
// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection2){
    PanDirectionHorizontalMoved, //横向移动
    PanDirectionVerticalMoved    //纵向移动
};

//播放器的几种状态
typedef NS_ENUM(NSInteger, ZFPlayerState2) {
    ZFPlayerStateBuffering,  //缓冲中
    ZFPlayerStatePlaying,    //播放中
    ZFPlayerStateStopped,    //停止播放
    ZFPlayerStatePause       //暂停播放
};


@interface CellMediaPlayer: UIView<UIGestureRecognizerDelegate>

/** 视频URL */
@property (nonatomic, strong) NSURL   *videoURL;
//-(void)orientationChanged:(NSNotification *)noc;

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playerItme;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;

@property(nonatomic,strong)CellMediaPlayerMaskView *maskView;

@property(nonatomic,assign)CGRect smallFrame;
@property(nonatomic,assign)CGRect bigFrame;

/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection2     panDirection;
@property(nonatomic,assign)ZFPlayerState2 playState;


@property(nonatomic,assign)BOOL isDragSlider;
/** 是否被用户暂停 */
@property (nonatomic,assign) BOOL    isPauseByUser;

/** 滑杆 */
@property (nonatomic, strong) UISlider  *volumeViewSlider;

@end



