//
//  GZThirdPartyWeChatManager.h
//  Guozhao
//
//  Created by dash on 14/12/8.
//  Copyright (c) 2014年 Renren co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GZThirdPartyManager.h"

@interface GZThirdPartyWeChatManager : NSObject<GZThirdPartyManagerProtocol>

+ (instancetype)sharedInstance;

- (void)logout;
- (void)uploadWeChatAppKey;
- (BOOL)isWeChatInstall;
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)getWeChatUserInfoWithCompletionBlock:(UserInfoCompletion)completionBlock;

@end
