//
//  PayKit.m
//  PayKitDemo
//
//  Created by ChenZhiWen on 10/13/14.
//  Copyright (c) 2014 ChenZhiWen. All rights reserved.
//

#import "PayKit.h"
#import "Wechat/WXApi.h"
#import "Alipay/AlixLibService.h"
#import "Alipay/AlixPayResult.h"
@interface PayKit()<WXApiDelegate>
@end
@implementation PayKit
+ (instancetype)shareInstance
{
    static PayKit *sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [[PayKit alloc] init];
    }
    return sharedInstance;
}

+ (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[PayKit shareInstance]];
}

+ (void)initializeWechat:(NSString *)appkey
{
    [WXApi registerApp:appkey];
}

+ (void)initializeAlipay:(NSString *)appkey
{
}

+ (void)payWithType:(PaymentType)type andRequest:(id)request handleResult:(void (^)(BOOL success, PaymentType rType, id result)) handler
{
    [[PayKit shareInstance]setHandler:handler];
    switch (type) {
        case PayKitAlipay:{
//            if (![request isKindOfClass:[NSString class]]) {
//                return;
            //            }
            [AlixLibService payOrder:@"http://baidu.com" AndScheme:@"qewqeq" seletor:@selector(alipayReslutHandler:) target:[PayKit shareInstance]];
        }
            break;
        case PayKitWeChat:{
//            if (![request isKindOfClass:[PayReq class]]) {
//                return;
//            }
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = @"123";
            request.prepayId= @"312";
            request.package = @"312";
            request.nonceStr= @"132";
            request.timeStamp= 123;
            request.sign= @"321312";
            [WXApi safeSendReq:request];
        }
            break;
        default:
            break;
    }
}
#pragma mark
#pragma mark -------------------- wechat --------------------
- (void)onResp:(BaseResp *)resp
{
    if(resp.errCode == WXSuccess){
        [PayKit shareInstance].handler(YES,PayKitWeChat,resp);
    }else{
        [PayKit shareInstance].handler(NO,PayKitWeChat,resp.errStr);
    }
}
#pragma mark
#pragma mark -------------------- alipay --------------------
- (void)alipayReslutHandler:(NSString*)result
{
    AlixPayResult *resultItem = [[AlixPayResult alloc]initWithString:result];
    if (resultItem.statusCode) {
        [PayKit shareInstance].handler(YES,PayKitAlipay,resultItem.statusMessage);
    }else{
        [PayKit shareInstance].handler(NO,PayKitAlipay,resultItem.statusMessage);
    }
}
@end
