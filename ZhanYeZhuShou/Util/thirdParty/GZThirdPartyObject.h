//
//  GZThirdPartyObject.h
//  Guozhao
//
//  Created by dash on 14/12/8.
//  Copyright (c) 2014年 Renren co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EThirdPartyDestination)
{
    EThirdPartyRenrenLogin = 0,
    EThirdPartyRenrenShareToFeed = 1,
    EThirdPartyRenrenShareToFriend = 2,
    EThirdPartySynchronToRenren = 3,
    EThirdPartyWeChatLogin = 4,
    EThirdPartyWeChatFriendCircle = 5,
    EThirdPartyWeChatFriend = 6,
    EThirdPartyWeiboLogin = 7,
    EThirdPartyWeiboShare = 8,
    EThirdPartySynchronToWeibo = 9,
    EThirdPartyWeiboFriend = 10,
    EThirdPartyQQLogin = 11,
    EThirdPartyQQShareToFriend = 12,
    EThirdPartyQQShareToQQZone = 13,
    EThirdPartySynchronToQQZone = 14,
    EThirdPartyRenrenLogout = 15,
    EThirdPartyWeiboLogout = 16,
    EThirdPartyWeixinLogout = 17,
    EThirdPartyQQLogout = 18,
    EThirdPartyAllLogout = 19,
};

typedef NS_ENUM(NSInteger, EShareContentType)
{
    EShareContentTypeImageAndText = 0,
    EShareContentTypeText = 1,
    EShareContentTypeImage = 2,
};

@interface GZThirdPartyObject : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *feedID;
@property (nonatomic, strong) NSString *detailContent;
@property (nonatomic, strong) NSString *linkURL;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) EThirdPartyDestination shareDestionation;
@property (nonatomic, assign) EShareContentType shareContentType;
@property (nonatomic, assign) BOOL isShareUser;

@end
