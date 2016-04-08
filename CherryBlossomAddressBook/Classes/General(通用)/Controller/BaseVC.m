//
//  BaseVC.m
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "BaseVC.h"
#import "NaviTitleLable.h"

@interface BaseVC ()

@property(nonatomic,strong) NaviTitleLable *titleLb;
@end

@implementation BaseVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景色
    //...
    self.view.backgroundColor = kColorAppMain;
    
    //设置导航栏
    [self setupNaviBarItems];
    
    //添加通知
    [self addNotificationObservers];
}
- (void)dealloc
{
    //移除通知
    [self removeNotificationObservers];
}

#pragma mark - 导航

- (void)setupNaviBarItems
{
    if ([self.navigationController.viewControllers count] > 1)
    {
        //如果有素材 此处可设置返回按钮的图片
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBack:)];
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

#pragma mark - setter / getter

-(void)setTitle:(NSString *)title
{
    if (!_titleLb)
    {
        _titleLb = [[NaviTitleLable alloc] initWithTitle:title];
        self.navigationItem.titleView = self.titleLb;
    }
    [_titleLb setText:title];
}

#pragma mark - 通知

//添加通知
- (void)addNotificationObservers
{
}

//移除通知
- (void)removeNotificationObservers
{
    
}

#pragma mark - 点击事件

/**
 *  返回
 *
 *  @param sender 
 */
- (void)didClickBack:(id)sender
{
    if ([self.navigationController.viewControllers count] > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
