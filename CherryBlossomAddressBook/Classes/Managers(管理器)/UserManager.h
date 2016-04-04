//
//  UserManager.h
//  MicroBlog
//
//  Created by xujiajia on 16/3/18.
//  Copyright © 2016年 xujiajia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserSecurityAccount    @"kUserSecurityAccount_"
#define kUserSecurityPassword   @"kUserSecurityPassword_"

@interface UserManager : NSObject

/**
 *  是否自动登录
 */
@property (nonatomic, assign, getter=isAutoLogin) BOOL autoLogin;

/**
 *  全局用户单例
 *
 */
+ (instancetype)shareInstance;
@end
