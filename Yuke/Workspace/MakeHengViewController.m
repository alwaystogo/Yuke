//
//  MakeHengViewController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 2017/8/14.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "MakeHengViewController.h"
#import "ZitiCollectionViewCell.h"
#import "CardScrollView.h"
#import "SavePicViewController.h"

@interface MakeHengViewController ()

@property(nonatomic,strong)UIView *topBkView;
@property(nonatomic,strong)UIView *bottomBkView;
@property(nonatomic,strong)UIButton *fanhuiBtn;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UIButton *wanchengBtn;

@property(nonatomic,strong)UIButton *beijingBtn;
@property(nonatomic,strong)UIButton *shuiyinBtn;
@property(nonatomic,strong)UIButton *zitiBtn;

@property(nonatomic,strong)UIView *beijingBkView;
@property(nonatomic,strong)UIView *shuiyinBkView;
@property(nonatomic,strong)UIView *zitiBkView;
@property(nonatomic,strong)UIImageView *beijingImageView1;
@property(nonatomic,strong)UIImageView *beijingImageView2;
@property(nonatomic,strong)UIImageView *shuiyinImageView1;
@property(nonatomic,strong)UIImageView *shuiyinImageView2;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *zitiArray;

@property(nonatomic,assign)NSInteger selectEditType;
@property(nonatomic,assign)NSInteger selectBeijing;
@property(nonatomic,assign)NSInteger selectShuiyin;
@property(nonatomic,assign)NSInteger selectZiti;
@property(nonatomic,copy)NSString *isVIP;

@property(nonatomic,strong)UIView *picBkView;
@property(nonatomic,strong)UIColor *picBkViewColor;

@property(nonatomic,strong)UIFont *labelFont;

@end

@implementation MakeHengViewController

