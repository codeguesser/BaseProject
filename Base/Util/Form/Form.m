//
//  Form.m
//  WTD
//
//  Created by Wangshuguan-mac on 13-7-5.
//  Copyright (c) 2013年 ling. All rights reserved.
//

#import "Form.h"

@implementation Form
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)check{
    if (_views.count == _checks.count) {
        int i = 0;
        for (UIView *f1 in _views) {
            for (NSString *s in [[_checks objectAtIndex:i]componentsSeparatedByString:@","]) {
                
                NSString *strOfCurrentValue ;
                if([f1 isKindOfClass:[UITextField class]]){
                    strOfCurrentValue = ((UITextField *)f1).text;
                }else if ([f1 isKindOfClass:[UIButton class]]){
                    strOfCurrentValue = ((UIButton *)f1).currentTitle;
                }else if ([f1 isKindOfClass:[UILabel class]]){
                    strOfCurrentValue = ((UILabel *)f1).text;
                }else if ([f1 isKindOfClass:[UITextView class]]){
                    strOfCurrentValue = ((UITextView *)f1).text;
                }
                
                //处理数据
                if([s isEqualToString:@"null"]){
                    if((strOfCurrentValue&&[strOfCurrentValue isEqualToString:@""])||(!strOfCurrentValue)){
                        _error = @"确保所有内容不为空";
                        _errorIndex = @(i);
                        return;
                    }
                }else if([s isEqualToString:@"money"]){
                    if(strOfCurrentValue){
                        if(![self isPureMoney:strOfCurrentValue]){
                            _error = @"请输入正确的钱数";
                            _errorIndex = @(i);
                            return;
                        }else{
                            if (strOfCurrentValue.floatValue<=0) {
                                _error = @"请输入正数的钱";
                                _errorIndex = @(i);
                                return;
                            }
                        }
                    }
                }else if([s isEqualToString:@"email"]){
                    if(strOfCurrentValue){
                        if([strOfCurrentValue componentsSeparatedByString:@"@"].count<=1||[strOfCurrentValue componentsSeparatedByString:@"."].count<=1){
                            _error = @"邮件格式错误";
                            _errorIndex = @(i);
                            return;
                        }
                    }
                }else if([s isEqualToString:@"equal"]){
                    NSString *valueToCompare;
                    
                    if([[_otherViews objectAtIndex:i] isKindOfClass:[UITextField class]]){
                        valueToCompare = ((UITextField *)[_otherViews objectAtIndex:i]).text;
                    }else if ([[_otherViews objectAtIndex:i] isKindOfClass:[UIButton class]]){
                        valueToCompare = ((UIButton *)[_otherViews objectAtIndex:i]).currentTitle;
                    }else if ([[_otherViews objectAtIndex:i] isKindOfClass:[UILabel class]]){
                        valueToCompare = ((UILabel *)[_otherViews objectAtIndex:i]).text;
                    }else if ([[_otherViews objectAtIndex:i] isKindOfClass:[UITextView class]]){
                        valueToCompare = ((UITextView *)[_otherViews objectAtIndex:i]).text;
                    }
                    if(_otherViews.count>i){
                        if(!valueToCompare||![valueToCompare isEqualToString:strOfCurrentValue]){
                            _error = @"密码输入有误";
                            _errorIndex = @(i);
                            return;
                        }
                    }
                }else if([s isEqualToString:@"btEqualString"]){
                    NSString *valueToCompare;
                    
                    if([[_otherViews objectAtIndex:i] isKindOfClass:[NSString class]]){
                        valueToCompare = [_otherViews objectAtIndex:i];
                    }
                    if(_otherViews.count>i){
                        if(!valueToCompare||[valueToCompare isEqualToString:strOfCurrentValue]){
                            _error = @"确保所有内容不为空";
                            _errorIndex = @(i);
                            return;
                        }
                    }
                }else if ([s isEqualToString:@"tel"]){
                    if(strOfCurrentValue){
                        if(strOfCurrentValue.length!=11||![self isPureInt:strOfCurrentValue]){
                            _error = @"请输入正确的手机号码";
                            _errorIndex = @(i);
                            return;
                        }
                    }
                }
            }
            i++;
        }
    }
}

- (BOOL)isPureMoney:(NSString *)string{
    NSRange r;
    r = [string rangeOfString:@"^[0-9]+\.{0,1}[0-9]{0,}$" options:NSRegularExpressionSearch];
    if (r.location != NSNotFound&&r.length==string.length) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)isPureInt:(NSString *)string{
    NSRange r;
    NSString *regEx = [NSString stringWithFormat:@"^[0-9]{%lu}$",(unsigned long)string.length];
    r = [string rangeOfString:regEx options:NSRegularExpressionSearch];
    if (r.location != NSNotFound&&r.length==string.length) {
        return YES;
    } else {
        return NO;
    }
}
@end
