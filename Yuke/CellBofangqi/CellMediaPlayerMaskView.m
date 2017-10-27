//
//  MovieDemo
//
//  Created by zhao on 16/3/25.
//  Copyright © 2016年 Mega. All rights reserved.
//

#import "CellMediaPlayerMaskView.h"
#import <AVFoundation/AVFoundation.h>

#define  StartbtnWidth 30
#define BottomHeight 30
@interface CellMediaPlayerMaskView ()

/** bottom渐变层*/
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;
/** top渐变层 */
@property (nonatomic, strong) CAGradientLayer *topGradientLayer;
/** bottomView*/
@property (strong, nonatomic  )  UIImageView     *bottomImageView;
/** topView */
@property (strong, nonatomic  )  UIImageView     *topImageView;

@end

@implementation CellMediaPlayerMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
    
        self.bottomImageView = [[UIImageView alloc]init];
        self.bottomImageView.backgroundColor = [UIColor blackColor];
        self.bottomImageView.userInteractionEnabled = YES;
        
        self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,StartbtnWidth,StartbtnWidth)];
        [self.startBtn setImage:[UIImage imageNamed:@"kr-video-player-play"] forState:UIControlStateNormal];
        [self.startBtn setImage:[UIImage imageNamed:@"kr-video-player-pause"] forState:UIControlStateSelected];
        self.startBtn.backgroundColor = [UIColor blackColor];
        
        self.fullScreenBtn = [[UIButton alloc]init];
        self.fullScreenBtn.backgroundColor = [UIColor blackColor];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        
        self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10,60, 30)];
        self.currentTimeLabel.text = @"00:00";
        self.currentTimeLabel.textColor = [UIColor whiteColor];
        self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.currentTimeLabel.font = [UIFont systemFontOfSize:15];
        self.totalTimeLabel = [[UILabel alloc]init];
        self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.totalTimeLabel.font = [UIFont systemFontOfSize:15];
        self.totalTimeLabel.textColor = [UIColor whiteColor];
        self.totalTimeLabel.text = @"00:00";
        
        
        self.progressView = [[UIProgressView alloc]init];
        self.progressView.progressTintColor    = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        self.progressView.trackTintColor       = [UIColor clearColor];
        
        
        // 设置slider
        self.videoSlider = [[UISlider alloc]init];
        [self.videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        self.videoSlider.minimumTrackTintColor = [UIColor whiteColor];
        self.videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
        
        [self addSubview:self.bottomImageView];
        [self.bottomImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(BottomHeight);
        }];
        // 初始化渐变层
        [self initCAGradientLayer];
        
        
        self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.bottomImageView addSubview:self.startBtn];
        [self.bottomImageView addSubview:self.fullScreenBtn];
        [self.bottomImageView addSubview:self.currentTimeLabel];
        [self.bottomImageView addSubview:self.totalTimeLabel];
        [self.bottomImageView addSubview:self.progressView];
        [self.bottomImageView addSubview:self.videoSlider];
        
        
        [self addSubview:self.activity];
        
        NSError *error;
        
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        
        // add event handler, for this example, it is `volumeChange:` method
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
        
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.topImageView = [[UIImageView alloc]init];
        self.topImageView.backgroundColor = [UIColor blackColor];
        self.bottomImageView = [[UIImageView alloc]init];
        self.bottomImageView.backgroundColor = [UIColor blackColor];
        self.bottomImageView.userInteractionEnabled = YES;
        
        self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,StartbtnWidth,StartbtnWidth)];
        [self.startBtn setImage:[UIImage imageNamed:@"kr-video-player-play"] forState:UIControlStateNormal];
        [self.startBtn setImage:[UIImage imageNamed:@"kr-video-player-pause"] forState:UIControlStateSelected];
        self.startBtn.backgroundColor = [UIColor blackColor];
        
        self.fullScreenBtn = [[UIButton alloc]init];
        self.fullScreenBtn.backgroundColor = [UIColor blackColor];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        
        self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10,60, 30)];
        self.currentTimeLabel.text = @"00:00";
        self.currentTimeLabel.textColor = [UIColor whiteColor];
        self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.currentTimeLabel.font = [UIFont systemFontOfSize:15];
        self.totalTimeLabel = [[UILabel alloc]init];
        self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.totalTimeLabel.font = [UIFont systemFontOfSize:15];
        self.totalTimeLabel.textColor = [UIColor whiteColor];
        self.totalTimeLabel.text = @"00:00";
        
    
        self.progressView = [[UIProgressView alloc]init];
        self.progressView.progressTintColor    = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        self.progressView.trackTintColor       = [UIColor clearColor];
        
        self.volumeProgress = [[UIProgressView alloc]init];
        self.volumeProgress.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.volumeProgress.progressTintColor    = [UIColor whiteColor];
        self.volumeProgress.trackTintColor       = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        

        // 设置slider
        self.videoSlider = [[UISlider alloc]init];
        [self.videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        self.videoSlider.minimumTrackTintColor = [UIColor whiteColor];
        self.videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
        
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomImageView];
        // 初始化渐变层
        [self initCAGradientLayer];

        
        self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.bottomImageView addSubview:self.startBtn];
        [self.bottomImageView addSubview:self.fullScreenBtn];
        [self.bottomImageView addSubview:self.currentTimeLabel];
        [self.bottomImageView addSubview:self.totalTimeLabel];
        [self.bottomImageView addSubview:self.progressView];
        [self.bottomImageView addSubview:self.videoSlider];
       
        //by yang
        //[self addSubview:self.volumeProgress];
        
        [self addSubview:self.activity];
        
        
        
        
        NSError *error;
        
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        
        // add event handler, for this example, it is `volumeChange:` method
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
        
        
    }
    return self;
}


