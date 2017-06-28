//
//  JFTools+ProgressHUD.m
//  LinkFinance
//
//  Created by ZhengYi on 16/12/5.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFTools+ProgressHUD.h"

static MBProgressHUD * HUD = nil;

static NSTimeInterval animationTime = 2.0;

@implementation JFTools (ProgressHUD)

+ (void)commonHUDStyle{
    HUD.contentColor = [UIColor whiteColor];
    //HUD.bezelView.color = [UIColor colorWithWhite:0.f alpha:1.f];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    HUD.alpha = 0.8;
    HUD.backgroundColor = CLEARCOLOR;
    HUD.removeFromSuperViewOnHide = YES;  //隐藏时移除
}

+ (void)MBProgressHUDWithText:(NSString *)text toView:(UIView *)view time:(NSInteger)time{
    if (HUD) {
        [HUD hideAnimated:YES];
    }
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [JFTools commonHUDStyle];
    //设置显示模式
    HUD.mode = MBProgressHUDModeCustomView;
    //显示的文字
    HUD.label.text = text;
    //多长时间后隐藏
    [HUD hideAnimated:YES afterDelay:time];
}

+ (void)showTipOnHUD:(NSString*)tip{
    

    [self MBProgressHUDWithText:tip toView:kAppDelegate.window time:animationTime];
}

+ (void)showHUDWithImage:(UIImage*)image Tip:(NSString*)tip{
    
    
    if (HUD) {
        [HUD hideAnimated:YES];
    }
    HUD = [MBProgressHUD showHUDAddedTo:kAppDelegate.window animated:YES];
    [JFTools commonHUDStyle];
    //设置显示模式
    HUD.mode = MBProgressHUDModeCustomView;
    //显示的文字
    HUD.label.text = tip;
    //多长时间后隐藏
    [HUD hideAnimated:YES afterDelay:animationTime];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imgView.image = image;
    HUD.customView = imgView;
}

+ (void)showImageOnHUD:(UIImage*)image{
    if (HUD) {
        [HUD hideAnimated:YES];
    }
    HUD = [MBProgressHUD showHUDAddedTo:kAppDelegate.window animated:YES];
    //设置显示模式
    HUD.mode = MBProgressHUDModeCustomView;
    //当只显示图片的时候，将hud本来的背景设置为透明
    HUD.bezelView.color = [UIColor clearColor];
    HUD.bezelView.layer.cornerRadius = 9.f;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    HUD.margin = 0;
    //隐藏时移除
    HUD.removeFromSuperViewOnHide = YES;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imgView.image = image;
    HUD.customView = imgView;
    //多长时间后隐藏
    [HUD hideAnimated:YES afterDelay:animationTime];
}

+ (void)showSuccessHUDWithTip:(NSString*)tip{
    [self showHUDWithImage:[UIImage imageNamed:@"bai-duigou"] Tip:tip];
}

+ (void)showSuccessHUDWithTip:(NSString *) tip dismissHandle:(void (^)(void)) dismissHandle{
    [self showHUDWithImage:[UIImage imageNamed:@"bai-duigou"] Tip:tip];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dismissHandle ? dismissHandle() : nil;
    });
    
}

+ (void)showFailureHUDWithTip:(NSString*)tip{
    [self showHUDWithImage:[UIImage imageNamed:@"bai-shibai"] Tip:tip];
}

+ (void)showFailureHUDWithTip:(NSString *) tip dismissHandle:(void (^)(void)) dismissHandle{
    
    [self showHUDWithImage:[UIImage imageNamed:@"bai-shibai"] Tip:tip];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dismissHandle ? dismissHandle() : nil;
    });
}

+ (void)showLoadingHUD{
    if (HUD) {
        [HUD hideAnimated:YES];
    }
    if (kCurNavController.topViewController.view) {
        HUD = [MBProgressHUD showHUDAddedTo:kCurNavController.topViewController.view animated:YES];
    }else{
        HUD = [MBProgressHUD showHUDAddedTo:kAppDelegate.window animated:YES];
    }
    [JFTools commonHUDStyle];
    //设置显示模式
    HUD.mode = MBProgressHUDModeIndeterminate;
}

+ (void)HUDHide{
    if (HUD) {
        [HUD hideAnimated:YES];
        HUD = nil;
    }
}

@end
