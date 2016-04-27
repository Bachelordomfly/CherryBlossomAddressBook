//
//  DataBaseManager.m
//  樱花通讯录
//
//  Created by RenSihao on 16/3/30.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "DataBaseManager.h"
#import "UserModel.h"
#import "ContacterModel.h"

//联系人表名(根据当前登录信息唯一对应)
#define ContacterTable  [@"Contacter_Table_" stringByAppendingString:[UserManager shareInstance].userSecurity.account]

//用户表名
#define UserTable  @"User_Table"

@interface DataBaseManager ()

/**
 *  数据库实例化对象
 */
@property (nonatomic, strong) FMDatabase *db;

/**
 *  数据库类型
 */
@property (nonatomic, assign) DataBaseType dataBaseType;
@end

@implementation DataBaseManager

#pragma mark - 数据库

+ (instancetype)shareInstanceDataBase
{
    static DataBaseManager *dataBaseManager = nil;
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
      
        dataBaseManager = [[DataBaseManager alloc] init];
    });
    return dataBaseManager;
}

/**
 *  打开数据库
 */
- (BOOL)successOpenDataBaseType:(DataBaseType)dataBaseType
{
    //1、判断数据库类型
    NSString *tablePath = @"";
    switch (dataBaseType) {
        case ContacterDataBase:
        {
            tablePath = @"database/Contacter.sqlite";
        }
            break;
            case UserDataBase:
        {
            tablePath = @"database/User.sqlite";
        }
            break;
            
        default:
        {
            NSLog(@"数据库类型不支持！");
            return NO;
        }
            break;
    }
    
    //2、获取数据库文件路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *contacterTablePath = [documentPath stringByAppendingPathComponent:tablePath];
    
    
    //3、判断该数据库文件路径是否存在，不存在则创建
    BOOL isExist = [fileManager fileExistsAtPath:contacterTablePath isDirectory:NULL];
    if (!isExist)
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件不存在，开始创建！", tablePath]);
        if ([fileManager createDirectoryAtPath:[documentPath stringByAppendingPathComponent:@"database"]
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil])
        {
            NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件创建成功！", tablePath]);
        }
        else
        {
            NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件创建失败！", tablePath]);
            return NO;
        }
    }
    else
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件存在，无需创建！", tablePath]);
    }
    
    //4、实例化数据库对象
    _db = [FMDatabase databaseWithPath:contacterTablePath];
    
    //5、判断能否打开数据库
    if ([_db open])
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件打开成功！", tablePath]);
        //6、创建相应的数据库表
        NSString *sql_CreateTable = @"";
        switch (dataBaseType) {
            case ContacterDataBase:
            {
                //根据当前登录信息，建立对应联系人表，账号是唯一的
                sql_CreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS                                 '%@' ( \
                    id INTEGER PRIMARY KEY AUTOINCREMENT,   \
                    name TEXT,                              \
                    nickName TEXT,                          \
                    phone TEXT,                             \
                    address TEXT,                           \
                    avatarPath TEXT,                        \
                    sex INTEGER,                            \
                    sectionNumber INTEGER,                  \
                    tagStr TEXT                           \
                    )", ContacterTable];
            }
                break;
            case UserDataBase:
            {
                sql_CreateTable =  @"CREATE TABLE IF NOT EXISTS User_Table ( \
                id INTEGER PRIMARY KEY AUTOINCREMENT,   \
                account TEXT,                           \
                password TEXT                           \
                )";
            }
                break;
            default:
            {
                NSLog(@"数据库类型暂不支持！");
                return NO;
            }
                break;
        }
        
        //7、检测表是否创建成功
        if([_db executeUpdate:sql_CreateTable])
        {
            NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件 - 表创建成功！", tablePath]);
            return YES;
        }
        else
        {
            NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件 - 表创建失败！", tablePath]);
            return NO;
        }
        
        return YES;
    }
    else
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@数据库文件打开失败！", tablePath]);
        return NO;
    }
}


