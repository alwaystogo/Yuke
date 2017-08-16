//
//  JFiPhoneClient+UploadFile.h
//  LinkFinance
//
//  Created by ZhengYi on 16/11/8.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFiPhoneClient.h"

@interface JFiPhoneClient (UploadFile)

//上传图片
- (NSURLSessionDataTask *)uploadPictureWithMethod:(NSString *)method
                                            param:(NSDictionary *)data
                                          picData:(UIImage *)pic
                                        paramName:(NSString *)paramName
                                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                          failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure;

- (NSURLSessionDataTask *)uploadPicturesWithMethod:(NSString *)method
                                             param:(NSDictionary *)data
                                          picArray:(NSArray *)picArray
                                              name:(NSString *)name
                                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                           failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure;

//上传video
- (NSURLSessionDataTask *)uploadVideoWithMethod:(NSString *)method
                                            param:(NSDictionary *)data
                                          videoUrl:(NSURL *)videoUrl
                                        paramName:(NSString *)paramName
                                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                          failure:(void (^)(NSURLSessionDataTask * task, NSError * error)) failure;
@end
