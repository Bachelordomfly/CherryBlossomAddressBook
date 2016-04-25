//
//  ABModel.h
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通用性别枚举
 */
typedef NS_ENUM(NSInteger, ABSex) {
    /**
     *  性别未知
     */
    ABSexUnknow = 0,
    /**
     *  男性
     */
    ABSexMan = 1,
    /**
     *  女性
     */
    ABSexWomen = 2
};

/**
 *  所有model基类
 */
@interface Model : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
