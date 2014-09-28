//
//  ViewControllerImpl.m
//  BaseProject
//
//  Created by lingzerg on 13-8-19.
//  Copyright (c) 2013年 lingzerg. All rights reserved.
//

#import "ViewControllerImpl.h"


@interface ViewControllerImpl (){
    NSMutableArray *allRequest;
}
@end

@implementation ViewControllerImpl
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)Init{
    if(IS_IOS7_DEVICE)self.edgesForExtendedLayout = UIRectEdgeNone;
    allRequest = [NSMutableArray new];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self Init];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self Init];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self Init];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hideKeyBoard];
}
-(void)hideKeyBoard{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}


#pragma mark - custom methods
-(void)reloadView{
    
}
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(EXECUTE_BLOCK)block completionBlock:(COMPLETE_BLOCK)completion{
    
    [self showAnimated:animated title:title post:NO whileExecutingBlock:block completionBlock:completion];
    
}
- (void)showAnimated:(BOOL)animated title:(NSString *)title post:(BOOL)isPost whileExecutingBlock:(EXECUTE_BLOCK)block completionBlock:(COMPLETE_BLOCK)completion{
    
    MBProgressHUD *hud;
    if (animated) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = title;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (animated)hud.taskInProgress = YES;
        
        ASIHTTPRequest *request = [self createRequestWithPost:isPost];
        CGDataResult *result = block(request);
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (animated)[hud performSelector:NSSelectorFromString(@"cleanUp") onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
            if ([result.errorMsg rangeOfString:@"token" options:NSRegularExpressionSearch].location != NSNotFound){
                [self goToLogin];
            }else{
                completion(result.status.boolValue,result);
                if (result&&[result isKindOfClass:[CGDataResult class]]) {
                    NSString *msg = result.errorMsg;
                    if(!result.status.boolValue)[self.view makeToast:msg duration:.5f position:@"center"];
                }
            }
            [allRequest removeObject:request];
        });
    });
    
}
-(void)downloadDataWithExecutingBlock:(NSString *(^)(ASIHTTPRequest *))block completionBlock:(void (^)(BOOL b))completion{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"";
	hud.mode = MBProgressHUDModeDeterminate;
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL new]];
    NSString *urlStr = block(request);
    NSString *urlSuffix = [urlStr lastPathComponent];
    request.url = [NSURL URLWithString:urlStr];
    request.temporaryFileDownloadPath = [DOCUMENT_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.tmp",urlSuffix]];
    request.delegate = self;
    request.allowResumeForFileDownloads = YES;
    request.downloadDestinationPath = [DOCUMENT_DIR stringByAppendingPathComponent:urlStr];
    request.downloadProgressDelegate = hud;
    request.showAccurateProgress = YES;
    [request startAsynchronous];
    [request setCompletionBlock:^{
        [hud performSelector:NSSelectorFromString(@"cleanUp") onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    }];
}
-(void)uploadDataWithExecutingBlock:(NSString *(^)(ASIFormDataRequest *))block url:(NSString *)url  para:(NSDictionary *)dic delegate:(id)delegate completionBlock:(void (^)(BOOL b))completion{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"";
	hud.mode = MBProgressHUDModeDeterminate;
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.timeOutSeconds = 60;
    block(request);
//    request.url = [NSURL URLWithString:urlStr];
    request.delegate = self;
    for (NSString *s in dic.allKeys) {
        [request setPostValue:dic[s] forKey:s];
    }
    request.uploadProgressDelegate = hud;
    request.showAccurateProgress = delegate;
    [request startAsynchronous];
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        URLLog(@"%llu",size/total);
    }];
    
    [request setCompletionBlock:^{
        completion(YES);
        [hud performSelector:NSSelectorFromString(@"cleanUp") onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    }];
    [request setFailedBlock:^{
        
    }];
}

-(ASIHTTPRequest *)createRequestWithPost:(BOOL)isPost{
    ASIHTTPRequest *request;
    if(isPost)request = [[ASIFormDataRequest alloc]initWithURL:[NSURL new]];
    else request = [[ASIHTTPRequest alloc]initWithURL:[NSURL new]];
    [allRequest addObject:request];
    return request;
}
- (void)cancelAllLoading{
    for (ASIHTTPRequest *r in allRequest) {
        [r clearDelegatesAndCancel];
    }
}
-(void)goToLogin{
    //    [self.navigationController.tabBarController presentViewController:CreateViewController(@"LoginViewController") animated:YES completion:^{
    //    }];
}
-(IBAction)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end