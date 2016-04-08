//
//  DataBaseManager.h
//  樱花通讯录
//
//  Created by RenSihao on 16/3/30.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface DataBaseManager : NSObject

/**
 *  数据库管理器（单例）
 */
+ (instancetype)shareInstanceDataBase;

/**
 *  打开用户数据库
 *
 *  @return
 */
- (BOOL)openUserDataBase;

/**
 *  打开联系人数据库
 *
 *  @param userModel 用户模型
 *
 *  @return
 */
- (BOOL)openContactersDataBaseWithUserModel:(UserModel *)userModel;

/**
 *  查询是否存在此账号
 *
 *  @param account 待查询账号
 *
 *  @return
 */
- (BOOL)isExistOfAccount:(NSString *)account;

/**
 *  能否成功在数据库注册该用户
 *
 *  @param userModel
 *
 *  @return
 */
- (BOOL)isSuccessRegisterOfUserModel:(UserModel *)userModel;

/**
 *  关闭数据库
 */
- (void)closeDataBase;
@end
