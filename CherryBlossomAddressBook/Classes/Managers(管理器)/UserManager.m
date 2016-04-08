//
//  UserManager.m
//  MicroBlog
//
//  Created by xujiajia on 16/3/18.
//  Copyright © 2016年 xujiajia. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)shareInstance
{
    static UserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[UserManager alloc] init];
    });
    return userManager;
}
- (instancetype)init
{
    if (self = [super init])
    {
        NSDictionary *dictUser = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kUserModelFromLogin];
        if (dictUser)
        {
            self.userModel = [[UserModel alloc] initWithDictionary:dictUser];
        }
        self.userSecurity = [[UserSecurity alloc] init];
    }
    return self;
}

#pragma mark - setter

#pragma mark - getter

- (BOOL)isAutoLogin
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityAccount]
        && [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityPassword] ? YES : NO;
}
@end



#pragma mark - UserSecurity

/**
 *  保存登录信息
 */
@implementation UserSecurity

#pragma mark - setter/getter

- (void)setAccount:(NSString *)account
{
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:kUserSecurityAccount];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (NSString *)account
{
   return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityAccount];
}
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:kUserSecurityPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityPassword];
}

@end
