//
//  HomepageViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "HomepageViewController.h"
#import "HotCollectionViewCell.h"
#import "NewHuodongViewController.h"
#import "YirenViewController.h"
#import "MeiriZuXunViewController.h"
#import "PicShowViewController.h"
#import "VieoShowViewController.h"
#import "ShangwuhezuoViewController.h"
#import "AdvertiseViewController.h"

#define fourWidth 27
#define hotPicWidth 181
#define hotPicHeight 220

#define baseTag 1000
@interface HomepageViewController ()

@property(nonatomic,assign)CGFloat label1MaxY;
@property(nonatomic,assign)CGFloat picImageViewMaxY;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"SVN修改");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];

    [self requestBanner];
    [self requestHot];
    
    [self updatePicRequst];
}

- (void)createUI{
    
    self.bkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - 20)];
    self.bkScrollView.backgroundColor = [UIColor whiteColor];
    self.bkScrollView.contentSize =CGSizeMake(SCREEN_WIDTH, 1000);
    self.bkScrollView.showsVerticalScrollIndicator = NO;
    self.bkScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bkScrollView];
    
    [self createLunBo];
    [self createFour];
    [self createInfoShow];
    [self createHot];
    
   
}
- (void)createLunBo{
    
    //轮播控件
    _carouselSV = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) / 320 * 160)];
    _carouselSV.backgroundColor = [UIColor grayColor];
    [self.bkScrollView addSubview:_carouselSV];
    
    
    NSArray *dicArray = @[
//                          @{
//                              @"carouseUrl" : @"http://pic.58pic.com/58pic/17/27/03/07B58PIC3zg_1024.jpg"
//                              },
//                          @{
//                              @"carouseUrl" : @"http://pic.58pic.com/58pic/13/56/99/88f58PICuBh_1024.jpg"
//                              },
//                          @{
//                              @"carouseUrl" : @"http://pic.58pic.com/58pic/17/77/53/558d11422a923_1024.png"
//                              },
//                          @{
//                              @"carouseUrl" : @"http://pic.58pic.com/58pic/13/18/14/87m58PICVvM_1024.jpg"
//                              },
//                          @{
//                              @"carouseUrl" : @"http://pic.qiantucdn.com/58pic/17/79/77/41N58PICaMu_1024.jpg"
//                              }
                          ];
    
    WeakSelf
    _carouselSV.click = ^(NSInteger index) {
        
        NSLog(@"点击了第%ld",index);
//        NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,[weakSelf.bannerArray[index] objectForKeySafe:@"url"]];
        NSString *strUrl = [weakSelf.bannerArray[index] objectForKeySafe:@"url"];
        BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
        webVc.title = @"详情";
        webVc.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:webVc animated:YES];
    };
    [_carouselSV setCarouseWithArray:self.bannerArray];
}

-(void)createFour{
    
    CGFloat jianju = (SCREEN_WIDTH - 66 - fourWidth * 4) / 3;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(33, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView1.image = ImageNamed(@"zuxun");
    imageView1.tag = baseTag + 1;
    imageView1.userInteractionEnabled = YES;
    [self.bkScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + jianju, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView2.userInteractionEnabled = YES;
    imageView2.image = ImageNamed(@"yirenzhuanfang");
    imageView2.tag = baseTag + 2;
    [self.bkScrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + jianju, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView3.userInteractionEnabled = YES;
    imageView3.image = ImageNamed(@"zuixinhuodong");
    imageView3.tag = baseTag + 3;
    [self.bkScrollView addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView3.frame) + jianju, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView4.userInteractionEnabled = YES;
    imageView4.image = ImageNamed(@"shangwu");
    imageView4.tag = baseTag + 4;
    [self.bkScrollView addSubview:imageView4];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label1.centerX = imageView1.centerX;
    label1.text = @"每日组讯";
    label1.font = FONT_REGULAR(12);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.userInteractionEnabled = YES;
    label1.tag = baseTag + 1;
    [self.bkScrollView addSubview:label1];
    
    self.label1MaxY = CGRectGetMaxY(label1.frame);
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label2.centerX = imageView2.centerX;
    label2.text = @"艺人专访";
    label2.font = FONT_REGULAR(12);
    label2.textColor = COLOR_HEX(0x333333, 1);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.userInteractionEnabled = YES;
    label2.tag = baseTag + 2;
    [self.bkScrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label3.centerX = imageView3.centerX;
    label3.text = @"最新活动";
    label3.font = FONT_REGULAR(12);
    label3.textColor = COLOR_HEX(0x333333, 1);
    label3.textAlignment = NSTextAlignmentCenter;
    label3.userInteractionEnabled = YES;
    label3.tag = baseTag + 3;
    [self.bkScrollView addSubview:label3];

    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label4.centerX = imageView4.centerX;
    label4.text = @"商务合作";
    label4.font = FONT_REGULAR(12);
    label4.textColor = COLOR_HEX(0x333333, 1);
    label4.textAlignment = NSTextAlignmentCenter;
    label4.userInteractionEnabled = YES;
    label4.tag = baseTag + 4;
    [self.bkScrollView addSubview:label4];
    
    UITapGestureRecognizer *tapGr1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    [imageView1 addGestureRecognizer:tapGr1];
    [label1 addGestureRecognizer:tapGr2];
    [imageView2 addGestureRecognizer:tapGr3];
    [label2 addGestureRecognizer:tapGr4];
    [imageView3 addGestureRecognizer:tapGr5];
    [label3 addGestureRecognizer:tapGr6];
    [imageView4 addGestureRecognizer:tapGr7];
    [label4 addGestureRecognizer:tapGr8];

    
}

- (void)createInfoShow{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.label1MaxY + 15, 17, 17)];
    imageView1.image = ImageNamed(@"ziliaoyulan");
    [self.bkScrollView addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)+10, CGRectGetMaxY(imageView1.frame)- 10, 60,14)];
    //label1.backgroundColor = [UIColor greenColor];
    label1.bottom = imageView1.bottom;
    label1.text = @"资料预览";
    label1.font = FONT_REGULAR(13);
    label1.textColor = COLOR_HEX(0x333333, 1);
    //label1.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label1];
    
    CGFloat imageWidth = (SCREEN_WIDTH - 30)/2;
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView1.frame) + 3, imageWidth, 272/2 * (imageWidth/ (345/2)))];
    imageView2.image = ImageNamed(@"pic-card");
    [self.bkScrollView addSubview:imageView2];
    imageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapPicShow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicShowAction)];
    [imageView2 addGestureRecognizer:tapPicShow];
    
    self.picImageViewMaxY = CGRectGetMaxY(imageView2.frame);
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + 10, CGRectGetMaxY(imageView1.frame) + 3, imageWidth, 272/2 * (imageWidth/ (345/2)))];
    imageView3.image = ImageNamed(@"video-card");
    [self.bkScrollView addSubview:imageView3];
    imageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapVieoShow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVieoShowAction)];
    [imageView3 addGestureRecognizer:tapVieoShow];
}

