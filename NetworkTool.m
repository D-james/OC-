//
//  NetworkTool.m
//  OC中网络框架的封装
//
//  Created by 段盛武 on 16/4/10.
//  Copyright © 2016年 D.James. All rights reserved.
//

#import "NetworkTool.h"

//声明一个代理协议,但不实现这个方法,只是为了能够调用这个方法,当编译器发现在这个类中没有实现这个方法,会到父类中寻找有没有实现这个方法,调到父类中 AFN 的框架内部,已经实现了这个方法,那么就调到了 AFN 的私有方法,声明这个方法,只是为了在这个类中能够调用这个协议,
@protocol NetworkToolDelegate <NSObject>

@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

//创建一个私有扩展,并遵守上面的协议,写这个协议的目地是为了能够调用父类的私有方法
@interface NetworkTool ()<NetworkToolDelegate>

@end

@implementation NetworkTool

//新建一个网络单例
+(instancetype)shareNetworkTool{
    static NetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NetworkTool manager];
         instance.responseSerializer.acceptableContentTypes = [instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    });
    return instance;
}
//封装网络请求
-(void)request:(DSWHttpMethod)request URLString:(NSString*)URLString parameters:(id)parameters finish:(void(^)(id response,NSError *error)) finish{
    
    NSString *method = (request == GET)? @"GET": @"POST";
    
    [[self dataTaskWithHTTPMethod: method URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        finish(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finish(nil,error);
    }]resume];
    
    
}

@end