- (void)volumeChanged:(NSNotification *)notification
{
    // service logic here.
    NSLog(@"%@",notification.userInfo);
    NSString *valueStr = notification.userInfo[@"AVSystemController_AudioVolumeNotificationParameter"];
    self.volumeProgress.progress = [valueStr floatValue];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat topWidth = 0;
    CGFloat bottomWidth = 40;
    
    self.bottomGradientLayer.frame = self.bottomImageView.bounds;
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.left.equalTo(self.bottomImageView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    self.fullScreenBtn.frame = CGRectMake(width-bottomWidth,0,bottomWidth,bottomWidth);
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.right.equalTo(self.bottomImageView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    self.totalTimeLabel.frame = CGRectMake(width-110,10,60,30);
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.right.equalTo(self.fullScreenBtn.mas_left).offset(-30);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.left.equalTo(self.startBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    CGFloat progressWidth = width-2*(self.startBtn.frame.size.width+self.currentTimeLabel.frame.size.width);
    
    self.progressView.frame = CGRectMake(0,0,progressWidth,20);
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-10);
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(10);
        make.height.mas_equalTo(2);
    }];
   
    self.videoSlider.frame = self.progressView.frame;
    [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomImageView.mas_centerY);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-10);
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(10);
        make.height.mas_equalTo(2);
    }];
//    self.activity.center = CGPointMake(width/2, height/2);
    self.activity.center = CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height/2);
}

- (void)initCAGradientLayer
{
    //初始化Bottom渐变层
    self.bottomGradientLayer            = [CAGradientLayer layer];
    [self.bottomImageView.layer addSublayer:self.bottomGradientLayer];
    //设置渐变颜色方向
    self.bottomGradientLayer.startPoint = CGPointMake(0, 0);
    self.bottomGradientLayer.endPoint   = CGPointMake(0, 1);
    //设定颜色组
    self.bottomGradientLayer.colors     = @[(__bridge id)[UIColor clearColor].CGColor,
                                            (__bridge id)[UIColor blackColor].CGColor];
    //设定颜色分割点
    self.bottomGradientLayer.locations  = @[@(0.0f) ,@(1.0f)];
    
    
    //初始Top化渐变层
    self.topGradientLayer               = [CAGradientLayer layer];
    [self.topImageView.layer addSublayer:self.topGradientLayer];
    //设置渐变颜色方向
    self.topGradientLayer.startPoint    = CGPointMake(1, 0);
    self.topGradientLayer.endPoint      = CGPointMake(1, 1);
    //设定颜色组
    self.topGradientLayer.colors        = @[ (__bridge id)[UIColor blackColor].CGColor,
                                             (__bridge id)[UIColor clearColor].CGColor];
    //设定颜色分割点
    self.topGradientLayer.locations     = @[@(0.0f) ,@(1.0f)];
    
}


-(void)dealloc
{
    NSLog(@"%s",__func__);
    
[[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    

}

@end
