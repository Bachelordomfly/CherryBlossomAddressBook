//
//  AppManager.m
//  MicroBlog
//
//  Created by xujiajia on 16/3/18.
//  Copyright © 2016年 xujiajia. All rights reserved.
//

#import "AppManager.h"

@interface AppManager ()

@end

@implementation AppManager

+ (instancetype)sharedInstance
{
    static AppManager *appManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appManager = [[AppManager alloc] init];
    });
    return appManager;
}

- (BOOL)callPhoneWithPhoneNumber:(NSString *)phone
{
    if ([phone isMobileNumber] || [phone isTelPhoneNumber])
    {
        NSString *str = [NSString stringWithFormat:@"tel://%@", phone];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else
    {
        return NO;
    }
}




@end


