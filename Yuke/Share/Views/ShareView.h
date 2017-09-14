//
//  ShareView.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/8/16.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kShareViewControllerBottomViewHeight = 110.0;

static CGFloat kShareViewControllerBottomViewSeptorLineLeftMargin = 43.0;
static CGFloat kShareViewControllerBottomViewTitlelabelTopMargin = 19.0;
static CGFloat kShareViewControllerBottomViewSeptorLineRightMargin = 15.0;

static CGFloat kShareViewControllerBottomViewCollectionViewTopMargin = 13.0;
static CGFloat kShareViewControllerBottomViewCollectionViewBottomMargin = 10.0;

@class ShareView;

@protocol ShareViewDelegate <NSObject>

@optional

/*
 *  分享view点击了分享按钮的代理事件
 *
 *  @param shareView 当前的分享view
 *
 *  @param activity 当前的分享事件对象
 *
 */
- (void)shareView:(ShareView *) shareView didClickActivity:(UIActivity *) activity;

@end

@interface ShareView : UIView

@property (nonatomic, weak) id<ShareViewDelegate> delegate ;

@end
