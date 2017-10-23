//
//  MakeShuViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/8/15.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "MakeShuViewController.h"
#import "ZitiCollectionViewCell.h"
#import "CardScrollView.h"
#import "SavePicViewController.h"

#define  TopMenuHeight  35

@interface MakeShuViewController ()

@property(nonatomic,strong)UIView *bottomBkView;

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

@property(nonatomic,assign)NSInteger selectBeijing;
@property(nonatomic,assign)NSInteger selectShuiyin;
@property(nonatomic,assign)NSInteger selectZiti;
@property(nonatomic,copy)NSString *isVIP;

@property(nonatomic,strong)UIView *picBkView;
@property(nonatomic,strong)UIColor *picBkViewColor;

@property(nonatomic,strong)UIFont *labelFont;

@end

@implementation MakeShuViewController

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
    
    self.zitiArray = [NSMutableArray array];
    self.fd_interactivePopDisabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_HEX(0xdddddd, 1);
    self.title = @"制作卡片";
    [self setLeftBackNavItem];
    [self setupRightNavButton:@"完成" withTextFont:FONT_REGULAR(16) withTextColor:COLOR_HEX(0xffa632, 1) target:self
                       action:@selector(wanchengBtnAction)];
    
    self.selectBeijing = 1;
    self.selectShuiyin = 1;
    self.selectZiti = 0;
    [self createBottomUI];
    [self createxuanzeBeijingUI];
    [self createshuiyinUI];
    [self createzitiUI];
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
    
}

- (void)createBottomUI{
    
    self.picBkView = [[UIView alloc] initWithFrame:CGRectMake(10, NAVBAR_HEIGHT + TopMenuHeight + 20, SCREEN_WIDTH - 20, SCREEN_HEIGHT - NAVBAR_HEIGHT - TopMenuHeight - 20 - 20)];
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
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.height.equalTo(@TopMenuHeight);
    }];
    
    self.beijingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.beijingBtn setTitle:@"选择背景" forState:UIControlStateNormal];
    self.beijingBtn.titleLabel.font = FONT_REGULAR(15);
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.beijingBtn addTarget:self action:@selector(beijingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.beijingBtn];
    [self.beijingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomBkView.mas_left).offset(0);
        make.centerY.equalTo(self.bottomBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.width / 3, TopMenuHeight));
    }];
    
    self.zitiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.zitiBtn setTitle:@"更换字体" forState:UIControlStateNormal];
    self.zitiBtn.titleLabel.font = FONT_REGULAR(15);
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn addTarget:self action:@selector(zitiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.zitiBtn];
    [self.zitiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomBkView.mas_right).offset(0);
        make.centerY.equalTo(self.bottomBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.width / 3, TopMenuHeight));
    }];
    
    self.shuiyinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shuiyinBtn setTitle:@"去掉水印" forState:UIControlStateNormal];
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
    self.beijingBkView.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.beijingBkView];
    [self.beijingBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBkView.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    self.beijingImageView1 = [[UIImageView alloc] init];
    self.beijingImageView1.image = ImageNamed(@"bbg-shu");
    [self.beijingBkView addSubview:self.beijingImageView1];
    [self.beijingImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.beijingBkView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.beijingBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(77, 93));
    }];
    self.beijingImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beijingImageView1Action)];
    [self.beijingImageView1 addGestureRecognizer:tap1];
    
    self.beijingImageView2 = [[UIImageView alloc] init];
    self.beijingImageView2.image = ImageNamed(@"hbg-shu");
    [self.beijingBkView addSubview:self.beijingImageView2];
    [self.beijingImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beijingBkView.mas_centerX).offset(50);
        make.centerY.equalTo(self.beijingBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(77, 93));
    }];
    self.beijingImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beijingImageView2Action)];
    [self.beijingImageView2 addGestureRecognizer:tap2];
}
- (void)createshuiyinUI{
    
    self.shuiyinBkView = [[UIView alloc] init];
    self.shuiyinBkView.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.shuiyinBkView];
    [self.shuiyinBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBkView.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    self.shuiyinImageView1 = [[UIImageView alloc] init];
    self.shuiyinImageView1.image = ImageNamed(@"shuiyin-shu");
    [self.shuiyinBkView addSubview:self.shuiyinImageView1];
    [self.shuiyinImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shuiyinBkView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.shuiyinBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(77, 93));
    }];
    self.shuiyinImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shuiyinImageView1Action)];
    [self.shuiyinImageView1 addGestureRecognizer:tap1];
    
    self.shuiyinImageView2 = [[UIImageView alloc] init];
    self.shuiyinImageView2.image = ImageNamed(@"wuhuiyin-shu");
    [self.shuiyinBkView addSubview:self.shuiyinImageView2];
    [self.shuiyinImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shuiyinBkView.mas_centerX).offset(50);
        make.centerY.equalTo(self.shuiyinBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(77, 93));
    }];
    self.shuiyinImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shuiyinImageView2Action)];
    [self.shuiyinImageView2 addGestureRecognizer:tap2];
}
- (void)createzitiUI{
    
    self.zitiBkView = [[UIView alloc] init];
    self.zitiBkView.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.zitiBkView];
    [self.zitiBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBkView.mas_bottom).offset(1);
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
    self.collectionView.backgroundColor = WHITECOLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.zitiBkView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.zitiBkView.mas_bottom);
        make.left.equalTo(self.zitiBkView.mas_left).offset(10);
        make.right.equalTo(self.zitiBkView.mas_right).offset(-10);
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

