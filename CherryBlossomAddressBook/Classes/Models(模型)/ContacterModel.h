//
//  ContacterModel.h
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "ABModel.h"


@interface ContacterModel : ABModel

@property (nonatomic, copy)   NSString *name;         //姓名
@property (nonatomic, copy)   NSString *nickName;     //备注名
@property (nonatomic, copy)   NSString *phone;        //电话
@property (nonatomic, copy)   NSString *address;      //地址
@property (nonatomic, copy)   NSString *avatarPath;   //头像路径
@property (nonatomic, assign) ABSex sex;              //性别
@property (nonatomic, assign) NSInteger sectionNumber; //组
@end
