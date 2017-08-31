//
//  SavePicAndVideoViewController.h
//  Yuke
//
//  Created by 杨云飞 on 2017/7/30.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "XSMediaPlayer.h"

@interface SavePicAndVideoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bkView;

@property (weak, nonatomic) IBOutlet UIImageView *weixinImageView;
@property (weak, nonatomic) IBOutlet UIImageView *friendImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weiboImageView;

@property(nonatomic,strong)NSURL *videoUrl;
@property(nonatomic,strong)XSMediaPlayer *videoPlayer;//bofangqi
@end
