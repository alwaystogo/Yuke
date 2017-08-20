//
//  MoteCardsListViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "MoteCardsListViewController.h"
#import "YuePaisheTableViewCell.h"
#import "EditViewController.h"
#import "TZImagePickerController.h"

@interface MoteCardsListViewController ()

@end

@implementation MoteCardsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择模板";
    [self setLeftBackNavItem];
    self.view.backgroundColor = COLOR_HEX(0xdddddd, 1);
    self.mobanArray = @[@"模板一",@"模板二",@"模板三",@"模板四",@"模板五",@"模板六",@"模板七",@"模板八",@"模板九",@"模板十",@"模板十一",@"模板十二",@"模板十三",@"模板十四",@"模板十五"];
    [self createUI];
}

- (void)createUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 210;
    self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];

}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.mobanArray.count;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify = @"YuePaisheTableViewCell";
    
    YuePaisheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YuePaisheTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.picImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.section);
    self.selectedNum = indexPath.section;
    
    [LoginViewController checkLogin:^(BOOL result) {
        
        if (result) {
            //[JFTools showTipOnHUD:@"登录成功"];
            NSInteger max = 0;
            if (self.selectedNum == 0) {
                max = 3;
            }
            if (self.selectedNum == 1) {
                max = 5;
            }
            if (self.selectedNum == 2) {
                max = 7;
            }
            if (self.selectedNum == 3) {
                max = 9;
            }
            if (self.selectedNum == 4) {
                max = 1;
            }
            if (self.selectedNum == 5) {
                max = 1;
            }
            if (self.selectedNum == 6) {
                max = 1;
            }
            if (self.selectedNum == 7) {
                max = 1;
            }
            if (self.selectedNum == 8) {
                max = 2;
            }
            if (self.selectedNum == 9) {
                max = 3;
            }
            if (self.selectedNum == 10) {
                max = 4;
            }
            if (self.selectedNum == 11) {
                max = 4;
            }
            if (self.selectedNum == 12) {
                max = 9;
            }
            if (self.selectedNum == 13) {
                max = 9;
            }
            if (self.selectedNum == 14) {
                max = 17;
            }
            
            WeakSelf
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:max columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
            imagePickerVc.minImagesCount = max;
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingImage = YES;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.sortAscendingByModificationDate = YES;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                EditViewController *editVC = [[EditViewController alloc] initWith:weakSelf.selectedNum+1 withImageArray:photos withType:1];
                editVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:editVC animated:YES];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            
        }else{
            //[JFTools showTipOnHUD:@"登录失败"];
        }
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc]init];
    label.textColor = COLOR_HEX(0x333333, 1);
    label.font = FONT_REGULAR(14);
    label.frame = CGRectMake(10, 0, 100, 30);
    label.text = self.mobanArray[section];
    [headerView addSubview:label];
    
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}

@end
