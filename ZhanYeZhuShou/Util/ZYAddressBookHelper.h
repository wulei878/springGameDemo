//
//  HYBContactHelper.h
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/4.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>


typedef void (^ZYAddressBookHelperFailBlock)(BOOL failed);

@interface ZYAddressBookHelper : NSObject
+ (instancetype)sharedInstance;
-(BOOL)canAccessAdressBook;
-(void)accessAddressBook:(void (^)(void))authorized denied:(void (^)(void))denied;
- (NSArray *)startReadAdressBook;
@end

@interface ZYMContactor : NSObject
//序列号 服务器需要
@property (nonatomic,strong) NSNumber *serialNumber;
//联系人Id
@property (nonatomic,strong) NSNumber *recordId;
//联系人名字
@property (nonatomic,strong) NSString *firstName;
//联系人姓氏
@property (nonatomic,strong) NSString *lastName;
//联系人全名
@property (nonatomic,strong) NSString *fullName;
//电话号码
@property (nonatomic,strong) NSMutableArray *phoneNumbers;
//邮箱
@property (nonatomic,strong) NSMutableArray *emailAddresses;
//IM
@property (nonatomic,strong) NSMutableArray *IMInfos;
//生日
@property (nonatomic,strong) NSDate *birthday;
// 头像地址
@property (nonatomic, copy) NSString *headURL;
//头像
@property (nonatomic,strong) UIImage *headImage;
//个人主页地址
@property (nonatomic,strong) NSString *profilePageURL;
// 学校
@property (nonatomic, copy) NSString *hometown;
// 家乡
@property (nonatomic, copy) NSString *college;
// QQ
@property (nonatomic, copy) NSString *qq;

@property(nonatomic,copy) NSString *companyName;
@property(nonatomic,copy) NSString *job;
- (id)initWithABRecord:(ABRecordRef)person;

@end
