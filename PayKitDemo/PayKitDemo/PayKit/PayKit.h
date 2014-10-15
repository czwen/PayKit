//
//  PayKit.h
//  PayKitDemo
//
//  Created by ChenZhiWen on 10/13/14.
//  Copyright (c) 2014 ChenZhiWen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  支付方式
 */
typedef enum{
    PayKitAlipay = 0,
    PayKitWeChat = 1,
}PaymentType;

typedef void (^HandleBlock)(BOOL success, PaymentType rType, id result);

/**
 *  封装客户端支付
 */
@interface PayKit : NSObject

@property (copy,nonatomic) HandleBlock handler;
+ (instancetype)shareInstance;
/**
 *  微信初始化
 *
 *  @param appkey appkey
 */
+ (void)initializeWechat:(NSString*)appkey;

/**
 *  支付宝初始化
 *
 *  @param appkey appkey
 */
+ (void)initializeAlipay:(NSString*)appkey;

/**
 *  用在AppDelegate中
 */
+ (BOOL)handleOpenURL:(NSURL *)url;

/**
 *  跳转到客户端进行支付
 *
 *  @param type    支付方式：微信，支付宝
 *  @param request 请求参数：微信为BaseReq，支付宝为特定的NSString
 */
+ (void)payWithType:(PaymentType)type
         andRequest:(id)request
       handleResult:(void (^)(BOOL success, PaymentType rType, id result)) handler;
@end
