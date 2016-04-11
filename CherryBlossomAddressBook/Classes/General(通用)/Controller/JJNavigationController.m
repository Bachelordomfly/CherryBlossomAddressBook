//
//  JJNavigationController.m
//  AddressBook2.0
//
//  Created by xujiajia on 15/11/3.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "JJNavigationController.h"

@interface JJNavigationController ()

@end

@implementation JJNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置NavigationBar的背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorBlue cornerRadius:0] forBarMetrics:UIBarMetricsDefault];
    
    if ([self.navigationBar respondsToSelector:@selector(setShadowImage:)])
    {
        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    }

    [self.navigationBar setTintColor:kColorBgMain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  拦截push然后过滤
 *
 *  @param viewController
 *  @param animated       
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 导航栏都是栈管理的，如果栈里面的内容大于0，说明push了，
    if (self.viewControllers.count > 0)
    {
        // 把tabbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


@end
