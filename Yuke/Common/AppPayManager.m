//
//  AppPayManager.m
//  Yuke
//
//  Created by yangyunfei on 2017/9/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "AppPayManager.h"

@implementation AppPayManager

+ (AppPayManager *)manager{
    
    static dispatch_once_t onceToken;
    static AppPayManager *client = nil;
    dispatch_once(&onceToken, ^{
        client = [[AppPayManager alloc]init];
    });
    return client;
}

- (void)startObserver {
    if (!self.isObserver) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        NSLog(@"开始监听 ------ 内购");
        self.isObserver = YES;
    }
}

- (void)stopObserver {
    if (self.isObserver) {
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
        NSLog(@"移除监听 ------ 内购");
        self.isObserver = NO;
    }
}

- (void)buyProductsWithId:(NSString *)productsId andQuantity:(NSInteger)quantity withMyProductsNum:(NSInteger) myProductsNum {
    self.productsId = productsId;
    self.quantity = quantity;
    self.myProductsNum = myProductsNum;
    
    if ([SKPaymentQueue canMakePayments]) {
        //允许程序内付费购买
        [self RequestProductData:@[self.productsId]];
    } else {
        //您的手机没有打开程序内付费购买
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"您的手机没有打开程序内付费购买" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alerView show];
    }
}
- (void)RequestProductData:(NSArray *)productsIdArr {
    //请求对应的产品信息
    NSSet *nsset = [NSSet setWithArray:productsIdArr];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}

#pragma SKProductsRequestDelegate代理方法
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    //收到产品反馈信息
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int) [myProduct count]);
    //打印信息
    for (SKProduct *product in myProduct) {
        //        NSLog(@"product info");
        //        NSLog(@"  基本描述: %@", [product description]);
        //        NSLog(@"  IAP的id: %@", product.productIdentifier);
        //        NSLog(@"  地区编码: %@", product.priceLocale.localeIdentifier);
        //        NSLog(@"  本地价格: %@", product.price);
        //        NSLog(@"  语言代码: %@", [product.priceLocale objectForKey:NSLocaleLanguageCode]);
        //        NSLog(@"  国家代码: %@", [product.priceLocale objectForKey:NSLocaleCountryCode]);
        //        NSLog(@"  货币代码: %@", [product.priceLocale objectForKey:NSLocaleCurrencyCode]);
        //        NSLog(@"  货币符号: %@", [product.priceLocale objectForKey:NSLocaleCurgegrencySymbol]);
        //        NSLog(@"  本地标题: %@", product.localizedTitle);
        //        NSLog(@"  本地描述: %@", product.localizedDescription);
        
        [self updateProductPriceWithId:product.productIdentifier andPrice:product.price];

    }
    //发送购买请求
    for (SKProduct *prct in myProduct) {
        if ([self.productsId isEqualToString:prct.productIdentifier]) {
            SKMutablePayment *payment = nil;
            payment = [SKMutablePayment paymentWithProduct:prct];
            payment.quantity = self.quantity;
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}
- (void)updateProductPriceWithId:(NSString *)productIdentifier andPrice:(NSDecimalNumber *)price{
    NSLog(@"productIdentifier == %@",productIdentifier);
    NSLog(@"price == %@",price);
}

#pragma SKPaymentTransactionObserver代理方法
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    //交易结果
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                //交易完成
                [self completeTransaction:transaction];
                //最好是把这句话加到上传自己后台服务器成功后的block里边执行
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
            }
                break;
            case SKPaymentTransactionStateFailed: {
                //交易失败
                [self failedTransaction:transaction];
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"交易失败" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                [alerView show];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                //已经购买过该商品
                [self restoreTransaction:transaction];
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"已经购买过该商品" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                [alerView show];
            }
                break;
            case SKPaymentTransactionStatePurchasing: {
                //商品添加进列表
                NSLog(@"商品添加进列表");
            }
                break;
            case SKPaymentTransactionStateDeferred: {
                NSLog(@"SKPayment Transaction State Deferred");
            }
                break;
            default:
                break;
        }
    }
}
- (void)failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled) { }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易恢复处理");
}

//购买成功后，将信息上传自己的服务器
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"-----completeTransaction--------");
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
        }
}
}

- (void)recordTransaction:(NSString *)product{
    NSLog(@"记录交易--product == %@",product);
    //上传到服务器
    
}

@end
