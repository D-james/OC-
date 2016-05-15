//
//  NetworkTool.h
//  OC中网络框架的封装
//
//  Created by 段盛武 on 16/4/10.
//  Copyright © 2016年 D.James. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSUInteger, DSWHttpMethod) {
    GET,
    POST,
};
@interface NetworkTool : AFHTTPSessionManager


+(instancetype)shareNetworkTool;

//对外暴露一个工具类方法
-(void)request:(DSWHttpMethod)request URLString:(NSString*)URLString parameters:(id)parameters finish:(void(^)(id response,NSError *error)) finish;

@end

