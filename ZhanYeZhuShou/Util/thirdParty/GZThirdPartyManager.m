//
//  GZThirdPartyManager.m
//  Guozhao
//
//  Created by dash on 14/12/8.
//  Copyright (c) 2014年 Renren co. All rights reserved.
//

#import "GZThirdPartyManager.h"

#import "GZThirdPartyWeChatManager.h"

@implementation GZThirdPartyManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static GZThirdPartyManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)uploadAppKey
{
    [[GZThirdPartyWeChatManager sharedInstance] uploadWeChatAppKey];
}

- (BOOL)isAppInstallWithType:(EThirdPartyDestination)destination
{
    BOOL isInstall;
    switch (destination) {
        case EThirdPartyWeChatLogin:
            isInstall = [[GZThirdPartyWeChatManager sharedInstance] isWeChatInstall];
            break;
        default:
            break;
    }
    return isInstall;
}

- (BOOL)url:(NSURL *)url belongsTo:(NSString *)thirdPartyName
{
    NSString *urlstring = [url absoluteString];
    return [urlstring hasPrefix:thirdPartyName];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    if ([self url:url belongsTo:@"wx"]) {
        return [[GZThirdPartyWeChatManager sharedInstance] handleOpenURL:url];
    }
    return YES;
}

- (void)getUserInfoWithShareObject:(GZThirdPartyObject *)thirdPartyObject
                   completionBlock:(UserInfoCompletion)completionBlock
{
    switch (thirdPartyObject.shareDestionation) {
        case EThirdPartyWeChatLogin:
            [[GZThirdPartyWeChatManager sharedInstance] getWeChatUserInfoWithCompletionBlock:completionBlock];
            break;
        default:
            break;
    }
}

- (void)thirdPartyActionWithShareObject:(GZThirdPartyObject *)thirdPartyObject completionBlock:(ShareCompletion)completionBlock
{
    switch (thirdPartyObject.shareDestionation) {
        case EThirdPartyWeChatLogin:
        case EThirdPartyWeChatFriend:
        case EThirdPartyWeChatFriendCircle:
        {
            [[GZThirdPartyWeChatManager sharedInstance] thirdPartyActionWithShareObject:thirdPartyObject completionBlock:completionBlock];
            break;
        }
        default:
            break;
    }
}


- (BOOL)isThirdPartyInvalid:(EThirdPartyDestination)destination
{
    BOOL isInvalid;
    switch (destination) {
        default:
            break;
    }
    return isInvalid;
}

- (NSDictionary *)tokenForSynchronInitialize:(EThirdPartyDestination)destination
{
    NSDictionary *tokenDict = [NSDictionary dictionary];
    switch (destination) {
        default:
            break;
    }
    return tokenDict;
}

- (void)logoutWithShareObject:(GZThirdPartyObject *)thirdPartyObject
{
    switch (thirdPartyObject.shareDestionation) {
        case EThirdPartyWeixinLogout:
            [[GZThirdPartyWeChatManager sharedInstance] logout];
            break;
        case EThirdPartyAllLogout:
            {
                [[GZThirdPartyWeChatManager sharedInstance] logout];
            }
            break;
        default:
            break;
    }
}

@end