- (instancetype)initWith:(NSInteger)mobanNum withImageArray:(NSArray *)imageArray withInfo:(NSDictionary *)infoDic{
    self = [super init];
    if (self) {
        self.mobanNum = mobanNum;
        self.imageArray = imageArray;
        self.infoDic = infoDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.zitiArray = [NSMutableArray arrayWithObjects:@"3", @"4", @"5", @"6", @"7", nil];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = COLOR_HEX(0x999999, 1);
    
    self.selectEditType = 1;
    self.selectBeijing = 1;
    self.selectShuiyin = 1;
    self.selectZiti = 0;
    [self creatTopUI];
    [self createBottomUI];
    [self createxuanzeBeijingUI];
    [self createshuiyinUI];
    [self createzitiUI];
    self.bottomBkView.hidden =YES;
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    
    self.picBkViewColor = [UIColor whiteColor];
    [self requestZitiInfo];
    
    if (self.mobanNum == 1) {
        [self makeMoban1];
    }
    if (self.mobanNum == 2) {
        [self makeMoban2];
    }
    if (self.mobanNum == 3) {
        [self makeMoban3];
    }
    if (self.mobanNum == 4) {
        [self makeMoban4];
    }
    if (self.mobanNum == 5) {
        [self makeMoban5];
    }
    if (self.mobanNum == 6) {
        [self makeMoban6];
    }
    if (self.mobanNum == 7) {
        [self makeMoban7];
    }
    if (self.mobanNum == 8) {
        [self makeMoban8];
    }
    if (self.mobanNum == 9) {
        [self makeMoban9];
    }
    if (self.mobanNum == 10) {
        [self makeMoban10];
    }
    if (self.mobanNum == 11) {
        [self makeMoban11];
    }
    if (self.mobanNum == 12) {
        [self makeMoban12];
    }
    if (self.mobanNum == 13) {
        [self makeMoban13];
    }
    if (self.mobanNum == 14) {
        [self makeMoban14];
    }
    if (self.mobanNum == 15) {
        [self makeMoban15];
    }
    if (self.mobanNum == 16) {
        [self makeMoban16];
    }
    if (self.mobanNum == 17) {
        [self makeMoban17];
    }
    if (self.mobanNum == 18) {
        [self makeMoban18];
    }
    if (self.mobanNum == 19) {
        [self makeMoban19];
    }
    if (self.mobanNum == 20) {
        [self makeMoban20];
    }
    if (self.mobanNum == 21) {
        [self makeMoban21];
    }

}

- (void)creatTopUI{
    
    _topBkView = [[UIView alloc] init];
    self.topBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:_topBkView];
    [self.topBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@44);
    }];
    self.fanhuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fanhuiBtn setImage:ImageNamed(kLeftNavImageName) forState:UIControlStateNormal];
    [self.fanhuiBtn addTarget:self action:@selector(fanhuiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBkView addSubview:self.fanhuiBtn];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = FONT_REGULAR(15);
    [self.editBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBkView addSubview:self.editBtn];
    
    self.wanchengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wanchengBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.wanchengBtn.titleLabel.font = FONT_REGULAR(15);
    [self.wanchengBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.wanchengBtn addTarget:self action:@selector(wanchengBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBkView addSubview:self.wanchengBtn];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = COLOR_HEX(0x333333, 1);
    titleLabel.text = @"制作卡片";
    titleLabel.font = FONT_REGULAR(17);
    [self.topBkView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.centerX.equalTo(self.topBkView.mas_centerX);
    }];

    [self.fanhuiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBkView.mas_left).offset(10);
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.wanchengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topBkView.mas_right).offset(-20);
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wanchengBtn.mas_left).offset(-15);
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];

}
- (void)createBottomUI{
    
    self.picBkView = [[UIView alloc] initWithFrame:CGRectMake(0,44,self.view.height,self.view.width - 44)];
    self.picBkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.picBkView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPickBkViewAction)];
    [self.picBkView addGestureRecognizer:tap];
    
    _bottomBkView = [[UIView alloc] init];
    self.bottomBkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomBkView];
    [self.bottomBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@28);
    }];

    self.beijingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.beijingBtn setTitle:@"选择背景" forState:UIControlStateNormal];
    self.beijingBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.beijingBtn.titleLabel.font = FONT_REGULAR(15);
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.beijingBtn addTarget:self action:@selector(beijingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.beijingBtn];
    [self.beijingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomBkView.mas_left).offset(0);
        make.centerY.equalTo(self.bottomBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.height / 3, 28));
    }];
    
    self.zitiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.zitiBtn setTitle:@"更换字体" forState:UIControlStateNormal];
    self.zitiBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.zitiBtn.titleLabel.font = FONT_REGULAR(15);
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn addTarget:self action:@selector(zitiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.zitiBtn];
    [self.zitiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomBkView.mas_right).offset(0);
        make.centerY.equalTo(self.bottomBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.height / 3, 28));
    }];

    self.shuiyinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shuiyinBtn setTitle:@"去掉水印" forState:UIControlStateNormal];
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.shuiyinBtn.titleLabel.font = FONT_REGULAR(15);
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn addTarget:self action:@selector(shuiyinBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.shuiyinBtn];
    [self.shuiyinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beijingBtn.mas_right).offset(0);
        make.right.equalTo(self.zitiBtn.mas_left).offset(0);
        make.top.equalTo(self.bottomBkView.mas_top);
        make.bottom.equalTo(self.bottomBkView.mas_bottom);
    }];


}
- (void)createxuanzeBeijingUI{
    
    self.beijingBkView = [[UIView alloc] init];
    self.beijingBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.beijingBkView];
    [self.beijingBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBkView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
     self.beijingImageView1 = [[UIImageView alloc] init];
    self.beijingImageView1.image = ImageNamed(@"bbg-heng");
    [self.beijingBkView addSubview:self.beijingImageView1];
    [self.beijingImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.beijingBkView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.beijingBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.beijingImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beijingImageView1Action)];
    [self.beijingImageView1 addGestureRecognizer:tap1];
    
    self.beijingImageView2 = [[UIImageView alloc] init];
    self.beijingImageView2.image = ImageNamed(@"hbg-heng");
    [self.beijingBkView addSubview:self.beijingImageView2];
    [self.beijingImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beijingBkView.mas_centerX).offset(50);
        make.centerY.equalTo(self.beijingBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.beijingImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beijingImageView2Action)];
    [self.beijingImageView2 addGestureRecognizer:tap2];
}
- (void)createshuiyinUI{
   
    self.shuiyinBkView = [[UIView alloc] init];
    self.shuiyinBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.shuiyinBkView];
    [self.shuiyinBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBkView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    self.shuiyinImageView1 = [[UIImageView alloc] init];
    self.shuiyinImageView1.image = ImageNamed(@"shuiyin-heng-1");
    [self.shuiyinBkView addSubview:self.shuiyinImageView1];
    [self.shuiyinImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shuiyinBkView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.shuiyinBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.shuiyinImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shuiyinImageView1Action)];
    [self.shuiyinImageView1 addGestureRecognizer:tap1];
    
    self.shuiyinImageView2 = [[UIImageView alloc] init];
    self.shuiyinImageView2.image = ImageNamed(@"wushuiyin-heng");
    [self.shuiyinBkView addSubview:self.shuiyinImageView2];
    [self.shuiyinImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shuiyinBkView.mas_centerX).offset(50);
        make.centerY.equalTo(self.shuiyinBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.shuiyinImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shuiyinImageView2Action)];
    [self.shuiyinImageView2 addGestureRecognizer:tap2];
}
- (void)createzitiUI{
    
    self.zitiBkView = [[UIView alloc] init];
    self.zitiBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.zitiBkView];
    [self.zitiBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBkView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];

    CGFloat hotPicWidth = 125;
    CGFloat hotPicHeight = 93;
    //创建collectionView 362
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 30;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(hotPicWidth, hotPicHeight);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.zitiBkView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.zitiBkView.mas_bottom);
        make.left.equalTo(self.zitiBkView.mas_left);
        make.right.equalTo(self.zitiBkView.mas_right);
        make.top.equalTo(self.zitiBkView.mas_top);
    }];

    //注册单元格,相当于设置了闲置池
    UINib *nib = [UINib nibWithNibName:@"ZitiCollectionViewCell" bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"ZitiCell"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.zitiArray.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZitiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZitiCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZitiCollectionViewCell" owner:self options:nil] lastObject];
    }

    NSString *str = self.zitiArray[indexPath.row];
    NSInteger fontNum = [str integerValue];
    NSInteger fontSize = 22;
    switch (fontNum) {
        case 1:
            cell.zitiLabel.font = FONT1(fontSize);
            break;
        case 2:
            cell.zitiLabel.font = FONT2(fontSize);
            break;
        case 3:
            cell.zitiLabel.font = FONT3(fontSize);
            break;
        case 4:
            cell.zitiLabel.font = FONT4(fontSize);
            break;
        case 5:
            cell.zitiLabel.font = FONT5(fontSize);
            break;
        case 6:
            cell.zitiLabel.font = FONT6(fontSize);
            break;
        case 7:
            cell.zitiLabel.font = FONT7(fontSize);
            break;
        default:
            break;
    }
    cell.zitiLabel.text = @"个性字体";
    NSString * zitiStr = [NSString stringWithFormat:@"%ld",self.selectZiti];
    NSInteger index = [self.zitiArray indexOfObject:zitiStr];
    if (indexPath.row == index) {
        
        cell.contentView.layer.borderWidth = 2;
        cell.contentView.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
    }else{
        
        cell.contentView.layer.borderWidth = 0;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    NSString *str = self.zitiArray[indexPath.row];
    self.selectZiti = [str integerValue];
    [self.collectionView reloadData];
    //更改字体
    [self changeLabelFont];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
        } completion:^(BOOL finished) {
            //隐藏bar
             [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }];
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //显示bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)beijingBtnAction{
    self.beijingBkView.hidden = NO;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    self.beijingBtn.backgroundColor = COLOR_HEX(0xff9000, 1);
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.zitiBtn.backgroundColor = COLOR_HEX(0xffa632, 1);

    if (self.selectBeijing == 1) {
        self.beijingImageView1.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView1.layer.borderWidth = 2;
        self.beijingImageView2.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView2.layer.borderWidth = 2;
    }else{
        self.beijingImageView2.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView2.layer.borderWidth = 2;
        self.beijingImageView1.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView1.layer.borderWidth = 2;
    }

}
- (void)shuiyinBtnAction{
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = NO;
    self.zitiBkView.hidden = YES;
    self.beijingBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xff9000, 1);
    self.zitiBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    if (self.selectShuiyin == 1) {
        self.shuiyinImageView1.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.shuiyinImageView1.layer.borderWidth = 2;
        self.shuiyinImageView2.layer.borderWidth = 0;
    }else{
        self.shuiyinImageView2.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.shuiyinImageView2.layer.borderWidth = 2;
        self.shuiyinImageView1.layer.borderWidth = 0;
    }

}
- (void)zitiBtnAction{
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = NO;
    self.beijingBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.zitiBtn.backgroundColor = COLOR_HEX(0xff9000, 1);
}

