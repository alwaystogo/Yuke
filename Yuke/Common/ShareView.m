//
//  ShareView.m
//  LinkFinance
//
//  Created by yangyunfei on 16/7/23.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)bkBtnAction:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)weChatBtnAction:(id)sender {
    
    if (self.weChatBtnBlock) {
        
        self.weChatBtnBlock();
    }
}
- (IBAction)friendShipBtnAction:(id)sender {
    
    if (self.friendShipBtnBlock) {
        
        self.friendShipBtnBlock();
    }
   
}
@end
