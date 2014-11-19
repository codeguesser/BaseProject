//
//  SendViewController.m
//  Base
//
//  Created by rsaif on 14/11/17.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "SendViewController.h"


@interface SendViewController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    float _viewHeight;
    UIButton * _currentImageButton;
}
@end
@implementation SendViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    _textView.scrollEnabled = NO;
    _textView.delegate = self;
    _viewHeight = self.view.frame.size.height;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showkeyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyGroupBorderStyle:) name:UIKeyboardWillHideNotification object:nil];
    [[ViewStyle new] applyBorderStyle:_textView]; 
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - delegate for textview

-(void)textViewDidChange:(UITextView *)textView{
    _labelPlaceHolder.hidden = textView.text.length!=0;
    [_textView sizeToFit];
    if (_textView.frame.size.width<SCREEN_WIDTH) {
        CGRect frame = _textView.frame ;
        frame.size.width = SCREEN_WIDTH;
        _textView.frame = frame;
    }
    [_viewImages changeFrameByFollowedFrame:_textView.frame andOffsize:CGSizeMake(0, 10)];
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, _viewImages.frame.size.height+_viewImages.frame.origin.y+10)];
}
#pragma mark - keyboard action
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
#pragma mark - custom methods
-(IBAction)pickAPhoto:(UIButton *)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.editing = YES;
    _currentImageButton = sender;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - delegate for image picker view
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [_currentImageButton setImage:info[@"UIImagePickerControllerOriginalImage"] forState:0];
    [_currentImageButton setTitle:nil forState:0];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
