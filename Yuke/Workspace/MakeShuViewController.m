//
//  MakeShuViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/8/15.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "MakeShuViewController.h"
#import "ZitiCollectionViewCell.h"

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
@property(nonatomic,strong)NSArray *zitiArray;

@property(nonatomic,assign)NSInteger selectBeijing;
@property(nonatomic,assign)NSInteger selectShuiyin;
@property(nonatomic,assign)NSInteger selectZiti;

@end

@implementation MakeShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_HEX(0x999999, 1);
    self.title = @"zhizuokapian";
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
    
    [self requestZitiInfo];
}

- (void)createBottomUI{
    
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
    self.beijingBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.beijingBkView];
    [self.beijingBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBkView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    self.beijingImageView1 = [[UIImageView alloc] init];
    self.beijingImageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
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
    self.beijingImageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
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
    self.shuiyinBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.shuiyinBkView];
    [self.shuiyinBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBkView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    self.shuiyinImageView1 = [[UIImageView alloc] init];
    self.shuiyinImageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
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
    self.shuiyinImageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
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
    self.zitiBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.zitiBkView];
    [self.zitiBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomBkView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    CGFloat hotPicWidth = 77;
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
    
    cell.zitiLabel.text = self.zitiArray[indexPath.row];
    if (indexPath.row == self.selectZiti) {
        
        cell.contentView.layer.borderWidth = 2;
        cell.contentView.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
    }else{
        
        cell.contentView.layer.borderWidth = 0;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    self.selectZiti = indexPath.row;
    [self.collectionView reloadData];
}

- (void)wanchengBtnAction{
    
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

- (void)beijingImageView1Action{
    self.selectBeijing = 1;
    [self beijingBtnAction];
}
- (void)beijingImageView2Action{
    self.selectBeijing = 2;
    [self beijingBtnAction];
}
- (void)shuiyinImageView1Action{
    self.selectShuiyin = 1;
    [self shuiyinBtnAction];
}
- (void)shuiyinImageView2Action{
    self.selectShuiyin = 2;
    [self shuiyinBtnAction];
}

-(void)requestZitiInfo{
    
    self.zitiArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    [self.collectionView reloadData];
}

@end
