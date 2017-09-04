//
//  MineViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "MineViewController.h"
#import "ChoosePhoto.h"
#import "MineCell.h"
#import "AppConfig.h"
#import "FeedBackViewController.h"
#import "ModifyPasswordViewController.h"
#import "VipViewController.h"

#define fourWidth 22
#define baseTag 5000

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[@"分享娱客",@"联系电话",@"使用秘籍",@"意见反馈",@"清空缓存",@"退出登录"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
}

- (void)createUI{
    
    self.bkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - 20)];
    self.bkScrollView.backgroundColor = [UIColor whiteColor];
    self.bkScrollView.contentSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - 20);
    self.bkScrollView.showsVerticalScrollIndicator = NO;
    self.bkScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bkScrollView];
    
    //头像
    self.photoImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"unloginphoto")];
    self.photoImageView.userInteractionEnabled = YES;
    self.photoImageView.layer.cornerRadius = 35;
    self.photoImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhotoAction)];
    [self.photoImageView addGestureRecognizer:tap];
    
    [self.bkScrollView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bkScrollView.mas_top).offset(52 *BiLi_SCREENHEIGHT);
        make.centerX.mas_equalTo(self.bkScrollView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];

    //会员
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 58, 20);
    editBtn.layer.cornerRadius = 10;
    editBtn.backgroundColor = COLOR_HEX(0xcccccc, 1);
    [editBtn setTitle:@"娱客会员" forState:UIControlStateNormal];
    [editBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    editBtn.titleLabel.font = FONT_REGULAR(10);
    //[editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bkScrollView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.photoImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.photoImageView.centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(58, 20));
    }];

    //三个
    CGFloat jianju = (SCREEN_WIDTH - 72 - fourWidth * 3) / 2;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(36, 147, fourWidth, fourWidth)];
    imageView1.image = ImageNamed(@"zhuye");
    imageView1.tag = baseTag + 1;
    imageView1.userInteractionEnabled = YES;
    [self.bkScrollView addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + jianju, 147, fourWidth, fourWidth)];
    imageView2.image = ImageNamed(@"huiyuan");
    imageView2.tag = baseTag + 2;
    imageView2.userInteractionEnabled = YES;
    [self.bkScrollView addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + jianju, 147, fourWidth, fourWidth)];
    imageView3.image = ImageNamed(@"xiugai");
    imageView3.tag = baseTag + 3;
    imageView3.userInteractionEnabled = YES;
    [self.bkScrollView addSubview:imageView3];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label1.centerX = imageView1.centerX;
    label1.text = @"我的主页";
    label1.font = FONT_REGULAR(12);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.userInteractionEnabled = YES;
    label1.tag = baseTag + 1;
    [self.bkScrollView addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label2.centerX = imageView2.centerX;
    label2.text = @"开通会员";
    label2.font = FONT_REGULAR(12);
    //label2.font = [UIFont fontWithName:@"思源黑体 CN" size:12];
    label2.textColor = COLOR_HEX(0x333333, 1);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.userInteractionEnabled = YES;
    label2.tag = baseTag + 2;
    [self.bkScrollView addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label3.centerX = imageView3.centerX;
    label3.text = @"修改密码";
    label3.font = FONT_REGULAR(12);
    label3.textColor = COLOR_HEX(0x333333, 1);
    label3.textAlignment = NSTextAlignmentCenter;
    label3.userInteractionEnabled = YES;
    label3.tag = baseTag + 3;
    [self.bkScrollView addSubview:label3];
    
    UITapGestureRecognizer *tapGr1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    UITapGestureRecognizer *tapGr6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAction:)];
    [imageView1 addGestureRecognizer:tapGr1];
    [label1 addGestureRecognizer:tapGr2];
    [imageView2 addGestureRecognizer:tapGr3];
    [label2 addGestureRecognizer:tapGr4];
    [imageView3 addGestureRecognizer:tapGr5];
    [label3 addGestureRecognizer:tapGr6];

    
    //线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)+10, SCREEN_WIDTH, 2)];
    lineView.backgroundColor = COLOR_HEX(0xdddddd, 0.3);
    [self.bkScrollView addSubview:lineView];

    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame)+ 15 , SCREEN_WIDTH, 6 * 44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.bkScrollView addSubview:self.tableView];
    
}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify = @"MineCell";
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftTextLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.leftPicImageView.image = ImageNamed(@"fen");
    }
    if (indexPath.row == 1) {
        cell.leftPicImageView.image = ImageNamed(@"lianxi");
    }
    if (indexPath.row == 2) {
        cell.leftPicImageView.image = ImageNamed(@"shiyong");
    }
    if (indexPath.row == 3) {
        cell.leftPicImageView.image = ImageNamed(@"icon7");
    }
    if (indexPath.row == 4) {
        cell.leftPicImageView.image = ImageNamed(@"icon8");
    }
    if (indexPath.row == 5) {
        cell.leftPicImageView.image = ImageNamed(@"icon9");
    }
   
    if (indexPath.row == 1) {
        //电话
        cell.rightTextLabel.text = [NSString stringWithFormat:@"%@",NON(kUserMoudle.user_mobile)];
        cell.rightTextLabel.font = FONT_REGULAR(13);
        cell.rightTextLabel.textColor = COLOR_HEX(0x333333, 1);
        cell.rightPicImageView.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%@",self.dataArray[indexPath.row]);
    
    switch (indexPath.row) {
        case 0:
        {
            
            //这里加到异步线程，否则ShareViewController的viewWillAppear会延迟调用
            dispatch_async(dispatch_get_main_queue(), ^{
                //分享
                ShareViewController *shareViewController = [[ShareViewController alloc] init];
                shareViewController.shareUrlString = @"www.baidu.com";
                shareViewController.shareTitleString = @"ceshi";
                shareViewController.shareDescriptionString = @"ceyixia";
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView getImageWithUrl:@"aaa" placeholderImage:[UIImage imageNamed:@"pengyouquan"]];
                shareViewController.shareImage = imageView.image;
                
                [self presentViewController:shareViewController animated:YES completion:nil];
            });
            
        }
            break;
        case 1:
        {
           //电话
        }
            break;
        case 2:
        {
            //秘籍
        }
            break;
        case 3:
        {
            //反馈
            FeedBackViewController *fViewController = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
            fViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fViewController animated:YES];
        }
            break;
        case 4:
        {
            //缓存
            [JFTools showAlertWithTitle:nil
                                message:@"确定清除本地缓存吗？"
                            cancelTitle:@"确定"
                             otherTitle:@"取消"
                             completion:^(BOOL canceled, NSInteger buttonIndex) {
                                 if (canceled) {
                                     [AppConfig deleteAllCache];
                                     //weakSelf.cacheSizeLabel.text = [AppConfig cacheSize];
                                     [JFTools showSuccessHUDWithTip:@"清除完成"];
                                 }
                             }];

        }
            break;
        case 5:
        {
            //退出
            [JFTools showAlertWithTitle:@"提示"
                                message:@"是否退出当前账户？"
                            cancelTitle:@"确定"
                             otherTitle:@"取消"
                             completion:^(BOOL canceled, NSInteger buttonIndex) {
                                 
                                 if (canceled) {
                                     [kUserMoudle removeUserLoginInfo];
                                     [kAppDelegate.tabBarController setSelectedIndex:2];
                                     kAppDelegate.tabBarController.tabBar.hidden = NO;
                                     
                                 }
                             }
            ];

        }
            break;
        default:
            break;
    }
    
}

