//
//  HRApiClient.h
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/22.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^ApiCompletion)(NSURLSessionDataTask *task, id responseDic, NSError* anError);
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
-(NSURLSessionDataTask *)getPath:(NSString *)aPath parameters:(NSMutableDictionary *)parameters completion:(ApiCompletion)aCompletion;

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



#pragma mark- test interface
/**
 *  @author Henry
 *
 *  获取首页梦想秀列表
 *
 *  @param completion completion description
 *
 *  @return return value description
 */
-(NSURLSessionDataTask *)getHomePageDreamWithCompletion:(ApiCompletion)completion;

/**
 *  @author Henry
 *
 *  获取首页banner列表
 *
 *  @param completion completion description
 *
 *  @return     
 */
-(NSURLSessionDataTask *)getHomePageBanner:(ApiCompletion)completion;

/**
 *  @author Henry
 *
 *  获取首页热门星榜
 *
 *  @param completion completion description
 *
 *  @return return value description
 */
-(NSURLSessionDataTask *)getHomePageHotStar:(ApiCompletion)completion;

/**
 *  @author Henry
 *
 *  首页collectionView数据
 *
 *  @param page         页数
 *  @param numberOfPage 每页个数
 *  @param completion   完成回调
 *
 *  @return 
 */
-(NSURLSessionDataTask *)getAllTalksByPage:(int)page
                                andPerPage:(int)numberOfPage
                                completion:(ApiCompletion)completion;
@end
