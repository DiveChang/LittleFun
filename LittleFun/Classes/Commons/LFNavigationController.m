//
//  LFNavigationController.m
//  LittleFun
//
//  Created by 张迪 on 16/4/27.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "LFNavigationController.h"

@interface LFNavigationController ()

@end

@implementation LFNavigationController

+ (void)initialize {
    [self setupTheme];
}

+ (void)setupTheme {
    //设置导航条背景
    UINavigationBar *navBar = [UINavigationBar appearance];
//    UIImage *image = [UIImage imageNamed:@"topbarbg_ios7"];
//    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    navBar.barStyle = UIBarStyleBlack;
    navBar.barTintColor = [UIColor redColor];
    navBar.translucent = YES;
    
    // 设置全局状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置导航条标题字体样式
    NSMutableDictionary *titleAtt = [NSMutableDictionary dictionary];
    
    titleAtt[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    titleAtt[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:titleAtt];
    
    // 返回按钮的样式 白色
    [navBar setTintColor:[UIColor whiteColor]];
    
    // 设置导航条item的样式
    NSMutableDictionary *itemAtt = [NSMutableDictionary dictionary];
    
    itemAtt[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    itemAtt[NSForegroundColorAttributeName] = [UIColor whiteColor];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:itemAtt forState:UIControlStateNormal];
}
@end
