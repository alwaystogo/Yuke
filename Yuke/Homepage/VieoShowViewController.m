//
//  VieoShowViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "VieoShowViewController.h"
#import "VieoShowCell.h"
//#import <AVFoundation/AVAsset.h>
//#import <AVFoundation/AVAssetImageGenerator.h>
//#import <AVFoundation/AVTime.h>


#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
#define kNavbarHeight 0//导航栏高度
#define kTabBarHeight 44//dock条高度
#define videoUrl @"http://flv3.bn.netease.com/videolib3/1707/31/NVeMJ1940/SD/NVeMJ1940-mobile.mp4"

@interface VieoShowViewController ()<UIGestureRecognizerDelegate,ViewCellDelegate>

/** 当前显示的cell */
@property (nonatomic,strong)VieoShowCell *currentCell;


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
    
    [self requestVideoList];
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
    
    return self.videoArray.count;
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
    
    
//    //解决循环引用问题
//    if (_cgPlayer) {
//        //获取当前屏幕中所有可见的cell的indexPath
//        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
//        if (![indexpaths containsObject:_currentIndexPath]) {
//
//            //判断是否正在小窗口播放
//            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_cgPlayer]) {
//                _cgPlayer.hidden = NO;
//
//            }else{
//                _cgPlayer.hidden = YES;
//            }
//        }else{//如果当前可见区域中包括复用的cell，则判断当前显示的cell中是否有之前存在的控件
//            if ([cell.contentView.subviews containsObject:_cgPlayer]) {
//                [cell.contentView addSubview:_cgPlayer];
//                _cgPlayer.hidden = NO;
//            }
//
//        }
//    }
    
    cell.imageVedioView.hidden = NO;
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
            //[_cgPlayer  resetVedio];
        }else{

        }
    }
    

}


#pragma -mark ViewCellDelegate
- (void)playButtonClick:(VieoShowCell *)viewCell
{
    
    _currentCell.imageVedioView.hidden = NO;
    //当前点击的cell的NSIndexPath标志
    _currentIndexPath = [_tableView indexPathForCell:viewCell];
    
    _currentCell = viewCell;
    //_cgPlayer.isFullscreen = NO;
    NSString *url = self.videoArray[_currentIndexPath.row][@"image"];
    //NSString *url = videoUrl;
    if(!_cgPlayer){
        
        _cgPlayer = [[CellMediaPlayer alloc] initWithFrame:viewCell.bounds];
        _cgPlayer.videoURL = [NSURL URLWithString:url];
        //_cgPlayer.delegate = self;
    }else{
        //如果播放器对象已经存在则重新部署下一播放文件资源
        [_cgPlayer removeFromSuperview];
        _cgPlayer.videoURL = [NSURL URLWithString:url];
//        [_cgPlayer  resetVedio];
//        [_cgPlayer  setDataSource:url];
//        [_cgPlayer prepareAsyncVedio];
//        [_cgPlayer startVedio];
//        _cgPlayer.hidden = NO;
        
    }

    _currentCell.imageVedioView.hidden = YES;
    [_currentCell.contentView addSubview:_cgPlayer];
}

#pragma -mark 释放播放器资源
- (void) freeCGPlayer{
//    [_cgPlayer pauseVedio];
//    [_cgPlayer resetVedio];
//    [_cgPlayer unSetupPlayer];
    [_cgPlayer removeFromSuperview];
    _cgPlayer=nil;
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
    //assetGen.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    //视图时间，想要截取对应时间的帧，可以更改这个参数
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error = nil;
    CMTime actualTime;//可不设置，传NULL
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

- (void)requestVideoList{
    
    [JFTools showLoadingHUD];
    WeakSelf
    [kJFClient videoShowList:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        NSLog(@"---%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            weakSelf.videoArray = responseObject;
            //异步请求
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                for (int i = 0; i < weakSelf.videoArray.count; i++) {
                    
                    NSString *url = weakSelf.videoArray[i][@"image"];
                    UIImage * image = [weakSelf getVideoPreViewImage:[NSURL URLWithString:url]];
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}

-(void)dealloc{
    [self freeCGPlayer];
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
//        self.view.backgroundColor = [UIColor whiteColor];
//    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        self.view.backgroundColor = [UIColor blackColor];
//    }
//}
//// 哪些页面支持自动转屏
//- (BOOL)shouldAutorotate{
//    
//    return YES;
//}
//
//// viewcontroller支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
//    // MoviePlayerViewController这个页面支持转屏方向
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//    
//}

@end