- (void)createHot{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.picImageViewMaxY + 11, 17, 17)];
    imageView1.image = ImageNamed(@"remen");
    [self.bkScrollView addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)+10, CGRectGetMaxY(imageView1.frame)- 10, 60,14)];
    //label1.backgroundColor = [UIColor greenColor];
    label1.bottom = imageView1.bottom;
    label1.text = @"热门专访";
    label1.font = FONT_REGULAR(13);
    label1.textColor = COLOR_HEX(0x333333, 1);
    //label1.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label1];

    //创建collectionView 362
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(hotPicWidth, hotPicHeight);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView1.frame)+3, SCREEN_WIDTH - 20, hotPicHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.bkScrollView addSubview:self.collectionView];
    
    UINib *nib = [UINib nibWithNibName:@"HotCollectionViewCell" bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"hotCell"];

    //重新设置
    self.bkScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.collectionView.frame)+20);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.hotArray.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotCollectionViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.cornerRadius = 10;
    cell.picImageView.layer.cornerRadius = 10;
    [cell.picImageView getImageWithUrl:[self.hotArray[indexPath.row] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,[self.hotArray[indexPath.row] objectForKeySafe:@"info_url"]];
    BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
    webVc.title = @"专访详情";
    webVc.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:webVc animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)requestBanner{
    
    [JFTools showLoadingHUD];
    [kJFClient getHomePageBanner:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        NSLog(@"--- :%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.bannerArray = responseObject;
            [_carouselSV setCarouseWithArray:self.bannerArray];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [JFTools showTipOnHUD:error.localizedDescription];
    }];
}
- (void)requestHot{
    
    [JFTools showLoadingHUD];
    [kJFClient getHomePageHot:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        NSLog(@"--- :%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.hotArray = responseObject;
            [self.collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [JFTools showTipOnHUD:error.localizedDescription];
    }];

}

- (void)tapBtnAction:(UITapGestureRecognizer *)tapGR{
    
    NSInteger tag = tapGR.view.tag - baseTag;

    
    NSLog(@"点击了tag - %ld",tag);
    if (tag == 1) {
        //mei
        MeiriZuXunViewController *zuXunVC = [[MeiriZuXunViewController alloc] init];
        zuXunVC.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:zuXunVC animated:YES];
    }
    
    if (tag == 2) {
        //yi
        YirenViewController *yirenVC = [[YirenViewController alloc] init];
        yirenVC.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:yirenVC animated:YES];
    }
    
    if (tag == 3) {
        //zui
        NewHuodongViewController *newVC = [[NewHuodongViewController alloc] init];
        newVC.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:newVC animated:YES];
    }
    
    if (tag == 4) {
        //shang
        ShangwuhezuoViewController *newVC = [[ShangwuhezuoViewController alloc] init];
        newVC.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:newVC animated:YES];
    }
}

- (void)tapPicShowAction{
    
    PicShowViewController *newVC = [[PicShowViewController alloc] init];
    newVC.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:newVC animated:YES];
}
- (void)tapVieoShowAction{
    
    VieoShowViewController *newVC = [[VieoShowViewController alloc] init];
    newVC.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:newVC animated:YES];
}

//跳到广告详情页
- (void)pushToAd {
    
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
    
}
- (void)updatePicRequst{

//    //上传图片
//    UIImage *image = [UIImage imageNamed:@"unloginphoto"];
//    
//    NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
//    [JFTools showLoadingHUD];
//    [kJFClient uploadPictureWithMethod:@"index.php/Api/Card/update_card" param:dic picData:image paramName:@"image" success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"---%@",responseObject);
//        [JFTools showSuccessHUDWithTip:@"上传图片成功"];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [JFTools showFailureHUDWithTip:error.localizedDescription];
//    }];
    
}
@end
