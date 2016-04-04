//
//  LoginPersonCollect.m
//  AdressBook
//
//  Created by XuJiajia on 16/1/12.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "LoginPersonCollect.h"

#define  FILEPATH  [dbFileDirectory stringByAppendingPathComponent:@"adressBook.sqlite"]
#define DK_APP      [UIApplication sharedApplication].delegate
#define DB_PARENT_DIRECTORY         @"database"

@implementation LoginPersonCollect

//// 获得单例数据库(用户)
//+ (FMDatabase *) sharedDatabaseUser
//{
//    static FMDatabase *tsDB;
//    
//    @synchronized(self)
//    {
//        if (!tsDB) {
//            tsDB = [self creatSqlite];
//        }
//        return tsDB;
//    }
//}
//
//#pragma mark-创建数据库
//+(id)creatSqlite
//{
//    //创建数据库
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentDirectory = [path objectAtIndex:0];
//    
//    NSString *dbFileDirectory = [documentDirectory stringByAppendingPathComponent:@"database"];
//    NSLog(dbFileDirectory);
//    
//    BOOL isDirectory;
//    
//    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:dbFileDirectory isDirectory:&isDirectory];
//    
//    if (!isDirectory || !isExist) {
//        [[NSFileManager defaultManager] createDirectoryAtPath:dbFileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    //打开数据库
//    FMDatabase *db = [FMDatabase databaseWithPath:FILEPATH];
//    BOOL result = [db open];
//    if (result) {
//        NSLog(@"数据库打开成功");
//    }
//    else{
//        NSLog(@"数据库打开失败");
//    }
//
//    //创建数据库表
//    NSString *sql = @"create table if not exists t_adressBook(id integer primary key autoincrement, name text, passwd text);";
//    result = [db executeUpdate:sql];
//    if(result)
//    {
//        NSLog(@"表创建成功");
//    }else
//    {
//        NSLog(@"表创建失败");
//    }
//
//    return db;
//}



@end
