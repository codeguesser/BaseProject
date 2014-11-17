//
//  SendViewController.h
//  Base
//
//  Created by rsaif on 14/11/17.
//  Copyright (c) 2014年 wang shuguan. All rights reserved.
//

#import "ViewControllerImpl.h"

@interface SendViewController : ViewControllerImpl<UITextViewDelegate>{
    
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UITextView *_textView;
}

@end
