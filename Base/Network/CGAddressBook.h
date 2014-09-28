//
//  CGAddressBook.h
//  Contact
//
//  Created by Justin on 14-5-5.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;
@import AddressBookUI;

@interface AddressBookItem : NSObject

@property (nonatomic, strong) NSString *sectionNumber;
@property (nonatomic, strong) NSString *recordID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *pinyin;


@property (nonatomic, strong) NSNumber *isClicked;
@end
@interface CGAddressBook : NSObject
-(NSArray *)getAllContact;
@end
