//
//  HRApiClient.m
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/22.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

#import "HRApiClient.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "AFHTTPRequestOperationManager.h"
#import <CommonCrypto/CommonDigest.h>

#define SERVER_URL @""

static HRApiClient    *_oneClient = nil;
@implementation HRApiClient

+(id)client{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _oneClient = [[HRApiClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        _oneClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _oneClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return _oneClient;
}

/*
 兼容iOS7/8的上传方法
 */
-(NSURLSessionDataTask *)postPathForUpload:(NSString *)fullUrl andParameters:(NSDictionary *)paremeters andData:(NSData *)data withNames:(NSString *)name completion:(ApiCompletion)aCompletion{
    
    NSURLSessionDataTask *task = [NSURLSessionDataTask new];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = self.responseSerializer.acceptableContentTypes;
    
    [manager POST:fullUrl parameters:paremeters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:name mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(aCompletion)
            aCompletion(task,responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSMutableDictionary    *errorDic   =   error.userInfo.mutableCopy;
        [errorDic setObject:errorDic.description forKey:@"msg"];
        NSError *anError = [NSError errorWithDomain:SERVER_URL code:-1 userInfo:errorDic];
        if(aCompletion)
            aCompletion(task,nil,anError);
    }];
    
    return task;
}

/**
 *  @author Henry
 *
 *  基本get方法
 *
 *  @param aPath       请求路径
 *  @param parameters  请求字典参数
 *  @param aCompletion 完成回调
 *
 *  @return
 */
-(NSURLSessionTask *)getPath:(NSString *)aPath parameters:(id)parameters completion:(ApiCompletion)aCompletion{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSArray *keys = [(NSMutableDictionary*)parameters allKeys];
    for(id key in keys){
        if([[parameters objectForKey:key] isKindOfClass:[NSString class]])
            [parameters setObject:[self getEncodeString:[parameters objectForKey:key]] forKey:key];
    }
    
    return [self GET:aPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if(aCompletion){
            if(responseObject)
                aCompletion(task, responseObject, nil);
            else{
                NSError *error = [[NSError alloc] initWithDomain:SERVER_URL code:-1 userInfo:responseObject];
                aCompletion(task,nil,error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"无网络连接");
        }
        
        if (aCompletion) {
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            [userInfo setObject:error.description forKey:@"msg"];
            
            NSError *error = [NSError errorWithDomain:SERVER_URL code:-1 userInfo:userInfo];
            
            aCompletion(task, nil, error);
        }
    }];
}

/*
 基本post方法
 */
-(NSURLSessionDataTask *)postPath:(NSString *)aPath parameters:(id)parameters completion:(ApiCompletion)aCompletion {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSArray *keys = [(NSMutableDictionary *)parameters allKeys];
    
    for(id key in keys){
        if([[parameters objectForKey:key] isKindOfClass:[NSString class]])
            [parameters setObject:[self getEncodeString:[parameters objectForKey:key]] forKey:key];
    }
    
    NSURLSessionDataTask *task = [self POST:aPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (aCompletion) {
            if(responseObject)
                aCompletion(task, responseObject, nil);
            else{
                NSError *error = [[NSError alloc] initWithDomain:SERVER_URL code:-1 userInfo:responseObject];
                aCompletion(task,nil,error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"无网络连接");
        }
        
        if (aCompletion) {
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            [userInfo setObject:error.description forKey:@"msg"];
            
            NSError *error = [NSError errorWithDomain:SERVER_URL code:-1 userInfo:userInfo];
            
            aCompletion(task, nil, error);
        }
    }];
    
    return task;
}

//对中文字符反编码处理
-(NSString *)getEncodeString:(NSString *)baseString{
    NSString *percentString = [baseString stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    NSString *andString = [percentString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    NSString *enterString = [andString stringByReplacingOccurrencesOfString:@"\n" withString:@"%5Cn"];
    return [enterString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
}

-(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}
@end
