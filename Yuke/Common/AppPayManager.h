//
//  AppPayManager.h
//  Yuke
//
//  Created by yangyunfei on 2017/9/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface AppPayManager : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property(nonatomic,assign)BOOL isObserver;
@property(nonatomic,copy)NSString *productsId;//产品ID
@property(nonatomic,assign)NSInteger quantity;//购买个数
@property(nonatomic,assign)NSInteger myProductsNum;//自己和后台开发约定的产品类型

+ (AppPayManager *)manager;

- (void)buyProductsWithId:(NSString *)productsId andQuantity:(NSInteger)quantity withMyProductsNum:(NSInteger) myProductsNum;

//放到AppDelegate中
//开始监听订单
- (void)startObserver;
//移除监听
- (void)stopObserver;

@end
