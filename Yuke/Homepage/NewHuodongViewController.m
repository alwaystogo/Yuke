//
//  NewHuodongViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/14.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "NewHuodongViewController.h"
#import "NewHuodongCell.h"

@interface NewHuodongViewController ()

@end

@implementation NewHuodongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"最新活动";
    [self setLeftBackNavItem];
    [self createUI];
    
    [self requestListData];
}

- (void)createUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 220;
    //self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView closeEstimatedHeight];
    //[self.tableView closeContentInsetAdjustAutomaicCalculate];
    [self.view addSubview:self.tableView];

}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArray.count;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify = @"NewHuodongCell";
    
    NewHuodongCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewHuodongCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.picImageView getImageWithUrl:[self.listArray[indexPath.section] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    //cell.picImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.section);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,[self.listArray[indexPath.section] objectForKeySafe:@"info_url"]];
    BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
    webVc.title = @"活动详情";
    [kCurNavController pushViewController:webVc animated:YES];

}

- (void)requestListData{
    
    [JFTools showLoadingHUD];
    [kJFClient newHuodongList:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"huodongList - %@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.listArray = responseObject;
        }
        [self.tableView reloadData];
        [JFTools HUDHide];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}

@end
