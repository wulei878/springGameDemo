
//
//  GZThirdPartyWeChatManager.m
//  Guozhao
//
//  Created by dash on 14/12/8.
//  Copyright (c) 2014年 Renren co. All rights reserved.
//

#import "GZThirdPartyWeChatManager.h"
#import "WXApi.h"
//#import "RLUtility.h"

static NSString *kUMAppKey = @"54b8f24efd98c50d15000aa2";
static NSString *kWeChatAppSecretKey = @"02b1699422ff691735843a7853a0fc8f";
static NSString *kWeChatAppKey = @"wx82dac282b479ccbb";

@interface GZThirdPartyWeChatManager ()<WXApiDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, copy)NSString *userID;
@property (nonatomic, copy)NSString *token;
@property (nonatomic, copy)NSString *expireData;
@property (nonatomic, copy)NSString *refreshToken;
@property (nonatomic, strong)GZThirdPartyObject *thirdPartyObject;
@property (nonatomic, copy)ShareCompletion completionBlock;
@property (nonatomic, copy)UserInfoCompletion userInfoCompletion;
@property (nonatomic, assign)BOOL isRequestToken;

@end

@implementation GZThirdPartyWeChatManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static GZThirdPartyWeChatManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)logout
{
    self.token = nil;
    self.refreshToken = nil;
    self.expireData = nil;
    self.userID = nil;
}

#pragma mark - GZThirdPartyManagerProtocol
- (void)thirdPartyActionWithShareObject:(GZThirdPartyObject *)thirdPartyObject completionBlock:(ShareCompletion)completionBlock
{
    self.thirdPartyObject = thirdPartyObject;
    self.completionBlock = completionBlock;
    switch (thirdPartyObject.shareDestionation) {
        case EThirdPartyWeChatLogin:
            [self weChatAuth];
            break;
        case EThirdPartyWeChatFriend:
        case EThirdPartyWeChatFriendCircle:
        {
            [self shareToWeChat];
        }
            break;
        default:
            break;
    }
}

#pragma mark - private Method
- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)uploadWeChatAppKey
{
    [WXApi registerApp:kWeChatAppKey];
//    [UMSocialData setAppKey:kUMAppKey];
//    [UMSocialWechatHandler setWXAppId:kWeChatAppKey appSecret:kWeChatAppSecretKey url:@"www.renren.com"];
}

- (BOOL)isWeChatInstall
{
    return [WXApi isWXAppInstalled];
}

- (void)weChatAuth
{
    SendAuthReq *request = [[SendAuthReq alloc] init];
    request.scope = @"snsapi_userinfo";
    request.state = @"weixinAuth";
    [WXApi sendAuthReq:request viewController:nil delegate:self];
}

- (void)shareToWeChat
{
        SendMessageToWXReq *sendMessage = [[SendMessageToWXReq alloc] init];
        sendMessage.scene = self.thirdPartyObject.shareDestionation == EThirdPartyWeChatFriend ? WXSceneSession : WXSceneTimeline;
        if (self.thirdPartyObject.shareContentType == EShareContentTypeImageAndText) {
            sendMessage.bText = NO;
            WXWebpageObject *localWXWebpageObject = [WXWebpageObject object];
            localWXWebpageObject.webpageUrl = self.thirdPartyObject.linkURL;
            WXMediaMessage *localWXMediaMessage = [WXMediaMessage message];
            localWXMediaMessage.mediaObject = localWXWebpageObject;
            localWXMediaMessage.title = self.thirdPartyObject.title;
            localWXMediaMessage.description = self.thirdPartyObject.detailContent;
            if (self.thirdPartyObject.image) {
                CGFloat length = self.thirdPartyObject.image.size.width > self.thirdPartyObject.image.size.height ? self.thirdPartyObject.image.size.width : self.thirdPartyObject.image.size.height;
                if (length > 120) {
//                    CGFloat scaleRate = 120. / length;
//                    [localWXMediaMessage setThumbImage: [RLUtility scaleImage:self.thirdPartyObject.image toSize:CGSizeMake(self.thirdPartyObject.image.size.width * scaleRate, self.thirdPartyObject.image.size.height * scaleRate)]];
                }
                else {
                    [localWXMediaMessage setThumbImage:self.thirdPartyObject.image];
                }
            }
            sendMessage.message = localWXMediaMessage;
        } else if (self.thirdPartyObject.shareContentType == EShareContentTypeImage) {
            sendMessage.bText = NO;
            WXImageObject *localWXImageObject = [WXImageObject object];
            localWXImageObject.imageData = UIImageJPEGRepresentation(self.thirdPartyObject.image, (CGFloat)1.0);
            WXMediaMessage *localWXMediaMessage = [WXMediaMessage message];
            localWXMediaMessage.mediaObject = localWXImageObject;
            localWXMediaMessage.description = self.thirdPartyObject.detailContent;
            sendMessage.message = localWXMediaMessage;
        } else {
            sendMessage.bText = YES;
            sendMessage.text = self.thirdPartyObject.title;
        }
        [WXApi sendReq:sendMessage];
    //}
}

#pragma mark - getAccessToken-https
- (void)getAccessTokenWithCode:(NSString *)code
{
    self.isRequestToken = YES;
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWeChatAppKey,kWeChatAppSecretKey,code];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"GET";
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - getUserInfo - https
- (void)getWeChatUserInfoWithCompletionBlock:(UserInfoCompletion)completionBlock
{
    self.isRequestToken = NO;
    self.userInfoCompletion = completionBlock;
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",self.token, self.userID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"GET";
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - WXApiDelegate
- (void)onReq:(BaseReq *)req
{
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        if (authResp.errCode == 0) {
            [self getAccessTokenWithCode:authResp.code];
        } else {
            self.completionBlock(-1,@{@"errorMessage":@"授权失败"});
        }
    } else {
        if (resp.errCode == 0) {
            self.completionBlock(0,@{@"errorMessage":@"分享成功"});
        } else {
            self.completionBlock(-1,@{@"errorMessage":@"分享失败"});
        }
    }
}

#pragma mark - NSURLConnectionDelegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    self.completionBlock(-1, @{@"errorMessage" : @"授权失败"});
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.completionBlock(-1, @{@"errorMessage" : error.domain});
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (self.isRequestToken) {
        if (json) {
            self.userID = json[@"openid"];
            self.token = json[@"access_token"];
            self.refreshToken = json[@"refresh_token"];
            self.expireData = json[@"expires_in"];
            if (self.thirdPartyObject.shareDestionation == EThirdPartyWeChatLogin) {
                self.completionBlock(0, @{@"userID":self.userID, @"token":self.token});
            } else {
                [self shareToWeChat];
            }
        } else {
            self.completionBlock(-1, @{@"errorMessage": @"授权失败"});
        }
    } else {
        if (json) {
            NSString *nickName = json[@"nickname"];
            NSString *headImageURL = json[@"headimgurl"];
            NSString *gender = json[@"sex"];
            if (!headImageURL) {
                headImageURL = @"";
            }
            self.userInfoCompletion(0, @{@"headURL":headImageURL, @"nickName":nickName,@"gender":gender});
        } else {
            self.userInfoCompletion(-1, @{@"errorMessage": @"个人信息请求失败"});
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
    if (urlResponse.statusCode != 200 && self.isRequestToken) {
        self.completionBlock(-1, @{@"errorMessage" : @"授权失败"});
    } else if(urlResponse.statusCode != 200 && !self.isRequestToken) {
        self.userInfoCompletion(-1, @{@"errorMessage": @"个人信息请求失败"});
    }
}

@end
