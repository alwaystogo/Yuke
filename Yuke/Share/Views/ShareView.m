//
//  ShareView.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/8/16.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ShareView.h"

#import "ShareViewControllerCell.h"

#import "WeixinActivity.h"
#import "FriendActivity.h"
#import "QQActivity.h"
#import "QQZoneActivity.h"
#import "WeiboActivity.h"

@interface ShareView ()

    <
        UICollectionViewDelegate,
        UICollectionViewDataSource
    >

@property (nonatomic, strong) UIView *topLeftSeptorLine ;
@property (nonatomic, strong) UIView *topRightSeptorLine ;

@property (nonatomic, strong) UILabel *titleLabel ;

@property (nonatomic, strong) UICollectionView *collectionView ;

@property (nonatomic, strong) NSArray *imageNameArray ;
@property (nonatomic, strong) NSArray *titleStringArray ;

@end

@implementation ShareView

#pragma mark - life cycle

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WHITECOLOR;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.topLeftSeptorLine];
        [self addSubview:self.topRightSeptorLine];
        
        [self addSubview:self.collectionView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(self.titleLabel.size);
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).with.offset(kShareViewControllerBottomViewTitlelabelTopMargin * BiLi_SCREENHEIGHT_NORMAL);
        }];
        
        [self.topLeftSeptorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self).with.offset(kShareViewControllerBottomViewSeptorLineLeftMargin );
            make.right.equalTo(self.titleLabel.mas_left).with.offset(- kShareViewControllerBottomViewSeptorLineRightMargin * BiLi_SCREENWIDTH_NORMAL);
            make.height.mas_offset(1.0);
        }];
        
        [self.topRightSeptorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).with.offset(kShareViewControllerBottomViewSeptorLineRightMargin * BiLi_SCREENWIDTH_NORMAL);
            make.right.equalTo(self).with.offset(- kShareViewControllerBottomViewSeptorLineLeftMargin);
            make.height.equalTo(self.topLeftSeptorLine);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(kShareViewControllerBottomViewCollectionViewTopMargin * BiLi_SCREENHEIGHT_NORMAL);
            make.bottom.equalTo(self.mas_bottom).with.offset(- kShareViewControllerBottomViewCollectionViewBottomMargin * BiLi_SCREENHEIGHT_NORMAL - kAppDelegate.tabBarController.bottomSafeMargin);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
    }
    return self;
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

- (void)shareWithIndexPath:(NSIndexPath *) indexPath{
    
    switch (indexPath.item) {
        case 0:
        {
            WeixinActivity *weixinActivity = [WeixinActivity new];
            
            if ([self.delegate respondsToSelector:@selector(shareView:didClickActivity:)]) {
                [self.delegate shareView:self didClickActivity:weixinActivity];
            }
            
        }
            break;
        case 1:
        {
            FriendActivity *friendActivity = [FriendActivity new];
            
            if ([self.delegate respondsToSelector:@selector(shareView:didClickActivity:)]) {
                [self.delegate shareView:self didClickActivity:friendActivity];
            }
        }
            break;
        case 2:
        {
            QQActivity *qqActivity = [QQActivity new];
            
            if ([self.delegate respondsToSelector:@selector(shareView:didClickActivity:)]) {
                [self.delegate shareView:self didClickActivity:qqActivity];
            }
        }
            break;
        case 3:
        {
            QQZoneActivity *qqZoneActivity = [QQZoneActivity new];
            
            if ([self.delegate respondsToSelector:@selector(shareView:didClickActivity:)]) {
                [self.delegate shareView:self didClickActivity:qqZoneActivity];
            }
        }
            break;
        case 4:
        {
            WeiboActivity *weiboActivity = [WeiboActivity new];
            
            if ([self.delegate respondsToSelector:@selector(shareView:didClickActivity:)]) {
                [self.delegate shareView:self didClickActivity:weiboActivity];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - getter

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
        _imageNameArray = @[@"weixin-", @"pengyouquan" , @"QQ" , @"QQ空间" , @"新浪微博"]; // , @"新浪微博"
    }
    return _imageNameArray;
}

-(NSArray *)titleStringArray{
    if (!_titleStringArray) {
        _titleStringArray = @[@"微信好友",@"微信朋友圈",@"QQ",@"QQ空间",@"新浪微博"]; // ,@"新浪微博"
    }
    return _titleStringArray;
}

@end
