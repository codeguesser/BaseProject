//
//  SendViewController.m
//  Base
//
//  Created by rsaif on 14/11/17.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "SendViewController.h"


@interface SendViewController(){
    float _viewHeight;
}
@end
@implementation SendViewController
-(void)textViewDidChange:(UITextView *)textView{
    [_textView sizeToFit];
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, _textView.frame.size.height+100)];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [_textView sizeToFit];
    _textView.scrollEnabled = NO;
    _textView.delegate = self;
    _viewHeight = self.view.frame.size.height;
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, _textView.frame.size.height+100)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showkeyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidekeyboardAction:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)showkeyboardAction:(NSNotification*)notification{
    CGRect keyboardFrame = [self.view convertRect:[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
    CGRect frame = self.view.frame ;
    frame.size.height = frame.size.height-keyboardFrame.size.height;
    self.view.frame = frame;
}
- (void)hidekeyboardAction:(NSNotification*)notification{
    CGRect frame = self.view.frame ;
    frame.size.height = _viewHeight;
    self.view.frame = frame;
}

@end
