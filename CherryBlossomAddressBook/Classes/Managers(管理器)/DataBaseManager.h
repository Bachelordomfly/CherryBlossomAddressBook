//
//  DataBaseManager.h
//  樱花通讯录
//
//  Created by RenSihao on 16/3/30.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  数据库类型（存储对象类型）
 */
typedef NS_ENUM(NSUInteger, DataBaseType) {
    /**
     *  联系人数据库类型
     */
    ContacterDataBase,
    /**
     *  用户数据库类型
     */
    UserDataBase
};

@class UserModel;

@interface DataBaseManager : NSObject

#pragma mark - 数据库

/**
 *  数据库管理器（单例）
 */
+ (instancetype)shareInstanceDataBase;

/**
 *  打开数据库
 */
- (BOOL)successOpenDataBaseType:(DataBaseType)dataBaseType;

#pragma mark - 联系人数据库操作

/********************** 联系人表操作 ********************************/

/**
 *  查询 - 查询是否存在该联系人
 *
 *  @param contacterModel 联系人模型
 *
 *  @return
 */
- (BOOL)isExistsOfContacterModel:(ContacterModel *)contacterModel;

/**
 *  写入 - 能否成功写入该联系人数据
 *
 *  @param contacterModel 联系人模型
 *
 *  @return 
 */
- (BOOL)successInsertContacterModel:(ContacterModel *)contacterModel;

/**
 *  修改 - 能否更新该联系人数据
 *
 *  @param contacterModel 联系人模型
 *
 *  @return 
 */
- (BOOL)successUpdateContacterModle:(ContacterModel *)contacterModel;

/**
 *  删除 - 能否删除该联系人数据
 *
 *  @param contacterModel 联系人模型
 *
 *  @return
 */
- (BOOL)successDeleteContacterModle:(ContacterModel *)contacterModel;

/**
 *  读取 - 从数据库获取所有联系人模型
 *
 *  @return
 */
- (NSMutableArray *)getAllContacterModelOfDataBase;

/**
 *  读取 - 从数据库获取单个联系人模型
 *
 *  @param contacterID 联系人id
 *
 *  @return 
 */
- (ContacterModel *)getContacterModelOfContacterID:(NSInteger)contacterID;

/**
 *  读取 - 从数据库获取单个联系人模型
 *
 *  @param contacterName 联系人
 *
 *  @return 
 */
- (ContacterModel *)getContacterModelOfContacterName:(NSString *)contacterName;

#pragma mark - 用户数据库操作

/********************** 用户表操作 ********************************/

/**
 *  查询 - 是否存在该用户
 *
 *  @param userModel 用户模型
 *
 *  @return
 */
- (BOOL)isExistsOfUserModel:(UserModel *)userModel;

/**
 *  查询 - 用户账号和密码是否正确匹配
 *
 *  @param userModel 用户模型
 *
 *  @return 
 */
- (BOOL)isCorrectOfUserModel:(UserModel *)userModel;

/**
 *  写入 - 能否成功在数据库注册该用户
 *
 *  @param userModel
 *
 *  @return
 */
- (BOOL)isSuccessRegisterOfUserModel:(UserModel *)userModel;


@end
