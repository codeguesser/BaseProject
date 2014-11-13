//
//  AppDelegate.m
//  contact
//
//  Created by wang shuguan on 13-11-27.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerImpl.h"
#import <SlideNavigationController.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.;
    [self setupViewControllers];
    [self customizeInterface];

    self.window.rootViewController = CreateViewController(@"PubuViewController");
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - Methods
-(void)dosomething{
    
}
- (void)setupViewControllers {
//    ViewControllerImpl *firstViewController = CreateViewController(@"HomeViewController");
//    firstViewController.title = @"找我家";
//    firstViewController.tabBarItem.image = [UIImage imageNamed:@"img_btn_findmyhome"];
//    UINavigationController *firstNavigationController = [[UINavigationController alloc]
//                                                         initWithRootViewController:firstViewController];
//    [firstNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"color_orange_zhuangshi"] forBarMetrics:UIBarMetricsDefault];
//    [firstNavigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
//    
//    
//    ViewControllerImpl *secondViewController = CreateViewController(@"EffectViewController");
//    secondViewController.title = @"效果图";
//    secondViewController.tabBarItem.image = [UIImage imageNamed:@"img_btn_picture"];
//    UINavigationController *secondNavigationController = [[UINavigationController alloc]
//                                                          initWithRootViewController:secondViewController];
//    [secondNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"color_orange_zhuangshi"] forBarMetrics:UIBarMetricsDefault];
//    [secondNavigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
//    
//    
//    
//    ViewControllerImpl *thirdViewController = CreateViewController(@"HomeViewController");
//    thirdViewController.title = @"学装修";
//    thirdViewController.tabBarItem.image = [UIImage imageNamed:@"img_btn_study"];
//    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
//                                                         initWithRootViewController:thirdViewController];
//    [thirdNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"color_orange_zhuangshi"] forBarMetrics:UIBarMetricsDefault];
//    [thirdNavigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
//    
//    
//    ViewControllerImpl *fourthViewController = CreateViewController(@"HomeViewController");
//    fourthViewController.title = @"我的";
//    fourthViewController.tabBarItem.image = [UIImage imageNamed:@"img_btn_mine"];
//    UINavigationController *fourthNavigationController = [[UINavigationController alloc]
//                                                          initWithRootViewController:fourthViewController];
//    [fourthNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"color_orange_zhuangshi"] forBarMetrics:UIBarMetricsDefault];
//    [fourthNavigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
//    
//    
//    
//    UITabBarController *controller = [[UITabBarController alloc]init];
//    controller.tabBar.barStyle = UIBarStyleBlack;
//    controller.tabBar.tintColor = [UIColor colorWithRed:236/255.0f green:110/255.0f blue:10/255.0f alpha:1];
//    controller.tabBar.backgroundImage = [UIImage imageNamed:@"color_black"];
//    controller.viewControllers = @[firstNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController];
//    
//    
//    SlideNavigationController *nav = [[SlideNavigationController alloc] initWithRootViewController:controller];
//    
//    nav.navigationBar.hidden = YES;
//    
//    [SlideNavigationController sharedInstance].rightMenu = CreateViewControllerWithNav(@"HomeCityViewController");
//    [(UINavigationController *)[SlideNavigationController sharedInstance].rightMenu setNavigationBarHidden:YES];
//    self.window.rootViewController = nav;
    
}

- (void)customizeInterface {
    
}
@end
