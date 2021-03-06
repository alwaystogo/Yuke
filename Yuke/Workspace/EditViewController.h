//
//  EditViewController.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "BaseViewController.h"
#import "YYFPickView.h"
#import "YYFPickViewThree.h"

@interface EditViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet LimitTextField *nickNameTextField;//xing
@property (weak, nonatomic) IBOutlet UILabel *hangyeLabel;//shengao
@property (weak, nonatomic) IBOutlet UILabel *yearsLabel;//tizhong
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//sanwei
@property (weak, nonatomic) IBOutlet UILabel *xieMaLabel;//xie
@property (weak, nonatomic) IBOutlet UITextField *jigouTextField;//diqu

@property(nonatomic,strong)NSMutableArray *shengaoArray;
@property(nonatomic,strong)NSMutableArray *tizhongArray;
@property(nonatomic,strong)NSMutableArray *xieMaArray;
@property(nonatomic,copy  )NSString *hangyeId;
@property(nonatomic,copy)NSString *yearsId;

@property(nonatomic,strong)YYFPickViewThree *addressPickView;

@property(nonatomic,strong)NSDictionary *userInfoDic;

@property(nonatomic,assign)NSInteger mobanNum;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,assign)NSInteger type;//0竖 1横 2是视频
- (instancetype)initWith:(NSInteger)mobanNum withImageArray:(NSArray *)imageArray withType:(NSInteger)type;
@end
