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

//联系人表名
static NSString * const ContacterTable = @"Contacter_Table";

//用户表名
static NSString * const UserTable = @"User_Table";

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
                   withIntermediateDirectories:NO
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
                sql_CreateTable =  @"CREATE TABLE IF NOT EXISTS Contacter_Table ( \
                id INTEGER PRIMARY KEY AUTOINCREMENT,   \
                name TEXT,                              \
                nickName TEXT,                          \
                phone TEXT,                             \
                address TEXT,                           \
                avatarPath TEXT,                        \
                sex INTEGER,                            \
                sectionNumber INTEGER                   \
                )";
            }
                break;
            case UserDataBase:
            {
                sql_CreateTable =  @"CREAT TABLE IF NOT EXISTS User_Table ( \
                id INTEGER PRIMARY KEY AUTOINCREMENT,   \
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
        if([self.db executeUpdate:sql_CreateTable])
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






- (void)closeDataBase
{
    if (self.db)
    {
        [self.db close];
        self.db = nil;
    }
    return ;
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
                return YES;
            }
        }
        NSLog(@"该联系人不存在！");
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
                                (name, nickName, phone, address, avatarPath, sex, sectionNumber) \
                                VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@');",
                                ContacterTable,
                                contacterModel.name,
                                contacterModel.nickName,
                                contacterModel.phone,
                                contacterModel.address,
                                contacterModel.avatarPath,
                                [NSNumber numberWithInteger:contacterModel.sex],
                                [NSNumber numberWithInteger:contacterModel.sectionNumber]];
        if ([_db executeUpdate:sql_Insert])
        {
            NSLog(@"插入联系人数据成功！");
            return YES;
        }
        else
        {
            errorMessage = [_db lastErrorMessage];
            NSLog(@"插入联系人数据失败！错误信息：%@", errorMessage);
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
                                name          = '%@'      \
                                nickName      = '%@'      \
                                phone         = '%@'      \
                                address       = '%@'      \
                                avatarPaht    = '%@'      \
                                sex           = '%@'      \
                                sectionNumber = '%@' ",
                                ContacterTable,
                                contacterModel.name,
                                contacterModel.nickName,
                                contacterModel.phone,
                                contacterModel.address,
                                contacterModel.avatarPath,
                                [NSNumber numberWithInteger:contacterModel.sex],
                                [NSNumber numberWithInteger:contacterModel.sectionNumber]];
        if ([_db executeUpdate:sql_Update])
        {
            NSLog(@"修改联系人数据成功！");
            return YES;
        }
        else
        {
            errorMessage = [_db lastErrorMessage];
            NSLog(@"修改联系人数据失败！错误信息：%@", errorMessage);
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
    return YES;
}


#pragma mark - 用户数据库操作

- (BOOL)isExistsOfUserModel:(UserModel *)userModel
{
    return YES;
}
- (BOOL)isExistOfAccount:(NSString *)account
{
    NSString *findSQL = @"select * from table_user ";
    FMResultSet *set = [_db executeQuery:findSQL];
    while ([set next])
    {
         if ([[set stringForColumn:account] isEqualToString:account])
         {
             return YES;
         }
    }
    return NO;
}
- (BOOL)isSuccessRegisterOfUserModel:(UserModel *)userModel
{
    NSString *insertSQL=@"insert into table_user(account, password) values(?,?)";
    BOOL isSuccess = [self.db executeUpdate:insertSQL, userModel.account, userModel.password];
    return isSuccess;
}


@end
