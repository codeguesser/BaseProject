//
//  CGAddressBook.m
//  Contact
//
//  Created by Justin on 14-5-5.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "CGAddressBook.h"
#import <PinYin4Objc.h>
@implementation AddressBookItem

-(NSString *)sectionNumber{
    return _sectionNumber&&[_sectionNumber isKindOfClass:[NSString class]]?_sectionNumber:@"";
}
-(NSString *)recordID{
    return _recordID&&[_recordID isKindOfClass:[NSString class]]?_recordID:@"";
}
-(NSString *)name{
    return _name&&[_name isKindOfClass:[NSString class]]?_name:@"";
}
-(NSString *)email{
    return _email&&[_email isKindOfClass:[NSString class]]?_email:@"";
}
-(NSString *)tel{
    return _tel&&[_tel isKindOfClass:[NSString class]]?_tel:@"";
}
-(NSNumber *)isClicked{
    return _isClicked&&[_isClicked isKindOfClass:[NSNumber class]]?_isClicked:@(NO);
}

-(NSString *)pinyin{
    
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    return _name&&[_name isKindOfClass:[NSString class]]?[PinyinHelper toHanyuPinyinStringWithNSString:_name withHanyuPinyinOutputFormat:outputFormat withNSString:@""]:@"";
}
@end
@interface CGAddressBook (){
    NSMutableArray *_contacts;
}
@end
@implementation CGAddressBook
- (instancetype)init
{
    self = [super init];
    if (self) {
        //新建一个通讯录类
        _contacts = [NSMutableArray new];
        ABAddressBookRef addressBooks = nil;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        {
            addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
            
            //获取通讯录权限
            
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
            
        }
        else
        {
            addressBooks = ABAddressBookCreate();
        }
        
        //获取通讯录中的所有人
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
        //通讯录中人数
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
        
        //循环，获取每个人的个人信息
        for (NSInteger i = 0; i < nPeople; i++)
        {
            //新建一个addressBook model类
            AddressBookItem *addressBook = [[AddressBookItem alloc] init];
            //获取个人
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            //获取个人名字
            CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            CFStringRef abFullName = ABRecordCopyCompositeName(person);
            NSString *nameString = (__bridge NSString *)abName;
            NSString *lastNameString = (__bridge NSString *)abLastName;
            
            if ((__bridge id)abFullName != nil) {
                nameString = (__bridge NSString *)abFullName;
            } else {
                if ((__bridge id)abLastName != nil)
                {
                    nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
                }
            }
            addressBook.name = nameString;
            addressBook.recordID = [NSString stringWithFormat:@"%d",(int)ABRecordGetRecordID(person)];
            
            ABPropertyID multiProperties[] = {
                kABPersonPhoneProperty,
                kABPersonEmailProperty
            };
            NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
            for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
                ABPropertyID property = multiProperties[j];
                ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
                NSInteger valuesCount = 0;
                if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
                
                if (valuesCount == 0) {
                    CFRelease(valuesRef);
                    continue;
                }
                //获取电话号码和email
                for (NSInteger k = 0; k < valuesCount; k++) {
                    CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                    switch (j) {
                        case 0: {// Phone number
                            NSString *originalString = (__bridge NSString*)value;
                            
                            // Intermediate
                            NSMutableString *numberString = [[NSMutableString alloc] init];
                            NSString *tempStr;
                            NSScanner *scanner = [NSScanner scannerWithString:originalString];
                            NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                            
                            while (![scanner isAtEnd]) {
                                // Throw away characters before the first number.
                                [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
                                
                                // Collect numbers.
                                [scanner scanCharactersFromSet:numbers intoString:&tempStr];
                                [numberString appendString:tempStr];
                                tempStr = @"";
                            }
                            addressBook.tel = numberString;
                            break;
                        }
                        case 1: {// Email
                            addressBook.email = (__bridge NSString*)value;
                            break;
                        }
                    }
                    CFRelease(value);
                }
                CFRelease(valuesRef);
            }
            //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
            [_contacts addObject:addressBook];
            
            if (abName) CFRelease(abName);
            if (abLastName) CFRelease(abLastName);
            if (abFullName) CFRelease(abFullName);
        }
    }
    return self;
}
-(NSArray *)getAllContact{
    return _contacts;
}
@end
