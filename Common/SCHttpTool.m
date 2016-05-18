//
//  SCHttpTool.m
//  ShiHua
//
//  Created by 工作 on 14-7-29.
//  Copyright (c) 2014年 shuchuang. All rights reserved.
//

#import "SCHttpTool.h"
#ifdef SC_TP_AFNETWORKING
#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "Utils.h"

static SCSessionExpiredCallback sessionExipredCallback = nil;

NSSet *noTokenUrlsSet = nil;

@implementation SCHttpTool

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary*))success failure:(void (^)(NSError *))failure {
    [SCHttpTool requestWithURL:url method:@"GET" params:params constructingBodyWithBlock:nil success:success failure:failure withProgress:nil progressText:nil];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary*))success failure:(void (^)(NSError *))failure {
    [SCHttpTool requestWithURL:url method:@"POST" params:params constructingBodyWithBlock:nil success:success failure:failure withProgress:nil progressText:nil];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary*))success failure:(void (^)(NSError *))failure withProgress:(UIView *)view {
    [SCHttpTool requestWithURL:url method:@"GET" params:params constructingBodyWithBlock:nil success:success failure:failure withProgress:view progressText:nil];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary*))success failure:(void (^)(NSError *))failure withProgress:(UIView *)view {
    [SCHttpTool requestWithURL:url method:@"POST" params:params constructingBodyWithBlock:nil success:success failure:failure withProgress:view progressText:nil];
}

+ (void)requestWithURL:(NSString *)url
            method:(NSString*)method
            params:(NSDictionary *)params
            constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
            success:(void (^)(NSDictionary*))success
            failure:(void (^)(NSError *))failure
            withProgress:(UIView *)progressContainerView
            progressText:(NSString*)progressText
{
    BOOL isNoTokenUrl = [[NSSet setWithObject:url] isSubsetOfSet:noTokenUrlsSet?noTokenUrlsSet:[NSSet set]];
    if ([url hasPrefix:@"/"]) {
        url = [NSString stringWithFormat:BASEURL@"%@", url];
    }
    url = [[BDEnvironment env] replaceUrl: url];
    if (!params) {
        params = @{};
    }
    params = [params mutableCopy];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"ajax"];
//    [params setValue:[BDEnvironment env].companyKey forKey:@"companyKey"];
//    isNoTokenUrl ? :[params setValue:[Utils getLoginToken] forKey:@"token"];
    isNoTokenUrl || ![Utils isValidStr:[Utils getLoginToken]] ? :[params setValue:[Utils getLoginToken] forKey:@"access_token"];
    
    if (progressContainerView) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:progressContainerView animated:YES];
        if (progressText) {
            hud.labelText = progressText;
        }
    }

    void (^onFailure)(NSURLSessionTask *operation, NSError *error) = ^(NSURLSessionTask *operation, NSError *error) {
        // 请求失败后会调用
        if (progressContainerView) {
            [MBProgressHUD hideHUDForView:progressContainerView animated:YES];
        }
        if (failure) {
            failure(error);
        } else {
            NSString* errorStr = [error localizedDescription];
            //避免显示空的字符串
            if ([errorStr isEmpty]) {
                errorStr = NSLocalizedString(@"网络错误", nil);
            }
            [Utils makeShortToastAtCenter:errorStr];
        }
        
    };
    
    void (^onNetworkFailure)(NSURLSessionTask *operation, NSError *error) = ^(NSURLSessionTask *operation, NSError *error) {
        BOOL networkNotConnected = error && error.code == NSURLErrorNotConnectedToInternet;
        NSString* errorStr = networkNotConnected ? NSLocalizedString(@"暂无网络连接，请检查网络", nil) : NSLocalizedString(@"网络连接异常，请检查网络", nil);
        onFailure(operation, [Utils makeError:errorStr]);
    };

    void (^onSuccess)(NSURLSessionTask *operation, id responseObject) = ^(NSURLSessionTask *operation, id responseObject) {
        if (![responseObject isKindOfClass: [NSDictionary class]]) {
            NSString* error = [NSString stringWithFormat:NSLocalizedString(@"服务器错误：返回的不是json: %@", nil), responseObject];
            onFailure(operation, [Utils makeError: error]);
            return;
        }
        NSDictionary* dic = (NSDictionary*) responseObject;
        if (!([dic[@"status"] integerValue] == 0)) {
            if ([self isLoggedOut: dic]) {
                [self setLoggedOutStatus];
                if (sessionExipredCallback)
                    sessionExipredCallback();
                else
                    onFailure(operation, [Utils makeError: NSLocalizedString(@"登录已过期，请重新登录", nil)]);
                return;
            }
            NSString* error = [self getError: dic];
            onFailure(operation, [Utils makeError: error]);
            return;
        }
        // 请求成功后会调用
        if (progressContainerView) {
            [MBProgressHUD hideHUDForView:progressContainerView animated:YES];
        }
        if (success) {
            success(dic);
        }
    };
    [self doRequest:url method:method parameters:params constructingBodyWithBlock:block success:onSuccess failure:onNetworkFailure];
}

+ (NSURLSessionTask *)doRequest:(NSString *)URLString
                      method: (NSString*)method
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(NSURLSessionTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.responseSerializer = [AFJSONResponseSerializer serializer];
        mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    if ([method isEqualToString:@"GET"]) {
        [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
    }else if ([method isEqualToString:@"POST"]){
        [mgr POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:success failure:failure];
    }
    
    return nil;
}

+ (BOOL) isLoggedOut: (NSDictionary*)dic {
    return [dic[@"code"] integerValue] == 10001;
}

+ (void) setLoggedOutStatus {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [Utils setLogined: NO];
}

+ (NSString*) getError: (NSDictionary*)dic {
    for (NSString*key in [NSArray arrayWithObjects:@"error", @"info", nil]) {
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dicValue = (NSDictionary*)value;
            if ([dicValue count] == 0) {
                continue;
            }
            return [[dicValue allValues] componentsJoinedByString:@", "];
        } else if ([value isKindOfClass: [NSString class]]) {
            return (NSString*)value;
        }
    }
    return NSLocalizedString(@"未知的服务器错误", nil);
}

@end
#endif
