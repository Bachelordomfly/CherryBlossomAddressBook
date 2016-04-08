//
//  UserModel.h
//  樱花通讯录
//
//  Created by RenSihao on 16/3/30.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "ABModel.h"

@interface UserModel : ABModel

/**
 *  用户唯一ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  用户账户
 */
@property (nonatomic, copy) NSString *account;

/**
 *  用户密码
 */
@property (nonatomic, copy) NSString *password;

@end
