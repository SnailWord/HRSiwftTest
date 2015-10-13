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
#import <RNCryptor/RNEncryptor.h>

#define SERVER_URL @"http://dwintf.moko.io:9050"

#define MOKO_APP_KEY    @"iosappid"
#define MOKO_APP_SECRET @"ddeerrff"

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

-(void)buildAuthHeaderForRequest:(NSMutableURLRequest **)request appkey:(NSString *)appkey secret:(NSString *)secret udid:(NSString *)udid user:(NSString *)user
{
    NSMutableURLRequest *rq = *request;
    NSString *uri = rq.URL.relativePath;
    [rq setValue:[self buildAuthForUri:uri appkey:appkey secret:secret udid:udid user:user] forHTTPHeaderField:@"X-MOKO-AUTH"];
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

-(NSString *)buildAuthForUri:(NSString *)uri appkey:(NSString *)appkey secret:(NSString *)secret udid:(NSString *)udid user:(NSString *)user
{
    if (user==nil) {
        user=@"";
    }
    NSDictionary *authdic = @{@"uri":uri,@"udid":udid,@"user":user};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:authdic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSError *error;
    NSData *encryptedData = [RNEncryptor encryptData:jsonData withSettings:kRNCryptorAES256Settings password:secret error:&error];
    if (error) {
        NSLog(@"ERROR:%@",error);
    }
    
    NSString *safe_hmac = [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *headerValue = [appkey stringByAppendingFormat:@":%@",safe_hmac];
    return headerValue;
}

/*
 兼容iOS7/8的上传方法
 */
-(NSURLSessionDataTask *)postPathForUpload:(NSString *)fullUrl andParameters:(NSDictionary *)paremeters andData:(NSData *)data withNames:(NSString *)name completion:(ApiCompletion)aCompletion andProgress:(UploadProgress)progress{
    
    NSURLSessionDataTask *task = [NSURLSessionDataTask new];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = self.responseSerializer.acceptableContentTypes;
    
    AFHTTPRequestOperation *operation = [manager POST:fullUrl parameters:paremeters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
    
    //上传进度
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        if(progress){
            progress(totalBytesWritten,totalBytesExpectedToWrite);
        }
    }];
    [operation start];
    
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
-(NSURLSessionDataTask *)getPath:(NSString *)aPath parameters:(NSMutableDictionary *)parameters completion:(ApiCompletion)aCompletion{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.requestSerializer setValue:[self buildAuthForUri:[@"/" stringByAppendingString:aPath] appkey:MOKO_APP_KEY secret:MOKO_APP_SECRET udid:@"761D9908-B207-4183-8F5C-A8A615D6CF13" user:@"2599589"] forHTTPHeaderField:@"X-MOKO-AUTH"];
    
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
-(NSURLSessionDataTask *)postPath:(NSString *)aPath parameters:(NSMutableDictionary *)parameters completion:(ApiCompletion)aCompletion {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.requestSerializer setValue:[self buildAuthForUri:[@"/" stringByAppendingString:aPath] appkey:MOKO_APP_KEY secret:MOKO_APP_SECRET udid:@"761D9908-B207-4183-8F5C-A8A615D6CF13" user:@"1978383"] forHTTPHeaderField:@"X-MOKO-AUTH"];
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

-(NSURLSessionDataTask *)getHomePageDreamWithCompletion:(ApiCompletion)completion{
    NSString *path = @"funding/home/move";
    return [self getPath:path parameters:nil completion:completion];
}

-(NSURLSessionDataTask *)getHomePageBanner:(ApiCompletion)completion{
    NSString *path = @"main/homepaheadvert";
    return [self getPath:path parameters:nil completion:completion];
}

-(NSURLSessionDataTask *)getHomePageHotStar:(ApiCompletion)completion{
    NSString *path = @"ranking/girls/week/move";
    return [self getPath:path parameters:nil completion:completion];
}

-(NSURLSessionDataTask *)getAllTalksByPage:(int)page andPerPage:(int)numberOfPage completion:(ApiCompletion)completion{
    NSString *path = @"talk/move/refresh";
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(page) forKey:@"page"];
    [parameters setObject:@(numberOfPage) forKey:@"perpage"];
    
    return [self getPath:path parameters:parameters completion:completion];
}
@end
