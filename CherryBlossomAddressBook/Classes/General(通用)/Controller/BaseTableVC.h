//
//  BaseTableVC.h
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
/**
 *  点击列表后，还原列表状态为deselect状态
 *
 *  @param tableView
 */
#define deselectRowWithTableView(tableView) double delayInSeconds = 1.0;dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];});

/**
 *  所有TableViewController的基类
 */
@interface BaseTableVC : BaseVC

@property (nonatomic, strong) UITableView *tableView;

/**
 *  初始方法
 *  @param style
 */
- (instancetype)initWithStyle:(UITableViewStyle) style;

@end

