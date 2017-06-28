//
//  ShareView.h
//  LinkFinance
//
//  Created by yangyunfei on 16/7/23.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WeChatBtnBlock)();
typedef void(^FriendShipBtnBlock)();

@interface ShareView : UIView

@property (weak, nonatomic) IBOutlet UIButton *WeChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *FriendShipBtn;

@property(nonatomic,strong)WeChatBtnBlock weChatBtnBlock;
@property(nonatomic,strong)FriendShipBtnBlock friendShipBtnBlock;

@end