- (void)beijingBtnAction{
    self.beijingBkView.hidden = NO;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    [self.beijingBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    
    if (self.selectBeijing == 1) {
        self.beijingImageView1.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView1.layer.borderWidth = 2;
        self.beijingImageView2.layer.borderWidth = 0;
    }else{
        self.beijingImageView2.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView2.layer.borderWidth = 2;
        self.beijingImageView1.layer.borderWidth = 0;
    }
    
}
- (void)shuiyinBtnAction{
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = NO;
    self.zitiBkView.hidden = YES;
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
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
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
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
            self.zitiArray = (NSMutableArray *)@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        }else{
            NSString *haveFont = [responseObject objectForKey:@"font"];
            self.zitiArray = [NSMutableArray arrayWithArray:[haveFont componentsSeparatedByString:@","]];
            [self.zitiArray removeObject:@"0"];
        }
       [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
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
    [logoImage drawInRect:CGRectMake(image.size.width - logoImage.size.width *1.2, 10, logoImage.size.width, logoImage.size.height)];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
}
- (void)tapPickBkViewAction{
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
}
- (void)makeMoban1{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height - 40);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:40 withType:2];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-105);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
    }];
}
- (void)makeMoban2{
    CGRect rect1 = CGRectMake(10, 10, self.picBkView.width - 20, self.picBkView.height - 120);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:30 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-90);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
}
- (void)makeMoban3{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = [NSString stringWithFormat:@"SHOES %@",[self.infoDic objectForKey:@"xiema"]];
    label1.font = [JFTools fontWithSize:17 withType:0];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = [NSString stringWithFormat:@"HIPS %@",[self.infoDic objectForKey:@"tunwei"]];
    label2.font = [JFTools fontWithSize:17 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(label1.mas_top).offset(3);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = [NSString stringWithFormat:@"WAIST %@",[self.infoDic objectForKey:@"yaowei"]];
    label3.font = [JFTools fontWithSize:17 withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(label2.mas_top).offset(3);
    }];
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = [NSString stringWithFormat:@"BUST %@",[self.infoDic objectForKey:@"xiongwei"]];
    label4.font = [JFTools fontWithSize:17 withType:0];
    [self.picBkView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(label3.mas_top).offset(3);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text = [NSString stringWithFormat:@"%@",[self.infoDic objectForKey:@"tizhong"]];
    label5.font = [JFTools fontWithSize:17 withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(label4.mas_top).offset(3);
    }];
    UILabel *label6= [[UILabel alloc] init];
    label6.text = [NSString stringWithFormat:@"%@",[self.infoDic objectForKey:@"shengao"]];
    label6.font = [JFTools fontWithSize:17 withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(label5.mas_top).offset(3);
    }];
    UILabel *label7= [[UILabel alloc] init];
    label7.text = [NSString stringWithFormat:@"%@",[self.infoDic objectForKey:@"name"]];
    label7.font = [JFTools fontWithSize:23 withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(20);
        make.bottom.equalTo(label6.mas_top).offset(3);
    }];


}
- (void)makeMoban4{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:30 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-100);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
 
}
- (void)makeMoban5{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-70);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"%@ · %@ · %@ · %@ · %@ · %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:11 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_top).offset(-30);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];

}
- (void)makeMoban6{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:17 withType:1];
    label1.textColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-100);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"%@ / %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"]];
    label2.font = [JFTools fontWithSize:11 withType:0];
    label2.textColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = [NSString stringWithFormat:@"%@ / %@ / %@ / %@",[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label3.font = [JFTools fontWithSize:11 withType:0];
    label3.textColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(0);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];

    UIView *quanView = [[UIView alloc] init];
    quanView.backgroundColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:quanView];
    [quanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.height.equalTo(@3);
    }];
    UIView *quanView2 = [[UIView alloc] init];
    quanView2.backgroundColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:quanView2];
    [quanView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.height.equalTo(@3);
    }];
    UIView *quanView3 = [[UIView alloc] init];
    quanView3.backgroundColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:quanView3];
    [quanView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.width.equalTo(@3);
    }];
    UIView *quanView4 = [[UIView alloc] init];
    quanView4.backgroundColor = COLOR_RGB(172, 180, 83, 1);
    [self.picBkView addSubview:quanView4];
    [quanView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.width.equalTo(@3);
    }];
}
- (void)makeMoban7{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:17 withType:1];
    label1.textColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-100);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"%@ / %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"]];
    label2.font = [JFTools fontWithSize:11 withType:0];
    label2.textColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = [NSString stringWithFormat:@"%@ / %@ / %@ / %@",[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label3.font = [JFTools fontWithSize:11 withType:0];
    label3.textColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(0);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
    
    UIView *quanView = [[UIView alloc] init];
    quanView.backgroundColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:quanView];
    [quanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.height.equalTo(@3);
    }];
    UIView *quanView2 = [[UIView alloc] init];
    quanView2.backgroundColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:quanView2];
    [quanView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.height.equalTo(@3);
    }];
    UIView *quanView3 = [[UIView alloc] init];
    quanView3.backgroundColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:quanView3];
    [quanView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.width.equalTo(@3);
    }];
    UIView *quanView4 = [[UIView alloc] init];
    quanView4.backgroundColor = COLOR_RGB(0, 161, 228, 1);
    [self.picBkView addSubview:quanView4];
    [quanView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.width.equalTo(@3);
    }];

}
- (void)makeMoban8{
    CGRect rect1 = CGRectMake(0, 0, self.picBkView.width, self.picBkView.height);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:17 withType:1];
    label1.textColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-100);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"%@ / %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"]];
    label2.font = [JFTools fontWithSize:11 withType:0];
    label2.textColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = [NSString stringWithFormat:@"%@ / %@ / %@ / %@",[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label3.font = [JFTools fontWithSize:11 withType:0];
    label3.textColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(0);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
    
    UIView *quanView = [[UIView alloc] init];
    quanView.backgroundColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:quanView];
    [quanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.height.equalTo(@3);
    }];
    UIView *quanView2 = [[UIView alloc] init];
    quanView2.backgroundColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:quanView2];
    [quanView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.height.equalTo(@3);
    }];
    UIView *quanView3 = [[UIView alloc] init];
    quanView3.backgroundColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:quanView3];
    [quanView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.width.equalTo(@3);
    }];
    UIView *quanView4 = [[UIView alloc] init];
    quanView4.backgroundColor = COLOR_RGB(226, 0, 52, 1);
    [self.picBkView addSubview:quanView4];
    [quanView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-20);
        make.right.equalTo(self.picBkView.mas_right).offset(-15);
        make.top.equalTo(self.picBkView.mas_top).offset(20);
        make.width.equalTo(@3);
    }];
 
}
- (void)makeMoban9{
    CGRect rect1 = CGRectMake(10, 20, (self.picBkView.width- 30)/2, self.picBkView.height - 160);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+10, 20, (self.picBkView.width- 30)/2, self.picBkView.height - 100);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    //label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:22 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(10);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-120);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    //label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(10);
        make.top.equalTo(label1.mas_bottom).offset(30);
    }];

}
- (void)makeMoban10{
    CGFloat twoHeight = self.picBkView.height - 120 - 10;
    CGRect rect1 = CGRectMake(10, 10, self.picBkView.width - 20, twoHeight / 5*2);
    CGRect rect2 = CGRectMake(10, CGRectGetMaxY(rect1)+10, (self.picBkView.width - 30)/2, twoHeight / 5*3);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+10, CGRectGetMaxY(rect1)+10, (self.picBkView.width - 30)/2, twoHeight / 5*3);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-90);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
 
}
- (void)makeMoban11{
    
    CGFloat imageWidth = (self.picBkView.width - 55) /2;
    CGFloat imageHeight = (self.picBkView.height - 140) /2;
    
    CGRect rect1 = CGRectMake(20, 20, imageWidth, imageHeight);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+20, 20, imageWidth, imageHeight);
    CGRect rect3 = CGRectMake(20, CGRectGetMaxY(rect1)+20, imageWidth, imageHeight);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect1)+20, CGRectGetMaxY(rect1)+20, imageWidth, imageHeight);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, self.picBkView.height - 85, 100, 40)];
    //label1.centerX = self.picBkView.centerX;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:17 withType:2];
    [self.picBkView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, self.picBkView.height - 50, 200, 20)];
    //label2.centerX = self.picBkView.centerX;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"]];
    label2.font = [JFTools fontWithSize:12 withType:0];
    [self.picBkView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, self.picBkView.height - 30, 300, 20)];
    //label2.centerX = self.picBkView.centerX;
    label3.text = [NSString stringWithFormat:@"BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label3.font = [JFTools fontWithSize:12 withType:0];
    [self.picBkView addSubview:label3];
    
}
- (void)makeMoban12{
    CGFloat twoHeight = self.picBkView.height - 120 - 5;
    CGRect rect1 = CGRectMake(5, 5, self.picBkView.width - 10, twoHeight / 3*2);
    CGRect rect2 = CGRectMake(5, CGRectGetMaxY(rect1)+5, (self.picBkView.width - 20)/3, twoHeight / 3*1);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+5, CGRectGetMaxY(rect1)+5, (self.picBkView.width - 20)/3, twoHeight / 3*1);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+5, CGRectGetMaxY(rect1)+5, (self.picBkView.width - 20)/3, twoHeight / 3*1);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-80);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
 
}
- (void)makeMoban13{
    CGFloat twoHeight = self.picBkView.height - 120 - 10;
    CGRect rect1 = CGRectMake(5, 5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1)+5, 5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+5, 5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect4 = CGRectMake(5, CGRectGetMaxY(rect1)+5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+5, CGRectGetMaxY(rect1)+5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+5, CGRectGetMaxY(rect1)+5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect7 = CGRectMake(5, CGRectGetMaxY(rect4)+5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+5, CGRectGetMaxY(rect4)+5, (self.picBkView.width - 20)/3, twoHeight / 3);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+5, CGRectGetMaxY(rect4)+5, (self.picBkView.width - 20)/3, twoHeight / 3);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_bottom).offset(-80);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.picBkView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
    

}
- (void)makeMoban14{
    CGFloat twoHeight = self.picBkView.height - 80 - 9;
    CGRect rect1 = CGRectMake(5, 5, self.picBkView.width - 10, twoHeight / 2);
    CGRect rect2 = CGRectMake(5, CGRectGetMaxY(rect1)+80, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2)+2, CGRectGetMaxY(rect1)+80, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect4 = CGRectMake(CGRectGetMaxX(rect3)+2, CGRectGetMaxY(rect1)+80, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, CGRectGetMaxY(rect1)+80, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect6 = CGRectMake(5, CGRectGetMaxY(rect2)+2, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect2)+2, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect2)+2, (self.picBkView.width - 16)/4, twoHeight / 4);
    CGRect rect9 = CGRectMake(CGRectGetMaxX(rect8)+2, CGRectGetMaxY(rect2)+2, (self.picBkView.width - 16)/4, twoHeight / 4);
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picBkView.mas_centerX);
        make.top.equalTo(self.picBkView.mas_top).offset(twoHeight/2+15);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"HEIGHT %@ WEIGHT %@ BUST %@ WAIST %@ HIPS %@ SHOES %@",[self.infoDic objectForKey:@"shengao"],[self.infoDic objectForKey:@"tizhong"],[self.infoDic objectForKey:@"xiongwei"],[self.infoDic objectForKey:@"yaowei"],[self.infoDic objectForKey:@"tunwei"],[self.infoDic objectForKey:@"xiema"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.centerX.equalTo(self.picBkView.mas_centerX);
    }];
 
}
- (void)makeMoban15{
    CGFloat twoHeight = self.picBkView.height - 80 - 10;
    CGRect rect1 = CGRectMake(5, 5, (self.picBkView.width - 10)/3, twoHeight / 7 *3);
    CGRect rect2 = CGRectMake(CGRectGetMaxX(rect1), 5, (self.picBkView.width - 10)/3, twoHeight / 7 *3);
    CGRect rect3 = CGRectMake(CGRectGetMaxX(rect2), 5, (self.picBkView.width - 10)/3, twoHeight / 7 *3);

    CGFloat bottomWidth = (self.picBkView.width-10-10)/6;
    CGFloat bottomHeight =  (twoHeight/7*4-4)/3;
    CGRect rect4 = CGRectMake(5, CGRectGetMaxY(rect1)+80,bottomWidth,bottomHeight);
    CGRect rect5 = CGRectMake(CGRectGetMaxX(rect4)+2, CGRectGetMaxY(rect1)+80,bottomWidth,bottomHeight);
    CGRect rect6 = CGRectMake(CGRectGetMaxX(rect5)+2, CGRectGetMaxY(rect1)+80,bottomWidth,bottomHeight);
    CGRect rect7 = CGRectMake(CGRectGetMaxX(rect6)+2, CGRectGetMaxY(rect1)+80,bottomWidth,bottomHeight);
    CGRect rect8 = CGRectMake(CGRectGetMaxX(rect7)+2, CGRectGetMaxY(rect1)+80,bottomWidth*2 +2,bottomHeight*2+2);
    
    CGRect rect9 = CGRectMake(5, CGRectGetMaxY(rect4)+2,bottomWidth,bottomHeight);
    CGRect rect10 = CGRectMake(CGRectGetMaxX(rect9)+2, CGRectGetMaxY(rect4)+2,bottomWidth,bottomHeight);
    CGRect rect11 = CGRectMake(CGRectGetMaxX(rect10)+2, CGRectGetMaxY(rect4)+2,bottomWidth,bottomHeight);
    CGRect rect12 = CGRectMake(CGRectGetMaxX(rect11)+2, CGRectGetMaxY(rect4)+2,bottomWidth,bottomHeight);
    
    CGRect rect13 = CGRectMake(0, CGRectGetMaxY(rect9)+2,bottomWidth*2+2,bottomHeight);
    CGRect rect14 = CGRectMake(CGRectGetMaxX(rect13)+2, CGRectGetMaxY(rect9)+2,bottomWidth,bottomHeight);
    CGRect rect15 = CGRectMake(CGRectGetMaxX(rect14)+2, CGRectGetMaxY(rect9)+2,bottomWidth,bottomHeight);
    CGRect rect16 = CGRectMake(CGRectGetMaxX(rect15)+2, CGRectGetMaxY(rect9)+2,bottomWidth,bottomHeight);
    CGRect rect17 = CGRectMake(CGRectGetMaxX(rect16)+2, CGRectGetMaxY(rect9)+2,bottomWidth,bottomHeight);
    
    [self addAllScrollViewWithRectArray:@[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3],[NSValue valueWithCGRect:rect4],[NSValue valueWithCGRect:rect5],[NSValue valueWithCGRect:rect6],[NSValue valueWithCGRect:rect7],[NSValue valueWithCGRect:rect8],[NSValue valueWithCGRect:rect9],[NSValue valueWithCGRect:rect10],[NSValue valueWithCGRect:rect11],[NSValue valueWithCGRect:rect12],[NSValue valueWithCGRect:rect13],[NSValue valueWithCGRect:rect14],[NSValue valueWithCGRect:rect15],[NSValue valueWithCGRect:rect16],[NSValue valueWithCGRect:rect17]] withImageArray:self.imageArray];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [self.infoDic objectForKey:@"name"];
    label1.font = [JFTools fontWithSize:25 withType:1];
    [self.picBkView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picBkView.mas_left).offset(15);
        make.top.equalTo(self.picBkView.mas_top).offset(CGRectGetMaxY(rect1)+20);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.numberOfLines = 0;
    label2.text = [NSString stringWithFormat:@"HEIGHT\n%@",[self.infoDic objectForKey:@"shengao"]];
    label2.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(15);
        make.centerY.equalTo(label1.mas_centerY);
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.numberOfLines = 0;
    label3.text = [NSString stringWithFormat:@"WEIGHT\n%@",[self.infoDic objectForKey:@"tizhong"]];
    label3.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(10);
        make.centerY.equalTo(label1.mas_centerY);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.numberOfLines = 0;
    label5.text = [NSString stringWithFormat:@"BUST\n%@",[self.infoDic objectForKey:@"xiongwei"]];
    label5.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right).offset(10);
        make.centerY.equalTo(label1.mas_centerY);
    }];
    UILabel *label6 = [[UILabel alloc] init];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.numberOfLines = 0;
    label6.text = [NSString stringWithFormat:@"WAIST\n%@",[self.infoDic objectForKey:@"yaowei"]];
    label6.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label5.mas_right).offset(10);
        make.centerY.equalTo(label1.mas_centerY);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.numberOfLines = 0;
    label7.text = [NSString stringWithFormat:@"HIPS\n%@",[self.infoDic objectForKey:@"tunwei"]];
    label7.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label6.mas_right).offset(10);
        make.centerY.equalTo(label1.mas_centerY);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.textAlignment = NSTextAlignmentCenter;
    label8.numberOfLines = 0;
    label8.text = [NSString stringWithFormat:@"SHOES\n%@",[self.infoDic objectForKey:@"xiema"]];
    label8.font = [JFTools fontWithSize:10 withType:0];
    [self.picBkView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label7.mas_right).offset(10);
        make.centerY.equalTo(label1.mas_centerY);
    }];
    
}
@end
