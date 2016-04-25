//
//  SHNotificationMacro.h
//  MicroBlog
//
//  Created by xujiajia on 15/12/29.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#ifndef NotificationMacro_h
#define NotificationMacro_h

/**
 *  定义通知
 */
static NSString * const kNotificationNeedLogin  = @"kNotificationNeedLogin";
static NSString * const kNotificationDidLogin   = @"kNotificationDidLogin";
static NSString * const kNotificationDidLogout  = @"kNotificationDidLogout";
static NSString * const kNotificationDidRegiste = @"kNotificationDidRegiste";

/**
 *  对联系人做的所有有效操作，都归纳为“联系人改变”通知（包括新建、修改、删除）
 */
static NSString * const kNotificationContacterChange = @"kNotificationContacterChange";


#endif /* NotificationMacro_h */
