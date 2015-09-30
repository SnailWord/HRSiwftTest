//
//  HRApiClient.h
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/22.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^ApiCompletion)(NSURLSessionDataTask *task, NSDictionary *responseDic, NSError* anError);
typedef void (^UploadProgress)(long long sent, long long expectSend);

@interface HRApiClient : AFHTTPSessionManager

+(id)client;

/**
 *  @author Henry
 *
 *  基本get方法
 *
 *  @param aPath       路径
 *  @param parameters  参数字典
 *  @param aCompletion 完成回调
 *
 *  @return
 */
-(NSURLSessionTask *)getPath:(NSString *)aPath parameters:(NSMutableDictionary *)parameters completion:(ApiCompletion)aCompletion;

/**
 *  @author Henry
 *
 *  基本post方法
 *
 *  @param aPath       路径
 *  @param parameters  字典参数
 *  @param aCompletion 完成回调
 *
 *  @return sessionTask
 */
-(NSURLSessionDataTask *)postPath:(NSString *)aPath parameters:(NSMutableDictionary *)parameters completion:(ApiCompletion)aCompletion;

@end
