//
//  JFiPhoneClient+UploadFile.m
//  LinkFinance
//
//  Created by ZhengYi on 16/11/8.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFiPhoneClient+UploadFile.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
@implementation JFiPhoneClient (UploadFile)

//上传图片
- (NSURLSessionDataTask *)uploadPictureWithMethod:(NSString *)method
                                            param:(NSDictionary *)data
                                          picData:(UIImage *)pic
                                        paramName:(NSString *)paramName
                                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                          failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure{
    
    NSParameterAssert(method != nil);
    
    NSMutableDictionary *temp = [self configCommonParams:data];
    
    NSURLSessionDataTask *task =
    [self.manager POST:method parameters:temp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //图片为空，直接返回
        if (pic == nil) {
            
            return ;
        }
        NSData *picData = UIImageJPEGRepresentation(pic, 0.8);
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png",paramName];
        
        [formData appendPartWithFileData:picData name:paramName fileName:fileName mimeType:@"image/jpeg/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id result = [self parseResponse:responseObject];
        
        NSLog(@"---- PARAMETER %@",temp);
        
        NSLog(@"---- RESPONSE OBJECT : %@",result);
        
        if ([result isKindOfClass:[NSError class]]) {
            
            failure(task, (NSError *)result);
            
        } else{
            success(task ,result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"REQUEST ERROR CODE : %zd",error.code);
        
        error = [self parseFailureError:error];
        
        failure(task, error);
    }];
    return task;
}

//批量上传图片
- (NSURLSessionDataTask *)uploadPicturesWithMethod:(NSString *)method
                                             param:(NSDictionary *)data
                                          picArray:(NSArray *)picArray
                                              name:(NSString *)name
                                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                           failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure{
    
    NSParameterAssert(method != nil);
    
    NSMutableDictionary *temp = [self configCommonParams:data];
    
    NSURLSessionDataTask *task =
    [self.manager POST:method parameters:temp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //图片数组为空，或者无内容，直接返回
        if (picArray == nil || picArray.count == 0 ) {
            return;
        }
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",name];
        
        for (NSInteger index = 0; index < picArray.count; index++) {
            
            @autoreleasepool {
                
                id imgData = [picArray objectAtIndex:index];
                
                NSAssert([imgData isKindOfClass:[UIImage class]], @"The element in imgArray is not a UIImage object!");
                
                UIImage *image = (UIImage *)imgData;
                
                NSData *picData = UIImageJPEGRepresentation(image, 0.8);
                
                [formData appendPartWithFileData:picData name:name fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id result = [self parseResponse:responseObject];
        
        NSLog(@"---- PARAMETER %@",temp);
        
        NSLog(@"---- RESPONSE OBJECT : %@",result);
        
        if ([result isKindOfClass:[NSError class]]) {
            
            failure(task, (NSError *)result);
            
        } else{
            success(task ,result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"REQUEST ERROR CODE : %zd",error.code);
        
        error = [self parseFailureError:error];
        
        failure(task, error);
    }];
    return task;
}

- (NSURLSessionDataTask *)uploadVideoWithMethod:(NSString *)method
                                          param:(NSDictionary *)data
                                       videoUrl:(NSURL *)videoUrl
                                      paramName:(NSString *)paramName
                                        success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                        failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure{
    
    NSParameterAssert(method != nil);
    
    NSMutableDictionary *temp = [self configCommonParams:data];
    
    NSURLSessionDataTask *task =
    [self.manager POST:method parameters:temp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //
        if (videoUrl == nil) {
            
            return ;
        }
        NSURL *mp4 = [self convertToMp4:videoUrl];
        NSData *data = [NSData dataWithContentsOfURL:mp4];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4",paramName];
        
        [formData appendPartWithFileData:data name:paramName fileName:fileName mimeType:@"video/*"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id result = [self parseResponse:responseObject];
        
        NSLog(@"---- PARAMETER %@",temp);
        
        NSLog(@"---- RESPONSE OBJECT : %@",result);
        
        if ([result isKindOfClass:[NSError class]]) {
            
            failure(task, (NSError *)result);
            
        } else{
            success(task ,result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"REQUEST ERROR CODE : %zd",error.code);
        
        error = [self parseFailureError:error];
        
        failure(task, error);
    }];
    return task;
}

// 视频转换为MP4
- (NSURL *)convertToMp4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        NSString *mp4Path = [NSString stringWithFormat:@"%@/%d%d.mp4", [self dataPath], (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    return mp4Url;
}
- (NSString*)dataPath
{
    NSString *dataPath = [NSString stringWithFormat:@"%@/Library/appdata/chatbuffer", NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dataPath]){
        [fm createDirectoryAtPath:dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    return dataPath;
}
@end
