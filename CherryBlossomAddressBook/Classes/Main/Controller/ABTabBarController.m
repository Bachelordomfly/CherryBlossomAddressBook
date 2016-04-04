//
//  ABTabBarController.m
//  AddressBook2.0
//
//  Created by mac-025 on 15/11/3.
//  Copyright © 2015年 mac-025. All rights reserved.
//

#import "ABTabBarController.h"
#import "PersonalCollectVC.h"
#import "RecentVC.h"
#import "AddressBookVC.h"
#import "DialVC.h"
#import "SHGuideView.h"
#import "LoginVC.h"

#define kVersionToShowGuideView @"1.0"

@interface ABTabBarController ()

@end

@implementation ABTabBarController

#pragma mark - init

- (instancetype)init
{
    if (self = [super init])
    {
        [self initChildViewControllers];
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNotifications];
    
    if ([self checkVersionNeedGuide])
    {
        [self initGuideView];
    }
    else
    {
        [self enterApp];
    }
}
- (void)dealloc
{
    [self removeNotifications];
}

#pragma mark - private method

/**
 *  是否需要引导页
 */
- (BOOL)checkVersionNeedGuide
{
    // 从本地偏好读取版本号
    NSString *versionToShowGuideView = [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
    //!!如果 版本号为空 或者 版本号不等于指定版本（1.0） 此时需要设置引导页
    if(versionToShowGuideView == nil || ![versionToShowGuideView isEqualToString:kVersionToShowGuideView])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *  加载引导页
 */
- (void)initGuideView
{
    SHGuideView *guideView = [[SHGuideView alloc] initWithFrame:self.view.bounds];
    weakSelf(self);
    [guideView.scrollView setGuideCompleteBlock:^(BOOL isOk){
        if(isOk){
            //指定版本 写入本地偏好
            [[NSUserDefaults standardUserDefaults] setObject:kVersionToShowGuideView forKey:@"appVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //进入App
            [weakSelf enterApp];
        }
    }];
    
    [self.view addSubview:guideView];
}
/**
 *  进入APP
 */
- (void)enterApp
{
    if ([UserManager shareInstance].isAutoLogin)
    {
        return ;
    }
    else
    {
        [self initLoginVC];
    }
}
/**
 *  弹出登录界面
 */
- (void)initLoginVC
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        LoginVC *loginVC = [[LoginVC alloc] init];
        JJNavigationController *loginNavVC = [[JJNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNavVC animated:NO completion:nil];
    });

}
/**
 *  初始化子控制器群
 */
- (void)initChildViewControllers
{
    //1、个人收藏
    PersonalCollectVC *pcVC = [[PersonalCollectVC alloc] init];
    pcVC.tabBarItem.title = @"个人收藏";
    pcVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_me"];
    pcVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_meHL"];
    JJNavigationController *pcNC = [[JJNavigationController alloc] initWithRootViewController:pcVC];
    
    [self addChildViewController:pcNC];
    
    //2、最近通话
    RecentVC *recentVC = [[RecentVC alloc] init];
    recentVC.tabBarItem.title = @"最近通话";
    recentVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_mainframe"];
    recentVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    JJNavigationController *recentNC = [[JJNavigationController alloc] initWithRootViewController:recentVC];
    
    [self addChildViewController:recentNC];
    
    //3、通讯录
    AddressBookVC *abVC = [[AddressBookVC alloc] init];
    abVC.tabBarItem.title = @"通讯录";
    abVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
    abVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_contactsHL"];
    JJNavigationController *abNC = [[JJNavigationController alloc] initWithRootViewController:abVC];
    
    [self addChildViewController:abNC];
    
    //4、拨号键盘
    DialVC *dialVC = [[DialVC alloc] init];
    dialVC.tabBarItem.title = @"拨号键盘";
    dialVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    dialVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discoverHL"];
    JJNavigationController *dialNC = [[JJNavigationController alloc] initWithRootViewController:dialVC];
    
    [self addChildViewController:dialNC];
    
    //默认显示第一个
    self.selectedIndex = 0;
}


#pragma mark - 通知相关
/**
 *  添加通知
 */
- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotifacationNeedLogin:) name:kNotificationNeedLogin object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotifacationDidLogin:) name:kNotificationDidLogin object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationLogout:) name:kNotificationDidLogout object:nil];
}
/**
 *  移除通知
 */
- (void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  已经登录
 *
 */
- (void)didReceiveNotifacationDidLogin:(NSNotification *)notification
{
    
}
/**
 *  需要登录
 *
 */
- (void)didReceiveNotifacationNeedLogin:(NSNotification *)notification
{
    
    LoginVC *loginVC = [[LoginVC alloc] init];
    JJNavigationController *loginNavVC = [[JJNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNavVC animated:YES completion:nil];
}
/**
 *  已经退出登录
 *
 */
- (void)didReceiveNotificationLogout:(NSNotification *)notification
{
    
    //popToRootVC
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)obj popToRootViewControllerAnimated:NO];
        }
    }];
    
    //需要登录
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
}


@end
