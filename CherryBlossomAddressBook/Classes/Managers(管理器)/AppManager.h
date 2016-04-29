//
//  AppManager.h
//  MicroBlog
//
//  Created by xujiajia on 16/3/18.
//  Copyright © 2016年 xujiajia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

/**
 *  整个APP全局管理器 单例
 *
 *  @return 
 */
+ (instancetype)sharedInstance;

/**
 *  调用系统打电话
 *
 *  @param phone 号码
 */
- (BOOL)callPhoneWithPhoneNumber:(NSString *)phone;

/**
 *  调用系统发短信
 *
 *  @return
 */
- (BOOL)sendMessage;
@end
