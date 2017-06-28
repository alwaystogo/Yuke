//
//  UIImageView+SDCache.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/4/27.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "UIImageView+SDCache.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDCache)


-(void)getImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholder{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //        NSLog(@"加载图片失败:%@",error);
        
        if ([imageURL isEqual:[NSURL URLWithString:urlString]]) {
            
            if (!image) {
                self.image = placeholder;
            }else{
                if (cacheType == SDImageCacheTypeMemory) {
                    self.image = image;
                } else {
                    [UIView transitionWithView:self
                                      duration:.5
                                       options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                           self.image = image;
                                       }
                                    completion:nil];
                }
            }
        }
    }];
}

@end
