//
//  VieoShowViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "VieoShowViewController.h"
#import "VieoShowCell.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
#define kNavbarHeight 0//导航栏高度
#define kTabBarHeight 44//dock条高度
#define videoUrl @"http://flv3.bn.netease.com/videolib3/1707/31/NVeMJ1940/SD/NVeMJ1940-mobile.mp4"
@interface VieoShowViewController ()<ViewCellDelegate,CGPlayerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) CGPlayer *cgPlayer;

/** 当前显示的cell */
@property (nonatomic,strong)VieoShowCell *currentCell;

/** 是否处于右下角小屏模式 */
@property (nonatomic,assign) BOOL isSmallScreen;

@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@end

@implementation VieoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //禁止掉全局左滑手势
    self.fd_interactivePopDisabled = YES;
    
    self.videoPreImageViewArray = [NSMutableArray array];
    
    self.title = @"视频展示";
    [self setLeftBackNavItem];
    [self createUI];
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreen:) name:kNOTIFYCATIONFULLSCREEN object:nil];
    
     __weak typeof(self) weakSelf = self;
    //异步请求
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        for (int i = 0; i < 10; i++) {
            
            UIImage * image = [weakSelf getVideoPreViewImage:[NSURL URLWithString:videoUrl]];
            if (image != nil) {
                [weakSelf.videoPreImageViewArray addObject:image];
                //更新UI，回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }
        }
    });
    
}

- (void)createUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 200;
    //self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //如果是当前播放的cell,则直接跳过，否则视频会被关闭
    if (self.currentIndexPath.section == indexPath.section && self.currentIndexPath.row == indexPath.row && self.currentCell != nil) {
        return self.currentCell;
    }
    static NSString *indentify = @"VieoShowCell";
    
    VieoShowCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VieoShowCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;//设置代理
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.videoPreImageViewArray.count > indexPath.row) {
        cell.imageVedioView.image = self.videoPreImageViewArray[indexPath.row];
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        cell.imageVedioView.image = [self getVideoPreViewImage:[NSURL URLWithString:videoUrl]];;
//        //cell.imageVedioView.image = [self firstFrameWithVideoURL:[NSURL URLWithString:videoUrl] size:CGSizeMake(SCREEN_WIDTH, 200)];
//    });
    
    //解决循环引用问题
    if (_cgPlayer) {
        //获取当前屏幕中所有可见的cell的indexPath
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:_currentIndexPath]) {
            
            //判断是否正在小窗口播放
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_cgPlayer]) {
                _cgPlayer.hidden = NO;
                
            }else{
                _cgPlayer.hidden = YES;
            }
        }else{//如果当前可见区域中包括复用的cell，则判断当前显示的cell中是否有之前存在的控件
            if ([cell.contentView.subviews containsObject:_cgPlayer]) {
                [cell.contentView addSubview:_cgPlayer];
                _cgPlayer.hidden = NO;
            }
            
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.row);
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (_cgPlayer) {
        //返回指定indexPath cell的frame
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:_currentIndexPath];
        //坐标转换到 相对于 [UIApplication sharedApplication].keyWindow 的坐标
        CGRect rectInSuperview = [_tableView convertRect:rectInTableView toView:[UIApplication sharedApplication].keyWindow];

        if (rectInSuperview.origin.y<-self.currentCell.contentView.frame.size.height || rectInSuperview.origin.y>self.view.frame.size.height-kNavbarHeight-kTabBarHeight){
            
            [_cgPlayer removeFromSuperview];
            [_cgPlayer  resetVedio];
        }else{
//            if ([self.currentCell.contentView.subviews containsObject:_cgPlayer]) {
//                
//            }else{
//                [self toCellSceen];
//            }
        }
    }
    
//        if (rectInSuperview.origin.y<-self.currentCell.contentView.frame.size.height
//            || rectInSuperview.origin.y>self.view.frame.size.height-kNavbarHeight-kTabBarHeight) {//往上拖动
//            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_cgPlayer]&&_isSmallScreen) {
//                _isSmallScreen = YES;
//            }else{
//                //放widow上,小屏显示
//                [self toSmallScreen];
//            }
//        }else{
//            if ([self.currentCell.contentView.subviews containsObject:_cgPlayer]) {
//
//            }else{
//                [self toCellSceen];
//            }
//        }
//
//    }

}


