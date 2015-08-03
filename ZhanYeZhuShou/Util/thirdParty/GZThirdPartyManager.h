//
//  GZThirdPartyManager.h
//  Guozhao
//
//  Created by dash on 14/12/8.
//  Copyright (c) 2014年 Renren co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GZThirdPartyObject.h"

typedef void (^ShareCompletion)(NSInteger errorNumber, NSDictionary *userInfo);
typedef void (^UserInfoCompletion)(NSInteger errorNumber, NSDictionary *userInfo);

@protocol GZThirdPartyManagerProtocol <NSObject>

- (void)thirdPartyActionWithShareObject:(GZThirdPartyObject *)thirdPartyObject completionBlock:(ShareCompletion)completionBlock;

@end

@interface GZThirdPartyManager : NSObject<GZThirdPartyManagerProtocol>

+ (instancetype)sharedInstance;
- (void)uploadAppKey;
- (BOOL)handleOpenURL:(NSURL *)url;
- (BOOL)isAppInstallWithType:(EThirdPartyDestination)destination;
- (void)thirdPartyActionWithShareObject:(GZThirdPartyObject *)thirdPartyObject
                        completionBlock:(ShareCompletion)completionBlock;
- (void)getUserInfoWithShareObject:(GZThirdPartyObject *)thirdPartyObject
                   completionBlock:(UserInfoCompletion)completionBlock;
- (void)logoutWithShareObject:(GZThirdPartyObject *)thirdPartyObject;
- (BOOL)isThirdPartyInvalid:(EThirdPartyDestination)destination;
- (NSDictionary *)tokenForSynchronInitialize:(EThirdPartyDestination)destination;

@end