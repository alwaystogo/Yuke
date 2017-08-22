//
//  FontlibraryViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FontlibraryViewController.h"
#import "FontCollectionViewCell.h"
#import "RegistViewController.h"
#import "ForgetPasswordViewController.h"

@interface FontlibraryViewController ()

@end

@implementation FontlibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    
    [self requestFontListData];
}

- (void)createUI{
    
    //创建collectionView 362
     self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat bili = 200 / 355.0;
    _layout.itemSize = CGSizeMake(SCREEN_WIDTH - 20, (SCREEN_WIDTH - 20)*bili);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 20 - 10 - TABBAR_HEIGHT) collectionViewLayout:_layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    //注册单元格,相当于设置了闲置池
    UINib *nib = [UINib nibWithNibName:@"FontCollectionViewCell" bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"FontCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FontCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FontCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FontCollectionViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.cornerRadius = 5;
    cell.picImageView.layer.cornerRadius = 5;
    [cell.picImageView getImageWithUrl:[self.listArray[indexPath.row] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列

//    [LoginViewController checkLogin:^(BOOL result) {
//        
//        if (result) {
//            [JFTools showTipOnHUD:@"登录成功"];
//        }else{
//            [JFTools showTipOnHUD:@"登录失败"];
//        }
//    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)requestFontListData{
    
    [kJFClient fontList:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"fontList- %@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.listArray = responseObject;
            [self.collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}

@end
