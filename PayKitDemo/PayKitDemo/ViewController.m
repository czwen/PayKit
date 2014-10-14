//
//  ViewController.m
//  PayKitDemo
//
//  Created by ChenZhiWen on 10/12/14.
//  Copyright (c) 2014 ChenZhiWen. All rights reserved.
//

#import "ViewController.h"
#import "PayKit/PayKit.h"
@interface ViewController ()
- (IBAction)payWithWechat:(id)sender;
- (IBAction)payWithAlipay:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payWithWechat:(id)sender {
    [PayKit payWithType:PayKitWeChat andRequest:nil handleResult:^(BOOL success, PaymentType rType, id result) {
        NSLog(@"%@",result);
    }];
}
- (IBAction)payWithAlipay:(id)sender {
    [PayKit payWithType:PayKitAlipay andRequest:nil handleResult:^(BOOL success, PaymentType rType, id result) {
        NSLog(@"%@",result);
    }];
}
@end
