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

#pragma mark - setter

#pragma mark - getter

- (BOOL)isAutoLogin
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityAccount]
        && [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityPassword] ? YES : NO;
}
@end