//bai
- (void)beijingImageView1Action{
    self.selectBeijing = 1;
    [self beijingBtnAction];
    self.picBkView.backgroundColor = [UIColor whiteColor];
    self.picBkViewColor = [UIColor whiteColor];
    [self changeLabelTextColor];
}
//hei
- (void)beijingImageView2Action{
    self.selectBeijing = 2;
    [self beijingBtnAction];
    self.picBkView.backgroundColor = [UIColor blackColor];
    self.picBkViewColor = [UIColor blackColor];
    [self changeLabelTextColor];//
}
//youshuiyin
- (void)shuiyinImageView1Action{
    self.selectShuiyin = 1;
    [self shuiyinBtnAction];
}
//wushuiyin
- (void)shuiyinImageView2Action{
    
    if ([self.isVIP isEqualToString:@"1"]) {
        self.selectShuiyin = 2;
        [self shuiyinBtnAction];
    }else{
        [JFTools showTipOnHUD:@"请先开通会员"];
    }
}

-(void)requestZitiInfo{
    
    NSDictionary *dic = @{@"user_id": NON(kUserMoudle.user_Id)};
    [kJFClient isHaveFontAndVIP:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.isVIP = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
        if ([self.isVIP isEqualToString:@"1"]) {
            [self.zitiArray removeAllObjects];
            self.zitiArray = (NSMutableArray *)@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        }else{
            NSString *haveFont = [responseObject objectForKey:@"font"];
            self.zitiArray = [NSMutableArray arrayWithArray:[haveFont componentsSeparatedByString:@","]];
            NSArray * allArray = @[@"3",@"4",@"5",@"6",@"7"];
            [self.zitiArray addObjectsFromArray:allArray];
            [self.zitiArray removeObject:@"0"];
            [self.zitiArray removeObject:@""];
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}

- (void)fanhuiBtnAction{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)editBtnAction{
    if (self.bottomBkView.hidden) {
        //如果隐藏了，就显示出来
        self.bottomBkView.hidden = NO;
        [self beijingBtnAction];
        
    }else{
        //隐藏起来
        self.bottomBkView.hidden = YES;
        self.beijingBkView.hidden = YES;
        self.zitiBkView.hidden = YES;
        self.shuiyinBkView.hidden = YES;
    }
}
//添加放置图片的scrollview
- (void)addAllScrollViewWithRectArray:(NSArray *)rectArray withImageArray:(NSArray *)imageArray{
    
    for (int i = 0; i < imageArray.count; i++) {
        CardScrollView *scroll = [[CardScrollView alloc] initWithFrame:[rectArray[i] CGRectValue] withImage:imageArray[i]];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        [self.picBkView addSubview:scroll];
    }
}
//给图片添加文字水印
- (UIImage *)addWaterTextWithImage:(UIImage *)image withLabel:(UILabel *)label{
    
    NSDictionary *attributedDic = @{NSFontAttributeName:label.font,NSForegroundColorAttributeName:label.textColor};
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, SCALE);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [label.text drawAtPoint:label.origin withAttributes:attributedDic];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
    
}
//给图片添加logo水印
- (UIImage *)addWaterTextWithImage:(UIImage *)image withLogo:(UIImage *)logoImage{
    
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, SCALE);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印
//    [logoImage drawInRect:CGRectMake(image.size.width - logoImage.size.width *1.2, 10, logoImage.size.width, logoImage.size.height)];
    [logoImage drawInRect:CGRectMake(image.size.width - 60, 10, 50, 20)];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
//    if (error) {
//        
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"标题" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:alertVC animated:YES completion:nil];
//    }else
//    {
//        
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"标题" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        [alertVC addAction:action];
//        [self presentViewController:alertVC animated:YES completion:nil];
//        
//    }
}