#pragma mark - 联系人数据库操作

- (BOOL)isExistsOfContacterModel:(ContacterModel *)contacterModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        NSString *sql_Find = [NSString stringWithFormat:@"SELECT * FROM %@", ContacterTable];
        FMResultSet *set = [_db executeQuery:sql_Find];
        while ([set next])
        {
            if ([[set stringForColumn:@"name"] isEqualToString:contacterModel.name])
            {
                NSLog(@"该联系人已经存在!");
                [_db close];
                return YES;
            }
        }
        NSLog(@"该联系人不存在！");
        [_db close];
        return NO;
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开联系人数据库！错误信息：%@", errorMessage);
        return NO;
    }
}
- (BOOL)successInsertContacterModel:(ContacterModel *)contacterModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        NSString *sql_Insert = [NSString stringWithFormat:@"INSERT INTO '%@' \
                                (name, nickName, phone, address, avatarPath, sex, sectionNumber, tagStr) \
                                VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');",
                                ContacterTable,
                                contacterModel.name,
                                contacterModel.nickName,
                                contacterModel.phone,
                                contacterModel.address,
                                contacterModel.avatarPath,
                                [NSNumber numberWithInteger:contacterModel.sex],
                                [NSNumber numberWithInteger:contacterModel.sectionNumber],
                                contacterModel.tagStr];
        if ([_db executeUpdate:sql_Insert])
        {
            NSLog(@"插入联系人数据成功！");
            [_db close];
            return YES;
        }
        else
        {
            errorMessage = [_db lastErrorMessage];
            NSLog(@"插入联系人数据失败！错误信息：%@", errorMessage);
            [_db close];
            return NO;
        }
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开联系人数据库！错误信息：%@", errorMessage);
        return NO;
    }
}
- (BOOL)successUpdateContacterModle:(ContacterModel *)contacterModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        NSString *sql_Update = [NSString stringWithFormat:@"UPDATE '%@' SET \
                                name          = '%@',      \
                                nickName      = '%@',     \
                                phone         = '%@',      \
                                address       = '%@',     \
                                avatarPath    = '%@',      \
                                sex           = '%@',     \
                                sectionNumber = '%@' WHERE id = '%@'",
                                ContacterTable,
                                contacterModel.name,
                                contacterModel.nickName,
                                contacterModel.phone,
                                contacterModel.address,
                                contacterModel.avatarPath,
                                [NSNumber numberWithInteger:contacterModel.sex],
                                [NSNumber numberWithInteger:contacterModel.sectionNumber],
                                [NSNumber numberWithInteger:contacterModel.contacterID]];
        if ([_db executeUpdate:sql_Update])
        {
            NSLog(@"修改联系人数据成功！");
            [_db close];
            return YES;
        }
        else
        {
            errorMessage = [_db lastErrorMessage];
            NSLog(@"修改联系人数据失败！错误信息：%@", errorMessage);
            [_db close];
            return NO;
        }
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开联系人数据库！错误信息：%@", errorMessage);
        return NO;
    }
}
- (BOOL)successDeleteContacterModle:(ContacterModel *)contacterModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        
        NSString *sql_Delete = [NSString stringWithFormat:@"DELETE FROM '%@' WHERE \
                                    id            = '%@'      \
                                AND nickName      = '%@'      \
                                AND phone         = '%@'      \
                                AND address       = '%@'      \
                                AND avatarPath    = '%@'      \
                                AND sex           = '%@'      \
                                AND sectionNumber = '%@';",
                                ContacterTable,
                                [NSNumber numberWithInteger:contacterModel.contacterID],
                                contacterModel.nickName,
                                contacterModel.phone,
                                contacterModel.address,
                                contacterModel.avatarPath,
                                [NSNumber numberWithInteger:contacterModel.sex],
                                [NSNumber numberWithInteger:contacterModel.sectionNumber]];
        if ([_db executeUpdate:sql_Delete])
        {
            NSLog(@"删除联系人数据成功！");
            [_db close];
            return YES;
        }
        else
        {
            errorMessage = [_db lastErrorMessage];
            NSLog(@"删除联系人数据失败！错误信息：%@", errorMessage);
            [_db close];
            return NO;
        }
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开联系人数据库！错误信息：%@", errorMessage);
        return NO;
    }
}
- (NSMutableArray *)getAllContacterModelOfDataBase
{
    NSString *errorMessage = @"";
    NSMutableArray *contacterArray = [NSMutableArray array];
    if ([_db open])
    {
        NSString *sql_ReadAll = [NSString stringWithFormat:@"SELECT * FROM %@", ContacterTable];
        FMResultSet *set = [_db executeQuery:sql_ReadAll];
        while ([set next]) {
            ContacterModel *contactModel = [ContacterModel new];
            contactModel.contacterID = [set intForColumn:@"id"];
            contactModel.name = [set stringForColumn:@"name"];
            contactModel.nickName = [set stringForColumn:@"nickName"];
            contactModel.phone = [set stringForColumn:@"phone"];
            contactModel.address = [set stringForColumn:@"address"];
            contactModel.avatarPath = [set stringForColumn:@"avatarPath"];
            contactModel.sex = [set intForColumn:@"sex"];
            contactModel.sectionNumber = [set intForColumn:@"sectionNumber"];
            [contacterArray addObject:contactModel];
        }
        return contacterArray;
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开联系人数据库！错误信息：%@", errorMessage);
        return contacterArray;
    }
}

