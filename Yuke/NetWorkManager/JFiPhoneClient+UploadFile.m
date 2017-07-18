//
//  JFiPhoneClient+UploadFile.m
//  LinkFinance
//
//  Created by ZhengYi on 16/11/8.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFiPhoneClient+UploadFile.h"

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
        picData = [picData base64EncodedDataWithOptions:0];
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

@end
