//
//  VieoMakerViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface VieoMakerViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)NSURL *videoUrl;
@property(nonatomic,strong)UIImageView *imageView;
@end
