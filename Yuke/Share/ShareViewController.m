//
//  ShareViewController.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/8.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ShareViewController.h"

#import "WeixinActivity.h"
#import "FriendActivity.h"
#import "QQActivity.h"
#import "QQZoneActivity.h"
#import "WeiboActivity.h"

#pragma mark - ShareViewControllerCell-----------------------------------------------------------

static CGFloat kShareViewControllerCellImageViewWidthHeight = 34.0;

@interface ShareViewControllerCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UILabel *descLabel ;

@property (nonatomic, copy) NSString *imageName ;
@property (nonatomic, copy) NSString *titleString ;

@end

@implementation ShareViewControllerCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.descLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kShareViewControllerCellImageViewWidthHeight * BiLi_SCREENHEIGHT_NORMAL, kShareViewControllerCellImageViewWidthHeight * BiLi_SCREENHEIGHT_NORMAL));
        }];
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(self.descLabel.height);
        }];
    }
    return self;
}

#pragma mark - setter

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName.copy;
    
    self.imageView.image = [UIImage imageNamed:_imageName];
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString.copy;
    
    self.descLabel.text = _titleString;
    [self.descLabel sizeToFit];
    
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.descLabel.height);
    }];
}

#pragma mark - getter

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        
        _descLabel.font = SYSTEM_FONT(12.0);
        _descLabel.textColor = COLOR_HEX(0x666666, 1.0);
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}

@end

static NSString *kShareViewControllerCellIdentifier = @"kShareViewControllerCellIdentifier" ;


#pragma mark - ShareViewController-----------------------------------------------------------

static CGFloat kShareViewControllerBottomViewHeight = 120.0;

static CGFloat kShareViewControllerBottomViewSeptorLineLeftMargin = 43.0;
static CGFloat kShareViewControllerBottomViewTitlelabelTopMargin = 19.0;
static CGFloat kShareViewControllerBottomViewSeptorLineRightMargin = 15.0;

static CGFloat kShareViewControllerBottomViewCollectionViewTopMargin = 13.0;
static CGFloat kShareViewControllerBottomViewCollectionViewBottomMargin = 10.0;


@interface ShareViewController ()

    <
        UICollectionViewDelegate,
        UICollectionViewDataSource
    >

@property (nonatomic, strong) UIButton *coverButton ;

@property (nonatomic, strong) UIView *bottomView ;

@property (nonatomic, strong) UIView *topLeftSeptorLine ;
@property (nonatomic, strong) UIView *topRightSeptorLine ;

@property (nonatomic, strong) UILabel *titleLabel ;

@property (nonatomic, strong) UICollectionView *collectionView ;

@property (nonatomic, strong) NSArray *imageNameArray ;
@property (nonatomic, strong) NSArray *titleStringArray ;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.coverButton];
    
    [self.view addSubview:self.bottomView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self show];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - event response

- (void)coverButtonClick:(UIButton *) coverbutton{
    
    [self dismiss];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShareViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kShareViewControllerCellIdentifier forIndexPath:indexPath];
    cell.imageName = self.imageNameArray[indexPath.item];
    cell.titleString = self.titleStringArray[indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat itemWidth = SCREEN_WIDTH / self.imageNameArray.count;
    CGFloat itemHeight = collectionView.height;
    
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShareViewControllerCell * cell = (ShareViewControllerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    WeakSelf;
    if (cell) {
        
        // 添加缩放动画
        [UIView animateWithDuration:0.1 animations:^{
            cell.transform = CGAffineTransformMakeScale(0.85, 0.85);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                [weakSelf shareWithIndexPath:indexPath];
            }];
        }];
    }
}

#pragma mark - private method

- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.coverButton.alpha = 1.0;
        
        self.bottomView.top = SCREEN_HEIGHT - kShareViewControllerBottomViewHeight * BiLi_SCREENHEIGHT_NORMAL;
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.coverButton.alpha = 0.0;
        
        self.bottomView.top = SCREEN_HEIGHT ;
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)shareWithIndexPath:(NSIndexPath *) indexPath{
    
    switch (indexPath.item) {
        case 0:
        {
            WeixinActivity *weixinActivity = [WeixinActivity new];
            
            [weixinActivity prepareWithActivityItems:@[self.shareTitleString , self.shareDescriptionString , self.shareUrlString , self.shareImage]];
        }
            break;
        case 1:
        {
            FriendActivity *friendActivity = [FriendActivity new];
            
            [friendActivity prepareWithActivityItems:@[self.shareTitleString , self.shareDescriptionString , self.shareUrlString , self.shareImage]];
        }
            break;
        case 2:
        {
            QQActivity *qqActivity = [QQActivity new];
            
            [qqActivity prepareWithActivityItems:@[self.shareTitleString , self.shareDescriptionString , self.shareUrlString , self.shareImage]];
        }
            break;
        case 3:
        {
            QQZoneActivity *qqZoneActivity = [QQZoneActivity new];
            
            [qqZoneActivity prepareWithActivityItems:@[self.shareTitleString , self.shareDescriptionString , self.shareUrlString , self.shareImage]];
        }
            break;
        case 4:
        {
            WeiboActivity *weiboActivity = [WeiboActivity new];
            
            [weiboActivity prepareWithActivityItems:@[self.shareTitleString , self.shareDescriptionString , self.shareUrlString , self.shareImage]];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getter

-(UIButton *)coverButton{
    if (!_coverButton) {
        _coverButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _coverButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        [_coverButton addTarget:self action:@selector(coverButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _coverButton.alpha = 0.0;
    }
    return _coverButton;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, kShareViewControllerBottomViewHeight * BiLi_SCREENHEIGHT_NORMAL)];
        
        _bottomView.backgroundColor = WHITECOLOR;
        
        [_bottomView addSubview:self.titleLabel];
        [_bottomView addSubview:self.topLeftSeptorLine];
        [_bottomView addSubview:self.topRightSeptorLine];
        
        [_bottomView addSubview:self.collectionView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(self.titleLabel.size);
            make.centerX.equalTo(_bottomView);
            make.top.equalTo(_bottomView.mas_top).with.offset(kShareViewControllerBottomViewTitlelabelTopMargin * BiLi_SCREENHEIGHT_NORMAL);
        }];
        
        [self.topLeftSeptorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(_bottomView).with.offset(kShareViewControllerBottomViewSeptorLineLeftMargin );
            make.right.equalTo(self.titleLabel.mas_left).with.offset(- kShareViewControllerBottomViewSeptorLineRightMargin * BiLi_SCREENWIDTH_NORMAL);
            make.height.mas_offset(1.0);
        }];
        
        [self.topRightSeptorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).with.offset(kShareViewControllerBottomViewSeptorLineRightMargin * BiLi_SCREENWIDTH_NORMAL);
            make.right.equalTo(_bottomView).with.offset(- kShareViewControllerBottomViewSeptorLineLeftMargin);
            make.height.equalTo(self.topLeftSeptorLine);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(kShareViewControllerBottomViewCollectionViewTopMargin * BiLi_SCREENHEIGHT_NORMAL);
            make.bottom.equalTo(_bottomView.mas_bottom).with.offset(- kShareViewControllerBottomViewCollectionViewBottomMargin * BiLi_SCREENHEIGHT_NORMAL);
            make.left.equalTo(_bottomView);
            make.right.equalTo(_bottomView);
        }];
    }
    
    return _bottomView ;
}

-(UIView *)topLeftSeptorLine{
    if (!_topLeftSeptorLine) {
        _topLeftSeptorLine = [[UIView alloc] init];
        _topLeftSeptorLine.backgroundColor = COLOR_HEX(0xeeeeee, 1.0);
    }
    return _topLeftSeptorLine;
}

-(UIView *)topRightSeptorLine{
    if (!_topRightSeptorLine) {
        _topRightSeptorLine = [[UIView alloc] init];
        _topRightSeptorLine.backgroundColor = COLOR_HEX(0xeeeeee, 1.0);

    }
    return _topRightSeptorLine;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.text = @"分享到";
        _titleLabel.font = SYSTEM_FONT(12.0);
        _titleLabel.textColor = COLOR_HEX(0x666666, 1.0);
        
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[ShareViewControllerCell class] forCellWithReuseIdentifier:kShareViewControllerCellIdentifier];
        
    }
    return _collectionView;
}

-(NSArray *)imageNameArray{
    if (!_imageNameArray) {
        _imageNameArray = @[@"weixin-", @"pengyouquan" , @"QQ" , @"QQ空间",@"新浪微博" ];
    }
    return _imageNameArray;
}

-(NSArray *)titleStringArray{
    if (!_titleStringArray) {
        _titleStringArray = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"微博"];
    }
    return _titleStringArray;
}

@end
