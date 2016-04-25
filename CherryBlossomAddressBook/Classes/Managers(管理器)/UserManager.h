//
//  UserManager.h
//  MicroBlog
//
//  Created by xujiajia on 16/3/18.
//  Copyright © 2016年 xujiajia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserModelFromLogin     @"kUserModelFromLogin_"
#define kUserSecurityAccount    @"kUserSecurityAccount_"
#define kUserSecurityPassword   @"kUserSecurityPassword_"

@class UserSecurity;

@interface UserManager : NSObject

/**
 *  用户模型
 */
@property (nonatomic, strong) UserModel *userModel;
/**
 *  用户登录信息
 */
@property (nonatomic, strong) UserSecurity *userSecurity;
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


#pragma mark - UserSecurity

/**
 *  保存登录信息
 */
@interface UserSecurity : Model

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

@end