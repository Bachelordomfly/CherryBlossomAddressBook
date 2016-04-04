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
    ABUnknow = 0,
    /**
     *  男性
     */
    ABMan = 1,
    /**
     *  女性
     */
    ABWomen = 2
};

/**
 *  所有model基类
 */
@interface ABModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
