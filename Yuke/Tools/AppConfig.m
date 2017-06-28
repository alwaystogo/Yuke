//
//  AppConfig.m
//  LinkFinance
//
//  Created by ZhengYi on 16/6/20.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "AppConfig.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

#include <sys/stat.h>
#include <dirent.h>

@implementation AppConfig


+ (NSString *)cacheSize{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0];
    
    NSString *sdwebImageCachePath = [path stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    
    NSLog(@"SandBox ---- Cache Path : %@",path);
    
    NSString *egoCachePath = [[[path stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"EGOCache"] copy];
    
//    EGOCache *cache = [EGOCache globalCache];
//    
//    long long sizeB_EGOCache = 0;
//    
//    for (NSString *key in [cache allKeys]) {
//        
//        NSLog(@"egokey : %@",key);
//        long long tempSize = folderSizeAtDirectory([egoCachePath stringByAppendingPathComponent:key]);
//        
//        sizeB_EGOCache += tempSize;
//    }
    
    long long sizeB_EGOCache = folderSizeAtDirectory(egoCachePath);
    
    long long sizeB_SDWebImage = folderSizeAtDirectory(sdwebImageCachePath);
    
    long long sizeB = sizeB_SDWebImage +  sizeB_EGOCache;
    
    double sizeKB = sizeB / 1024.0;
    
    NSString *cacheSizeStr = nil;
    
    if (sizeKB > 1024.0) {
        
        double sizeM = sizeKB / 1024.0;
        
        cacheSizeStr = [NSString stringWithFormat:@"%0.2fM",sizeM];
    }
    else {
        
        cacheSizeStr = [NSString stringWithFormat:@"%0.2fK",sizeKB];
    }
    return cacheSizeStr;
}

+ (void)deleteAllCache{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0];
    
    NSString *sdwebImageCachePath = [path stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    NSString *egoCachePath = [[[path stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"EGOCache"] copy];
//    EGOCache *cache = [EGOCache globalCache];

//    for (NSString * key in [cache allKeys]) {
//        [cache removeCacheForKey:key];
//    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error;
    
    [fm removeItemAtPath:sdwebImageCachePath error:&error];
    if (![[NSFileManager defaultManager] fileExistsAtPath:sdwebImageCachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:sdwebImageCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    
    [fm removeItemAtPath:egoCachePath error:&error];
    if (![[NSFileManager defaultManager] fileExistsAtPath:egoCachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:egoCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

static long long fileSizeAtPath(NSString *filePath) {
    struct stat st;
    
    //获取文件的一些信息，返回0的话代表执行成功
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        
        //返回这个路径下文件的总大小
        return st.st_size;
    }
    return 0;
}


static long long folderSizeAtDirectory(NSString *folderPath) {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += fileSizeAtPath(fileAbsolutePath);
    }
    return folderSize;
}

@end