#pragma -mark ViewCellDelegate
- (void)playButtonClick:(VieoShowCell *)viewCell
{
    //当前点击的cell的NSIndexPath标志
    _currentIndexPath = [_tableView indexPathForCell:viewCell];
    
    _currentCell = viewCell;
    _cgPlayer.isFullscreen = NO;
    
    if(!_cgPlayer){
        _cgPlayer = [[CGPlayer alloc] initWithFrame:viewCell.bounds videoURL:videoUrl];
        _cgPlayer.delegate = self;
    }else{
        //如果播放器对象已经存在则重新部署下一播放文件资源
        [_cgPlayer removeFromSuperview];
        [_cgPlayer  resetVedio];
        [_cgPlayer  setDataSource:videoUrl];
        [_cgPlayer prepareAsyncVedio];
        [_cgPlayer startVedio];
        _cgPlayer.hidden = NO;
        
        //如果当前正在右下角小屏播放,则干掉小屏播放进入选中cell播放
        if (_isSmallScreen) {
            [self toCellSceen];
        }
    }
    _isSmallScreen = NO;
    [_currentCell.contentView addSubview:_cgPlayer];
}

#pragma -mark CGPlayerDelegate
- (void)closeCGPlayer{
    [self freeCGPlayer];
}

- (void)tapOneTapGester
{
    //如果当前处于右下角小屏播放则单击直接进入全屏播放
    if(_isSmallScreen){
        [self toFullScreen];
        return;
    }
    
    if (_cgPlayer.bottomDockView.alpha>0) {
        [UIView animateWithDuration:1.0f animations:^{
            _cgPlayer.bottomDockView.alpha = 0.0f;
        }];
    }else{
        [UIView animateWithDuration:1.0f animations:^{
            _cgPlayer.bottomDockView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [_cgPlayer hideBottomDockView];
        }];
    }
}

#pragma -mark 释放播放器资源
- (void) freeCGPlayer{
    [_cgPlayer pauseVedio];
    [_cgPlayer resetVedio];
    [_cgPlayer unSetupPlayer];
    [_cgPlayer removeFromSuperview];
    _cgPlayer=nil;
}

#pragma -mark 进入全屏通知
- (void)fullScreen:(NSNotification *)notice
{
    if(!_cgPlayer.isFullscreen){
        [self toFullScreen];
    }else{
        if(_isSmallScreen){
            [self toSmallScreen];
        }else{
            [self toCellSceen];
        }
    }
}

/**
 进入全屏
 */
-(void)toFullScreen{
    [_cgPlayer removeFromSuperview];
    _cgPlayer.bottomDockView.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        _cgPlayer.transform = CGAffineTransformIdentity;
        _cgPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
        [_cgPlayer setVedioFrame:CGRectMake(0,0,kScreenW,kScreenH)];
        [[UIApplication sharedApplication].keyWindow addSubview:_cgPlayer];
        [_cgPlayer.bottomDockView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(bottomDockH);
            make.top.mas_equalTo(kScreenW-bottomDockH);
            make.width.mas_equalTo(kScreenH);
            make.left.mas_equalTo(0);
        }];
    } completion:^(BOOL finished) {
        //取消警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
#pragma clang diagnostic pop
        _cgPlayer.isFullscreen = YES;
        _cgPlayer.bottomDockView.alpha = 1;
    }];
}

/**
 退出全屏以后进入cell之前的位置
 */
- (void)toCellSceen
{
    [_cgPlayer removeFromSuperview];
    _cgPlayer.bottomDockView.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        _cgPlayer.transform = CGAffineTransformIdentity;
        _cgPlayer.frame = self.currentCell.contentView.bounds;
        [self.currentCell.contentView addSubview:_cgPlayer];
        [_cgPlayer.bottomDockView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.offset(0);
            make.height.mas_equalTo(bottomDockH);
        }];
    }completion:^(BOOL finished) {
        _cgPlayer.isFullscreen = NO;
        _cgPlayer.bottomDockView.alpha = 1;
        _isSmallScreen = NO;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
#pragma clang diagnostic pop
        
    }];
}

/** 进入退出后的小屏 */
-(void)toSmallScreen{
    [_cgPlayer removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        _cgPlayer.transform = CGAffineTransformIdentity;
        CGFloat cgPlayerH = (kScreenW/2)*0.75;
        _cgPlayer.frame = CGRectMake(kScreenW/2,kScreenH-cgPlayerH, kScreenW/2,cgPlayerH);
        [[UIApplication sharedApplication].keyWindow addSubview:_cgPlayer];
        [_cgPlayer.bottomDockView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cgPlayer).offset(0);
            make.right.equalTo(_cgPlayer).offset(0);
            make.height.mas_equalTo(bottomDockH);
            make.bottom.equalTo(_cgPlayer).offset(0);
        }];
        
    }completion:^(BOOL finished) {
        _cgPlayer.isFullscreen = NO;
        _isSmallScreen = YES;
        _cgPlayer.bottomDockView.alpha = 0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
#pragma clang diagnostic pop
    }];
    
}

  // 获取视频第一帧
- (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    if (error == nil)
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

// 获取视频某一帧，返回UIImage
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    //视图时间，想要截取对应时间的帧，可以更改这个参数
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error = nil;
    CMTime actualTime;//可不设置，传NULL
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self closeCGPlayer];
}

@end
