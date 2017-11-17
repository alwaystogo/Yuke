//
//  PicShowViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "PicShowViewController.h"
#import "PicShowCell.h"

@interface PicShowViewController ()

@end

@implementation PicShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资料展示";
    [self setLeftBackNavItem];
    [self createUI];
    
    [self requestListData];
}

- (void)createUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = 220;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    //self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify = @"PicShowCell";
    
    PicShowCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PicShowCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.picImageView getImageWithUrl:[self.listArray[indexPath.row] objectForKeySafe:@"image"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: [self.listArray[indexPath.row] objectForKeySafe:@"image"]];
    
    // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了。
    if (!image) {
        image = [UIImage imageNamed:PlaceHolderPic];
    }
    
    //手动计算cell的高度
    CGFloat imgHeight = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
    return imgHeight;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.row);
    
}

- (void)requestListData{
    
    [JFTools showLoadingHUD];
    [kJFClient picShowList:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"piclist - %@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.listArray = responseObject;
            [self.tableView reloadData];
        }
        [JFTools HUDHide];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}
@end
