//
//  ContacterDetailChangeVC.h
//  Penkr
//
//  Created by RenSihao on 15/12/14.
//  Copyright © 2015年 ShopEX. All rights reserved.
//



typedef NS_OPTIONS(NSUInteger, ContacterDetailChangeType){
    ContacterDetailChangeName = 0,      //姓名
    ContacterDetailChangeNickName,      //备注
    ContacterDetailChangePhone,         //电话号
    ContacterDetailChangeAddress        //地址
};

typedef void(^ContacterDetailChangeNameBlock)(NSString *newName);
typedef void(^ContacterDetailChangeNickNameBlock)(NSString *newNickName);
typedef void(^ContacterDetailChangePhoneBlock)(NSString *newWeChatAccount);
typedef void(^ContacterDetailChangeAddressBlock)(NSString *newStoreName);


@interface ContacterDetailChangeVC : BaseVC

@property (nonatomic, copy) ContacterDetailChangeNameBlock nameBlock;           //修改姓名block
@property (nonatomic, copy) ContacterDetailChangeNickNameBlock nickNameBlock;   //修改备注block
@property (nonatomic, copy) ContacterDetailChangePhoneBlock phoneBlock;         //修改电话号block
@property (nonatomic, copy) ContacterDetailChangeAddressBlock addressBlock;     //修改地址block
@property (nonatomic, assign) ContacterDetailChangeType changeType;             //cell的种类

/**
 *  修改用户姓名
 *
 *  @param title
 *  @param oldInfo
 *  @param ContacterDetailChangeNameBlock
 */
- (void)prepareCellTitle:(NSString *)title
        CellContentInfo:(NSString *)oldInfo
        ContacterDetailChangeNameBlock:(ContacterDetailChangeNameBlock)contacterDetailChangeNameBlock;

/**
 *  修改用户备注
 *
 *  @param title
 *  @param oldInfo
 *  @param ContacterDetailChangeNickNameBlock
 */
- (void)prepareCellTitle:(NSString *)title
        CellContentInfo:(NSString *)oldInfo
        ContacterDetailChangeNickNameBlock:(ContacterDetailChangeNickNameBlock)contacterDetailChangeNickNameBlock;

/**
 *  修改用户电话号
 *
 *  @param title
 *  @param oldInfo
 *  @param ContacterDetailChangePhoneBlock
 */
- (void)prepareCellTitle:(NSString *)title
        CellContentInfo:(NSString *)oldInfo
        ContacterDetailChangePhoneBlock:(ContacterDetailChangePhoneBlock)contacterDetailChangePhoneBlock;

/**
 *  修改地址
 *
 *  @param title
 *  @param oldInfo
 *  @param ContacterDetailChangeShopBlock
 */
- (void)prepareCellTitle:(NSString *)title CellContentInfo:(NSString *)oldInfo ContacterDetailChangeAddressBlock:(ContacterDetailChangeAddressBlock)contacterDetailChangeAddressBlock;

/**
 *  初始化联系人
 *
 *  @param contacter 
 */
- (instancetype)initWithContacterModel:(ContacterModel *)contacter;

@end