- (void)changeLabelTextColor{
    if (self.mobanNum == 9 || self.mobanNum == 10 || self.mobanNum == 11) {
        return;
    }
    NSArray *viewArray = [self.picBkView subviews];
    for (int i =0; i < viewArray.count; i++) {
        if ([viewArray[i] isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)viewArray[i];
            //tag大于1000的不变颜色
            if (label.tag < 1000) {
                if (self.selectBeijing == 2) {
                    label.textColor = [UIColor whiteColor];
                }else{
                    label.textColor = [UIColor blackColor];
                }
            }
            
        }
    }
}

- (void)changeLabelFont{
    
    NSArray *viewArray = [self.picBkView subviews];
    for (int i =0; i < viewArray.count; i++) {
        if ([viewArray[i] isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)viewArray[i];
            //获取label字体大小
            NSString *size = [label.font.fontDescriptor objectForKey:@"NSFontSizeAttribute"];
            NSInteger fontSize = [size integerValue];
            switch (self.selectZiti) {
                case 1:
                    label.font = FONT1(fontSize);
                    break;
                case 2:
                    label.font = FONT2(fontSize);
                    break;
                case 3:
                    label.font = FONT3(fontSize);
                    break;
                case 4:
                    label.font = FONT4(fontSize);
                    break;
                case 5:
                    label.font = FONT5(fontSize);
                    break;
                case 6:
                    label.font = FONT6(fontSize);
                    break;
                case 7:
                    label.font = FONT7(fontSize);
                    break;
                default:
                    break;
            }
            
        }
    }
}

