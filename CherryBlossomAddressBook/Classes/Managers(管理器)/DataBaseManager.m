//
//  DataBaseManager.m
//  樱花通讯录
//
//  Created by RenSihao on 16/3/30.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "DataBaseManager.h"

@interface DataBaseManager ()

@property (nonatomic, strong) FMDatabase *db;
@end

@implementation DataBaseManager

+ (instancetype)shareInstanceDataBase
{
    static DataBaseManager *dataBaseManager = nil;
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
      
        dataBaseManager = [[DataBaseManager alloc] init];
    });
    return dataBaseManager;
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
- (BOOL)openUserDataBase
{
    if (self.db)
    {
        return NO;
    }
    
    //获取文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    path = [path stringByAppendingPathComponent:@"User.db"];
    
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NULL];
    
    if (!isExist)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //实例化数据库对象
    self.db = [FMDatabase databaseWithPath:path];
    
    //打开数据库
    if ([self.db open])
    {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
    
    //创建数据库表
    NSString *sql = @"create table if not exists table_user (id integer primary key autoincrement, account text, passwd text);";
    if([self.db executeUpdate:sql])
    {
        NSLog(@"表创建成功");
        return YES;
    }else
    {
        NSLog(@"表创建失败");
        return NO;
    }
}
- (BOOL)openContactersDataBaseWithUserModel:(UserModel *)userModel
{
    if (self.db)
    {
        return NO;
    }
    
    //获取文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    path = [path stringByAppendingPathComponent:@"Contacter.db"];
    
    BOOL isDirectory;
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (!isDirectory || !isExist)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //实例化数据库对象
    self.db = [FMDatabase databaseWithPath:path];
    
    //打开数据库
    if ([self.db open])
    {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
    
    //创建数据库表
    NSString *creatSQL = @"create table if not exists table_contacter (id integer primary key autoincrement, account text, passwd text);";
    if([self.db executeUpdate:creatSQL])
    {
        NSLog(@"表创建成功");
    }else
    {
        NSLog(@"表创建失败");
    }
    
    return YES;
}
- (BOOL)isExistOfAccount:(NSString *)account
{
    NSString *findSQL = @"select * from table_user ";
    FMResultSet *set = [self.db executeQuery:findSQL];
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
