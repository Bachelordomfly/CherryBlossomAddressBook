//
//  BaseVC.h
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  所有ViewController的基类
 */
@interface BaseVC : UIViewController

#pragma mark - 导航

/**
 *  设置导航栏
 */
-(void) setupNaviBarItems;

#pragma mark - 通知

/**
 *  添加通知
 */
-(void) addNotificationObservers;

/**
 *  移除通知
 */
-(void) removeNotificationObservers;

#pragma mark - 点击事件

/**
 *  点击返回
 *
 *  @param sender
 */
-(void) didClickBack:(id) sender;

@end