//完成事件
- (void)wanchengBtnAction{
    
    NSArray *viewArray = [self.picBkView subviews];
    //隐藏
    for (int i =0; i < viewArray.count; i++) {
        if ([viewArray[i] isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)viewArray[i];
            label.hidden = YES;
        }
    }
    UIGraphicsBeginImageContextWithOptions(self.picBkView.frame.size, NO, SCALE);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //剪切指定视图的画面
    [self.picBkView.layer renderInContext:context];
    UIImage * cutImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    for (int i =0; i < viewArray.count; i++) {
        if ([viewArray[i] isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)viewArray[i];
            cutImage = [self addWaterTextWithImage:cutImage withLabel:label];
        }
    }
    //添加logo水印
    if (self.selectShuiyin != 2) {
        cutImage = [self addWaterTextWithImage:cutImage withLogo:ImageNamed(@"水印1")];
    }
    
    UIImageWriteToSavedPhotosAlbum(cutImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //上传图片
    NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
    [JFTools showLoadingHUD];
    [kJFClient uploadPictureWithMethod:@"index.php/Api/Card/update_card" param:dic picData:cutImage paramName:@"image" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"---%@",responseObject);
        //[JFTools showSuccessHUDWithTip:@"上传图片成功"];
        [JFTools HUDHide];
        
        SavePicViewController *save = [[SavePicViewController alloc] init];
        save.picImage = cutImage;
        [kCurNavController pushViewController:save animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];

}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    self.bottomBkView.hidden = YES;
//    self.beijingBkView.hidden = YES;
//    self.shuiyinBkView.hidden = YES;
//    self.zitiBkView.hidden = YES;
//    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
//    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
//    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
//}
- (void)tapPickBkViewAction{
    self.bottomBkView.hidden = YES;
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
}

- (void)makeMoban1{
    CGFloat picWidth = (self.picBkView.width - 50)/3;
    CGFloat picHeight = self.picBkView.height - 105;
    CGRect rect1 = CGRectMake(15, 15, picWidth, picHeight);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+10, 15, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+10, 15, picWidth, picHeight);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.picBkView.mas_right).offset(-12);
        make.top.equalTo(self.picBkView.mas_top).offset(15+picHeight +10);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:20 withType:1];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
 
}
- (void)makeMoban2{
    CGFloat picWidth = (self.picBkView.width)/3;
    CGFloat picHeight = self.picBkView.height - 60;
    CGRect rect1 = CGRectMake(40, 10, picWidth, picHeight);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+100*BiLi_SCREENHEIGHT_NORMAL, CGRectGetMinY(rect1)+10, picWidth/2, (picHeight - 50)/2);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+10, CGRectGetMinY(rect1)+10, picWidth/2, (picHeight - 50)/2);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect1)+100*BiLi_SCREENHEIGHT_NORMAL, CGRectGetMaxY(rect2)+10, picWidth/2, (picHeight - 50)/2);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+10, CGRectGetMaxY(rect2)+10, picWidth/2, (picHeight - 50)/2);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5]] withImageArray:self.imageArray];

    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:17 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_left).offset(CGRectGetMinX(rect1)+picWidth/2);
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-15);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"身高/HEIGHT %@ 体重/WEIGHT %@ 胸围/BUST %@ 腰围/WAIST %@ 臀围/HIPS %@ 鞋码/SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:8 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-55);
        make.centerX.equalTo(self.picBkView.mas_left).offset(CGRectGetMaxX(rect2)+5);
    }];

}
- (void)makeMoban3{
    CGFloat picWidth = (self.picBkView.width)/8;
    CGFloat picHeight = self.picBkView.height - 50;
    CGFloat top = 10;
    CGRect rect1 = CGRectMake(0, top, picWidth*2, picHeight);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1), top, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2), top, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3), top, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4), top, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5), top, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6), top, picWidth, picHeight);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7]] withImageArray:self.imageArray];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"姓名 Name：%@   身高 HEIGHT：%@   体重 WEIGHT：%@   三围 BWH %@ %@ %@",[self.infoDic objectForKey:@"name"],[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"]];
    label2.font = [JFTools fontWithSize:14 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-12);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
 
}
- (void)makeMoban4{
    CGFloat picWidth = (self.picBkView.width - 120)/7;
    CGFloat picHeight = 100 *BiLi_SCREENWIDTH_NORMAL;
    CGFloat top = 90;
    CGRect rect1 = CGRectMake(30, top, picWidth, picHeight);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+20, top, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+20, top, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+20, top, picWidth, picHeight);
    CGRect rect5 = CGRectMake(30, CGRectGetMaxY(rect1)+20, picWidth, picHeight);
     CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+20, CGRectGetMaxY(rect1)+20, picWidth, picHeight);
     CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+20, CGRectGetMaxY(rect1)+20, picWidth, picHeight);
     CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+20, CGRectGetMaxY(rect1)+20, picWidth, picHeight);
    CGRect rect9 = CGRectMake(self.picBkView.width - picWidth*3, 0, picWidth*3, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:20 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(30);
        make.top.equalTo(self.picBkView.mas_top).offset(10);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = [NSString stringWithFormat:@"HEIGHT:%@CM WEIGHT:%@KG",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"]];
    label2.font = [JFTools fontWithSize:12 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(30);
        make.top.equalTo(label1.mas_bottom).offset(10);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = [NSString stringWithFormat:@"BUST:%@ WAIST:%@ HIPS:%@ SHOES:%@",[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label3.font = [JFTools fontWithSize:12 withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(30);
        make.top.equalTo(label2.mas_bottom).offset(0);
    }];


}
- (void)makeMoban5{
    CGFloat picWidth = (self.picBkView.width)/6;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(10, 50, picWidth*2-20, self.picBkView.height - 50 -40);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+10, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect1)+10, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth*2, self.picBkView.height - 4);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
        make.top.equalTo(self.picBkView.mas_top).offset(10);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
    }];
 
}
- (void)makeMoban6{
    CGFloat picWidth = (self.picBkView.width-6)/5;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(15, 50, picWidth*2-30, self.picBkView.height - 50 -40);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+15, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect1)+15, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
        make.top.equalTo(self.picBkView.mas_top).offset(10);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
    }];
 
}
- (void)makeMoban7{
    CGFloat picWidth = (self.picBkView.width-8)/7;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(10, 50, picWidth*2-20, self.picBkView.height - 50 -40);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+10, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth*2, self.picBkView.height - 4);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect1)+10, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
        make.top.equalTo(self.picBkView.mas_top).offset(10);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:9 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
    }];
 
}
- (void)makeMoban8{
    CGFloat picWidth = (self.picBkView.width-10)/8;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(10, 50, picWidth*2-20, self.picBkView.height - 50 -40);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+10, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect10 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect10)+2, 2, picWidth*2, self.picBkView.height - 4);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect1)+10, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9],[NSValue valueWithCGRect:rect10]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:23 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
        make.top.equalTo(self.picBkView.mas_top).offset(10);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:8 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_left).offset(picWidth);
    }];
    

}
- (void)makeMoban9{
    CGFloat picWidth = (self.picBkView.width-6)/6;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2-4, self.picBkView.height - 4);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth*2, self.picBkView.height - 4);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6]] withImageArray:self.imageArray];
    
    UIView *labelBkView = [[UIView alloc] init];
    labelBkView.frame = CGRectMake(2, self.picBkView.height - 80, picWidth*2-4, 60);
    labelBkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.picBkView addSubview:labelBkView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = WHITECOLOR;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [labelBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(labelBkView.mas_centerX);
        make.top.equalTo(labelBkView.mas_top);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = WHITECOLOR;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:9 withType:0];
    [labelBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labelBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(labelBkView.mas_centerX);
    }];
 
}
- (void)makeMoban10{
    CGFloat picWidth = (self.picBkView.width-8)/7;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2-4, self.picBkView.height-4);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth*2, self.picBkView.height - 4);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7]] withImageArray:self.imageArray];
    
    UIView *labelBkView = [[UIView alloc] init];
    labelBkView.frame = CGRectMake(2, self.picBkView.height - 80, picWidth*2-4, 60);
    labelBkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.picBkView addSubview:labelBkView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = WHITECOLOR;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [labelBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(labelBkView.mas_centerX);
        make.top.equalTo(labelBkView.mas_top);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = WHITECOLOR;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:8 withType:0];
    [labelBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labelBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(labelBkView.mas_centerX);
    }];

}
- (void)makeMoban11{
    CGFloat picWidth = (self.picBkView.width-10)/8;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2-4, self.picBkView.height-4);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, 2, picWidth*2, self.picBkView.height - 4);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect10 = CGRectMake(CGRectGetMaxX(rect9)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9],[NSValue valueWithCGRect:rect10]] withImageArray:self.imageArray];
    
    UIView *labelBkView = [[UIView alloc] init];
    labelBkView.frame = CGRectMake(2, self.picBkView.height - 80, picWidth*2-4, 60);
    labelBkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.picBkView addSubview:labelBkView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = WHITECOLOR;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [labelBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(labelBkView.mas_centerX);
        make.top.equalTo(labelBkView.mas_top);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = WHITECOLOR;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"H:%@cm W:%@kg BWH:%@-%@-%@ S:%@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:8 withType:0];
    [labelBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labelBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(labelBkView.mas_centerX);
    }];
  
}
- (void)makeMoban12{
    CGFloat picWidth = (self.picBkView.width-12)/7;
    CGFloat picHeight = (self.picBkView.height - 40 - 4)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth*2, picHeight*2+2);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(50);
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-2);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = @"NAME";
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.bottom.equalTo(label1.mas_top);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(labe2.mas_right).offset(50);
    }];
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label3.mas_right).offset(20);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label4.mas_right).offset(20);
    }];
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label5.mas_right).offset(20);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label6.mas_right).offset(20);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label7.mas_right).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label3.mas_left);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label4.mas_left);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label5.mas_left);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label6.mas_left);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label7.mas_left);
    }];
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label8.mas_left);
    }];
 
}
- (void)makeMoban13{
    CGFloat picWidth = (self.picBkView.width-12)/6;
    CGFloat picHeight = (self.picBkView.height - 40 - 4)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1004;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(50);
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-2);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1005;
    labe2.text = @"NAME";
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.bottom.equalTo(label1.mas_top);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(labe2.mas_right).offset(50);
    }];
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label3.mas_right).offset(20);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label4.mas_right).offset(20);
    }];
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label5.mas_right).offset(20);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label6.mas_right).offset(20);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labe2.mas_centerY);
        make.left.equalTo(label7.mas_right).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label3.mas_left);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label4.mas_left);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label5.mas_left);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label6.mas_left);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label7.mas_left);
    }];
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label8.mas_left);
    }];

}
- (void)makeMoban14{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-8 -left)/5;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(left, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];

    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];

    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];
  
}
- (void)makeMoban15{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-12 -left)/8;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(left, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, 2, picWidth*2, picHeight*2+2);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect10 = CGRectMake(CGRectGetMaxX(rect9)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9],[NSValue valueWithCGRect:rect10]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];
 
}
- (void)makeMoban16{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-10 -left)/6;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(left, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+2, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect1)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect10 = CGRectMake(CGRectGetMaxX(rect9)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9],[NSValue valueWithCGRect:rect10]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];

}
- (void)makeMoban17{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-8 -left)/5;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+60, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect1)+60, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(CGRectGetMaxX(rect1)+5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];

}
- (void)makeMoban18{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-8 -left)/6;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+60, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth*2, picHeight*2+2);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect1)+60, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(CGRectGetMaxX(rect1)+5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];
 
}
- (void)makeMoban19{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-10 -left)/6;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+60, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect1)+60, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(CGRectGetMaxX(rect1)+5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];

}
- (void)makeMoban20{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-12 -left)/8;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+left, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, 2, picWidth*2, picHeight*2+2);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect1)+left, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect10 = CGRectMake(CGRectGetMaxX(rect9)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9],[NSValue valueWithCGRect:rect10]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(CGRectGetMaxX(rect1)+5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];
 
}
- (void)makeMoban21{
    CGFloat left = 60;
    CGFloat picWidth = (self.picBkView.width-10 -left)/7;
    CGFloat picHeight = (self.picBkView.height - 6)/2;
    CGRect rect1 = CGRectMake(2, 2, picWidth*2, picHeight*2+2);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+left, 2, picWidth, picHeight);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, 2, picWidth, picHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, 2, picWidth, picHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect4)+2, 2, picWidth*2, picHeight*2+2);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect1)+left, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, picWidth, picHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9]] withImageArray:self.imageArray];
    
    NSInteger fontSize = 11;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_RGB(255, 0, 97, 1);
    label1.tag = 1006;
    label1.text = @"NAME";
    label1.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(CGRectGetMaxX(rect1)+5);
        make.top.equalTo(self.picBkView.mas_top).offset(40);
    }];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.textColor = COLOR_RGB(255, 0, 97, 1);
    labe2.tag = 1007;
    labe2.text = [self.infoDic objectForKey:@"name"];
    labe2.font = [JFTools fontWithSize:fontSize withType:1];
    [self.picBkView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"HEIGHT";
    label3.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(labe2.mas_bottom).offset(20);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = [self.infoDic objectForKey:@"shengao"];
    label9.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"WEIGHT";
    label4.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label9.mas_bottom);
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text =[self.infoDic objectForKey:@"tizhong"];
    label10.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text =@"BUST";
    label5.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label10.mas_bottom);
    }];
    UILabel *label11 = [[UILabel alloc] init];
    label11.text = [self.infoDic objectForKey:@"xiongwei"];
    label11.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.text =@"WAIST";
    label6.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label11.mas_bottom);
    }];
    UILabel *label12 = [[UILabel alloc] init];
    label12.text = [self.infoDic objectForKey:@"yaowei"];
    label12.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text =@"HIPS";
    label7.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label12.mas_bottom);
    }];
    UILabel *label13 = [[UILabel alloc] init];
    label13.text = [self.infoDic objectForKey:@"tunwei"];
    label13.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text =@"SHOES";
    label8.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label13.mas_bottom);
    }];
    
    UILabel *label14 = [[UILabel alloc] init];
    label14.text = [self.infoDic objectForKey:@"xiema"];
    label14.font = [JFTools fontWithSize:fontSize withType:0];
    [self.picBkView addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label8.mas_bottom);
    }];

}

@end
