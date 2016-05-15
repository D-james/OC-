//
//  ViewController.m
//  OC中网络框架的封装
//
//  Created by 段盛武 on 16/4/10.
//  Copyright © 2016年 D.James. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "NetworkTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
// 封装后
    NSString *urlString = @"http://www.weather.com.cn/data/sk/101010100.html";
    
    [[NetworkTool shareNetworkTool]request:GET URLString:urlString parameters:nil finish:^(id response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@",error);
            return ;
        }
        NSLog(@"%@",response);
    } ];
    
}

//没封装前
- (void)demo{
    
    AFHTTPSessionManager *boss = [AFHTTPSessionManager manager];
    
    NSString *urlString = @"http://www.weather.com.cn/data/sk/101010100.html";
    
    boss.responseSerializer.acceptableContentTypes = [boss.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [boss GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
