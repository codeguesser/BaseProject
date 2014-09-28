//
//  Language.h
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-14.
//  Copyright (c) 2013年 ling. All rights reserved.
//  语言模块，暂时还未使用

#ifndef WTD_Language_h
#define WTD_Language_h
#define lang_en 1
#define lang_ch 2
#define LanguageStr(key,lang) [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Language" ofType:@"plist"]]objectForKey:key] objectAtIndex:lang]


#endif
