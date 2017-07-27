//
//  MeiriZuXunViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/17.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "MeiriZuXunViewController.h"
#import "ZuXunCell.h"
#import "MenuCell.h"

@interface MeiriZuXunViewController ()

@end

@implementation MeiriZuXunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //电视剧 ID为1  网络剧 ID为2  ...
    self.typeArray = @[@"电视剧",@"网络剧",@"电影",@"网络电影",@"广告",@"综艺",@"其他"];
    self.dateArray = @[@"开机时间",@"发布时间"];
    self.view.backgroundColor = COLOR_RGB(236, 236, 236, 1);
    self.title = @"每日组讯";
    [self setLeftBackNavItem];
    [self setupRightNavButton:ImageNamed(@"black_fanhui") target:self action:@selector(rightBtnAction)];
    [self createUI];

    [self requestZuxunListWithType:self.selectType withDate:self.selectDate];
    
}

- (void)createUI{
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];

    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.typeBtn setTitle:@"类型" forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    self.typeBtn.titleLabel.font = FONT_REGULAR(15);
    [self.typeBtn addTarget:self action:@selector(typeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.topView.mas_left).offset(70 * BiLi_SCREENWIDTH_NORMAL);
        make.top.mas_equalTo(self.topView.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    self.dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dateBtn setTitle:@"时间" forState:UIControlStateNormal];
    [self.dateBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    self.dateBtn.titleLabel.font = FONT_REGULAR(15);
    [self.dateBtn addTarget:self action:@selector(dateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dateBtn];
    [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.topView.mas_right).offset(-70 * BiLi_SCREENWIDTH_NORMAL);
        make.top.mas_equalTo(self.topView.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.width, SCREEN_HEIGHT - CGRectGetMaxY(self.topView.frame)) style:UITableViewStyleGrouped];
    self.tableView.tag = 3000;
    self.tableView.backgroundColor = COLOR_RGB(236, 236, 236, 1);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;
    self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

    self.typeTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.typeBtn.centerX - 55, CGRectGetMaxY(self.topView.frame), 110, self.typeArray.count *30) style:UITableViewStyleGrouped];
    self.typeTableView.tag = 3001;
    self.typeTableView.backgroundColor = COLOR_HEX(0xf5f5f5, 1);
    self.typeTableView.delegate = self;
    self.typeTableView.dataSource = self;
    self.typeTableView.rowHeight = 30;
    self.typeTableView.showsHorizontalScrollIndicator = NO;
    self.typeTableView.showsVerticalScrollIndicator = NO;
    self.typeTableView.scrollEnabled = NO;
    self.typeTableView.hidden = YES;
    [self.view addSubview:self.typeTableView];
    [self.typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.typeBtn.mas_centerX);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(110, self.typeArray.count * 30));
    }];
    
    self.dateTableView = [[UITableView alloc] init];
    self.dateTableView.tag = 3002;
    self.dateTableView.backgroundColor = COLOR_HEX(0xf5f5f5, 1);
    self.dateTableView.delegate = self;
    self.dateTableView.dataSource = self;
    self.dateTableView.rowHeight = 30;
    self.dateTableView.showsHorizontalScrollIndicator = NO;
    self.dateTableView.showsVerticalScrollIndicator = NO;
    self.dateTableView.scrollEnabled = NO;
    self.dateTableView.hidden = YES;
    [self.view addSubview:self.dateTableView];
    [self.dateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.dateBtn.mas_centerX);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(110, self.dateArray.count * 30));
    }];

    
}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag == 3000) {
        return self.listArray.count;
    }else if (tableView.tag == 3001){
        return 1;
    }else if (tableView.tag == 3002){
        return 1;
    }
    return 1;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 3000) {
        return 1;
    }else if (tableView.tag == 3001){
        return self.typeArray.count;
    }else if (tableView.tag == 3002){
        return self.dateArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 3000) {
        
        static NSString *indentify = @"ZuXunCell";
        
        ZuXunCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZuXunCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.picImageView getImageWithUrl:[self.listArray[indexPath.section] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
        cell.smallImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
        cell.titleLabel.text = [self.listArray[indexPath.section] objectForKeySafe:@"title"];
        NSString *dateStr = [self.listArray[indexPath.section] objectForKeySafe:@"startime"];
        dateStr = [NSString stringWithFormat:@"%@年%@月%@日",[dateStr substringWithRange:NSMakeRange(0, 4)],[dateStr substringWithRange:NSMakeRange(5, 2)],[dateStr substringWithRange:NSMakeRange(8, 2)]];
        ;
        cell.dateLabel.text = dateStr;
        NSString *strId = [self.listArray[indexPath.section] objectForKeySafe:@"cate_id"];
        NSInteger typeId = [strId integerValue] - 1;
        [cell.typeBtn setTitle:self.typeArray[typeId] forState:UIControlStateNormal];
        
        return cell;
    }else if (tableView.tag == 3001){
        static NSString *indentify = @"MenuCell";
        
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.menuLabel.text = self.typeArray[indexPath.row];
        
        return cell;

    }else if (tableView.tag == 3002){
        static NSString *indentify = @"MenuCell";
        
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.menuLabel.text = self.dateArray[indexPath.row];
        
        return cell;

    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.row);
    
    if (tableView.tag == 3000) {
       ;
    }else if (tableView.tag == 3001){
        self.typeTableView.hidden = !self.typeTableView.hidden;
        MenuCell *oldCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectType inSection:0]];
        MenuCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        oldCell.menuLabel.textColor = COLOR_HEX(0x333333, 1);
        oldCell.backgroundColor = COLOR_HEX(0xf5f5f5, 1);
        newCell.menuLabel.textColor = COLOR_HEX(0xffffff, 1);
        newCell.backgroundColor = COLOR_HEX(0xffa632, 1);
        self.selectType = indexPath.row;
        
        [self requestZuxunListWithType:self.selectType + 1 withDate:self.selectDate];
    }else if (tableView.tag == 3002){
        self.dateTableView.hidden = !self.dateTableView.hidden;
        MenuCell *oldCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectDate inSection:0]];
        MenuCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        oldCell.menuLabel.textColor = COLOR_HEX(0x333333, 1);
        oldCell.backgroundColor = COLOR_HEX(0xf5f5f5, 1);
        newCell.menuLabel.textColor = COLOR_HEX(0xffffff, 1);
        newCell.backgroundColor = COLOR_HEX(0xffa632, 1);
        self.selectDate = indexPath.row;
        
        [self requestZuxunListWithType:self.selectType withDate:self.selectDate + 1];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 3000) {
        return 10.0f;;
    }else if (tableView.tag == 3001){
        return 0.1f;
    }else if (tableView.tag == 3002){
        return 0.1f;
    }

    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.typeTableView.hidden = YES;
    self.dateTableView.hidden = YES;
}


- (void)rightBtnAction{
    
}
- (void)typeBtnAction{
    
    self.typeTableView.hidden = !self.typeTableView.hidden;
    self.dateTableView.hidden = YES;
}
- (void)dateBtnAction{
    
    self.dateTableView.hidden = !self.dateTableView.hidden;
    self.typeTableView.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.typeTableView.hidden = YES;
    self.dateTableView.hidden = YES;
}

- (void)requestZuxunListWithType:(NSInteger)type withDate:(NSInteger)date{
    
    NSDictionary *dic = @{@"cate_id":[NSString stringWithFormat:@"%ld",type],@"time":[NSString stringWithFormat:@"%ld",date]};
    [JFTools showLoadingHUD];
    [kJFClient zuXunList:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"zuxunlist- %@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.listArray = responseObject;
        }else{
            
            self.listArray = [[NSArray alloc] init];
        }
       
        [self.tableView reloadData];
        [JFTools HUDHide];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}
@end
