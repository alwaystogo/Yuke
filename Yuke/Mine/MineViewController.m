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

#define fourWidth 22

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self login];
    //[self regist];
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
    imageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + jianju, 147, fourWidth, fourWidth)];
    imageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + jianju, 147, fourWidth, fourWidth)];
    imageView3.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView3];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label1.centerX = imageView1.centerX;
    label1.text = @"我的主页";
    label1.font = FONT_REGULAR(12);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label2.centerX = imageView2.centerX;
    label2.text = @"开通会员";
    label2.font = FONT_REGULAR(12);
    label2.textColor = COLOR_HEX(0x333333, 1);
    label2.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label3.centerX = imageView3.centerX;
    label3.text = @"修改密码";
    label3.font = FONT_REGULAR(12);
    label3.textColor = COLOR_HEX(0x333333, 1);
    label3.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label3];
    
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
    cell.leftPicImageView.backgroundColor = [UIColor grayColor];
    if (indexPath.row == 1) {
        //电话
        cell.rightTextLabel.text = [NSString stringWithFormat:@"%@",@"13701166699"];
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
            //分享
            
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
        
    };
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)login{
    
    NSDictionary *dic = @{@"mobile":@"13701166693",@"password":@"123456"};
    [kJFClient login:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"login:%@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [JFTools showFailureHUDWithTip:error.description];
    }];
}
- (void)regist{
    
    NSDictionary *dic = @{@"mobile":@"13701166693",@"password":@"123456"};
    [kJFClient regist:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"login:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.description];
    }];
}

@end