#pragma mark - 用户数据库操作

- (BOOL)isExistsOfUserModel:(UserModel *)userModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        NSString *sql_Find = [NSString stringWithFormat:@"SELECT * FROM %@", UserTable];
        FMResultSet *set = [_db executeQuery:sql_Find];
        while ([set next])
        {
            if ([[set stringForColumn:@"account"] isEqualToString:userModel.account])
            {
                NSLog(@"该用户已经存在!");
                [_db close];
                return YES;
            }
        }
        NSLog(@"该用户不存在！");
        [_db close];
        return NO;
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开联系人数据库！错误信息：%@", errorMessage);
        return NO;
    }
}
- (BOOL)isCorrectOfUserModel:(UserModel *)userModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        NSString *sql_Find = [NSString stringWithFormat:@"SELECT * FROM %@", UserTable];
        FMResultSet *set = [_db executeQuery:sql_Find];
        while ([set next])
        {
            if ([[set stringForColumn:@"account"] isEqualToString:userModel.account] &&
                [[set stringForColumn:@"password"] isEqualToString:userModel.password])
            {
                NSLog(@"用户账号密码匹配正确！");
                [_db close];
                return YES;
            }
        }
        NSLog(@"用户账号密码匹配错误！");
        [_db close];
        return NO;
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开用户数据库！错误信息：%@", errorMessage);
        return NO;
    }
}
- (BOOL)isSuccessRegisterOfUserModel:(UserModel *)userModel
{
    NSString *errorMessage = @"";
    if ([_db open])
    {
        NSString *sql_Insert = [NSString stringWithFormat:@"INSERT INTO '%@' \
                                (account, password) \
                                VALUES ('%@', '%@');",
                                UserTable,
                                userModel.account,
                                userModel.password];
        if ([_db executeUpdate:sql_Insert])
        {
            NSLog(@"新建用户数据成功！");
            [_db close];
            return YES;
        }
        else
        {
            errorMessage = [_db lastErrorMessage];
            NSLog(@"新建用户数据失败！错误信息：%@", errorMessage);
            [_db close];
            return NO;
        }
    }
    else
    {
        errorMessage = [_db lastErrorMessage];
        NSLog(@"无法打开用户数据库！错误信息：%@", errorMessage);
        return NO;
    }
}


@end