- (void)changePhotoAction{
    
    ChoosePhoto *choosePhoto = [[ChoosePhoto alloc] initWithFrame:self.view.bounds];
    [kAppDelegate.window addSubview:choosePhoto];
    
    __weak typeof(self) weakSelf = self;
    choosePhoto.chooseBlock = ^(UIImage * image){
        
//        NSDictionary *dic = @{@"userUuid":kAppContext.userUuid, @"token": kAppContext.accessToken};
//        [kJFClient uploadHeaderImg:dic picData:image paramName:@"file" success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            [JFTools showSuccessHUDWithTip:@"设置头像成功"];
//            NSString *urlStr = [responseObject objectForKeySafe:@"headerImgUrl"];
//            [weakSelf.photoImageView getImageWithUrl:urlStr placeholderImage:[UIImage imageNamed:@"unloginphoto"]];
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            
//            [JFTools showFailureHUDWithTip:error.localizedDescription];
//        }];
        
        //上传图片
        //image = [UIImage imageNamed:@"unloginphoto"];
            NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
            [JFTools showLoadingHUD];
            [kJFClient uploadPictureWithMethod:@"index.php/Api/User/up_headimg" param:dic picData:image paramName:@"image" success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"---%@",responseObject);
                [JFTools showSuccessHUDWithTip:@"设置头像成功"];
                [weakSelf.photoImageView setImage:image];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [JFTools showFailureHUDWithTip:error.localizedDescription];
            }];

    };
}

- (void)tapBtnAction:(UITapGestureRecognizer *)tapGR{
    
    NSInteger tag = tapGR.view.tag - baseTag;
    
    
    NSLog(@"点击了tag - %ld",tag);
    if (tag == 1) {
        //我的主页
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,kUserMoudle.user_info];
        BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
        webVc.title = @"个人主页";
        webVc.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:webVc animated:YES];
    }
    
    if (tag == 2) {
        //huiyuan
        VipViewController *vipVC = [[VipViewController alloc] init];
        vipVC.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:vipVC animated:YES];

    }
    
    if (tag == 3) {
     
        ModifyPasswordViewController *newVC = [[ModifyPasswordViewController alloc] init];
        newVC.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:newVC animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [LoginViewController checkLogin:^(BOOL result) {
        
        if (result) {
            //[JFTools showTipOnHUD:@"登录成功"];
        }else{
            //[JFTools showTipOnHUD:@"登录失败"];
            [kAppDelegate.tabBarController setSelectedIndex:2];
            kAppDelegate.tabBarController.tabBar.hidden = NO;
        }
    }];
    self.navigationController.navigationBarHidden = YES;
    [self.tableView reloadData];
}

@end
