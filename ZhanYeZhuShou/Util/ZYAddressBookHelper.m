//
//  HYBContactHelper.m
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/4.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "ZYAddressBookHelper.h"

@implementation ZYAddressBookHelper

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ZYAddressBookHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)canAccessAdressBook
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_5_1
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0) {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        
        if (status == kABAuthorizationStatusNotDetermined) {
            CFErrorRef           error = NULL;
            __block BOOL         ifAccess;
            ABAddressBookRef     addressBookRef = ABAddressBookCreateWithOptions(nil, &error);
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    ifAccess = granted;
                }
                
                dispatch_semaphore_signal(semaphore);
            });
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            CFRelease(addressBookRef);
            return ifAccess;
        } else if (status == kABAuthorizationStatusDenied) {
            return NO;
        }
    }
#endif /* if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_5_1 */
    return YES;
}

- (void)accessAddressBook:(void (^)(void))authorized denied:(void (^)(void))denied
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_5_1
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0) {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        
        if (status == kABAuthorizationStatusNotDetermined) {
            CFErrorRef       error = NULL;
            ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, &error);
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    authorized();
                } else {
                    denied();
                }
            });
            CFRelease(addressBookRef);
        } else if ((status == kABAuthorizationStatusDenied) || (status == kABAuthorizationStatusRestricted)) {
            denied();
        } else {
            authorized();
        }
        
        return;
    }
#endif /* if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_5_1 */
    authorized();
}

- (NSArray *)startReadAdressBook
{
    ABAddressBookRef addressBookRef = nil;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    if (&ABAddressBookCreateWithOptions != NULL) {
        CFErrorRef errorRef = NULL;
        addressBookRef = ABAddressBookCreateWithOptions(nil, &errorRef);
        
        if (!addressBookRef) {
            if (errorRef) {
                CFRelease(errorRef);
            }
            
            return nil;
        }
    } else {
#endif
        addressBookRef = ABAddressBookCreate();
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    }
#endif
    //    ABAddressBookRef addressBookRef = ABAddressBookCreate();
    NSMutableArray *allPersons = [NSMutableArray array];
    
    if (addressBookRef == nil) {
        return nil;
    }
    
    if (0 == ABAddressBookGetPersonCount(addressBookRef)) {
        CFRelease(addressBookRef);
        return allPersons;
    }
    
    CFArrayRef personsArrayRef = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (int i = 0; i < ABAddressBookGetPersonCount(addressBookRef); i++) {
        ABRecordRef  personRef = CFArrayGetValueAtIndex(personsArrayRef, i);
        ZYMContactor *item = [[ZYMContactor alloc] initWithABRecord:personRef];
        item.serialNumber = [[NSNumber alloc] initWithInt:i];
        [allPersons addObject:item];
        
        if ([[NSThread currentThread] isCancelled]) {
            CFRelease(personsArrayRef);
            CFRelease(addressBookRef);
            return nil;
        }
    }
    
    CFRelease(personsArrayRef);
    CFRelease(addressBookRef);
    return allPersons;
}

@end

@implementation ZYMContactor
- (id)initWithABRecord:(ABRecordRef)person
{
    self = [self init];
    
    if (self) {
        self.recordId = [[NSNumber alloc] initWithUnsignedInt:ABRecordGetRecordID(person)];
        
        @try {
            self.firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        }
        @catch(NSException *exception) {
        }
        
        @finally {
        }
        @try {
            self.lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        }
        @catch(NSException *exception) {
        }
        
        @finally {
        }
        ABMultiValueRef values;
        self.phoneNumbers = [[NSMutableArray alloc] init];
        values = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        for (int i = 0; i < ABMultiValueGetCount(values); i++) {
            NSString *phoneNumber = nil;
            phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(values, i);
            
            if (nil != phoneNumber) {
                NSString *label = nil;
                label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(values, i);
                
                if (nil == label) {
                    label = @"phone_number";
                }
                
                NSMutableDictionary *pair = [[NSMutableDictionary alloc] init];
                [pair setObject:phoneNumber forKey:label];
                [self.phoneNumbers addObject:pair];
            }
        }
        
        CFRelease(values);
        
        // 获取email邮箱地址
        self.emailAddresses = [[NSMutableArray alloc] init];
        values = ABRecordCopyValue(person, kABPersonEmailProperty);
        
        for (int i = 0; i < ABMultiValueGetCount(values); i++) {
            NSString *emailAddress = nil;
            emailAddress = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(values, i);
            
            if (nil != emailAddress) {
                NSString *label = nil;
                label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(values, i);
                
                if (nil == label) {
                    label = @"email";
                }
                
                NSMutableDictionary *pair = [[NSMutableDictionary alloc] init];
                [pair setObject:emailAddress forKey:label];
                [self.emailAddresses addObject:pair];
            }
        }
        
        CFRelease(values);
        
        // 获取IM(即时通讯)信息
        _IMInfos = [[NSMutableArray alloc] init];
        values = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
        
        for (int i = 0; i < ABMultiValueGetCount(values); i++) {
            NSDictionary *imAccount = nil;
            imAccount = (__bridge_transfer NSDictionary *)ABMultiValueCopyValueAtIndex(values, i);
            
            if (nil != imAccount) {
                NSString *label = nil;
                label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(values, i);
                
                if (nil == label) {
                    label = @"IM";
                }
                
                NSMutableDictionary *pair = [[NSMutableDictionary alloc] init];
                [pair setObject:imAccount forKey:label];
                [self.IMInfos addObject:pair];
            }
        }
        
        CFRelease(values);
        
        // 获取联系人的出生年月
        self.birthday = (__bridge_transfer NSDate *)ABRecordCopyValue(person, kABPersonBirthdayProperty);
        
        /*
         *   if (ABPersonHasImageData(person)) {
         *    NSData* imageData = (__bridge_transfer NSData *)ABPersonCopyImageData(person);
         *    _headImage = [[UIImage alloc] initWithData:imageData];
         *    }else{
         *    _headImage = nil;
         *   }*/
    }
    
    return self;
}
@end
