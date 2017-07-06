//
//  ChoosePhoto.m
//  LinkFinance
//
//  Created by yangyunfei on 16/6/20.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "ChoosePhoto.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation ChoosePhoto

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR_HEX(0x000000, 0.6);
        UITapGestureRecognizer *tapBkView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBkViewAction)];
        [self addGestureRecognizer:tapBkView];

        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"ChoosePhoto" owner:self options:nil][0];
      
        view.backgroundColor = WHITECOLOR;
//      view.frame = CGRectMake(0, SCREEN_HEIGHT - 125 *BiLi_SCREENHEIGHT_NORMAL, SCREEN_WIDTH, 125*BiLi_SCREENHEIGHT_NORMAL);
        view.frame = CGRectMake(0, SCREEN_HEIGHT - 125, SCREEN_WIDTH, 125);

        UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takePhotoAction)];
        UITapGestureRecognizer *tapAlbum = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseFromAlbumAction)];
        [_takePhotoImage addGestureRecognizer:tapPhoto];
        [_albumImage addGestureRecognizer:tapAlbum];

        [self addSubview:view];
    }
    
    return self;
}

//拍照
-(void)takePhotoAction{
    
    NSLog(@"拍照");
    //隐藏父视图
    [super setHidden:YES];
    
    //拍照
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    
    picker.delegate=self;
    picker.allowsEditing=YES;
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [kCurNavController presentViewController:picker animated:YES completion:^{
        
        //判断是否有权限使用相机
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authStatus == AVAuthorizationStatusRestricted ||
            authStatus == AVAuthorizationStatusDenied) {
            [JFTools showAlertWithTitle:@"提示"
                                message:@"请在iPhone的“设置-隐私-相机”选项中，允许加法理财师访问您的相机"
                            cancelTitle:@"好"
                             otherTitle:nil
                             completion:nil];
        }

    }];

}
//从相册选择
-(void)chooseFromAlbumAction{
    
    [super setHidden:YES];
    
    NSLog(@"从相册选择");
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=YES;

    //设置导航栏背景颜色
    picker.navigationBar.barTintColor = COLOR_HEX(0x666666, 1);
    //设置字体颜色
    picker.navigationBar.tintColor = [UIColor whiteColor];
    
    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [kCurNavController presentViewController:picker animated:YES completion:^{
        
        //判断是否有权限使用相册
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusRestricted ||
            authStatus == ALAuthorizationStatusDenied) {
            [JFTools showAlertWithTitle:@"提示"
                                message:@"请在iPhone的“设置-隐私-照片”选项中，允许加法理财师访问您的相册"
                            cancelTitle:@"好"
                             otherTitle:nil
                             completion:nil];
        }

    }];
}

#pragma mark 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //获取选中的图片
    //UIImagePickerControllerEditedImage  获取裁剪后的图片
    //UIImagePickerControllerOriginalImage 获取原图
   _selectImage = [info valueForKey:UIImagePickerControllerEditedImage];
    
    //回调
    self.chooseBlock(_selectImage);
    
    //这里销毁模态视图，是picker自己销毁自己的
    [picker dismissViewControllerAnimated:YES completion:^{
        ;
    }];

    [self removeFromSuperview];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //点击取消后，需要销毁picker
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self removeFromSuperview];
}

- (IBAction)cancelChangeAction:(id)sender {
    NSLog(@"取消选择");

    [self removeFromSuperview];
}
-(void)tapBkViewAction{
 
    [self removeFromSuperview];
}
@end
