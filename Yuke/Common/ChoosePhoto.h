//
//  ChoosePhoto.h
//  LinkFinance
//
//  Created by yangyunfei on 16/6/20.
//  Copyright © 2016年 JF. All rights reserved.
//

typedef void(^ChooseBlock) (UIImage *image);

@interface ChoosePhoto : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *takePhotoImage;

@property (strong, nonatomic) IBOutlet UIImageView *albumImage;

@property(nonatomic,strong)UIButton *cancleBtn;

@property(nonatomic,strong)UIImage *selectImage;

@property(nonatomic,strong)ChooseBlock chooseBlock;

//拍照
- (void)takePhotoAction;
//从相册选择
- (void)chooseFromAlbumAction;

@end
