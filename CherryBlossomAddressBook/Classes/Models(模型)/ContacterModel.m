//
//  ContacterModel.m
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "ContacterModel.h"

@implementation ContacterModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionary:dict])
    {
        
    }
    return self;
}
- (NSString *)name
{
    if (!_name || [_name isEqualToString:@"(null)"])
    {
        _name = @"暂无";
    }
    return _name;
}
- (NSString *)nickName
{
    if (!_nickName || [_nickName isEqualToString:@"(null)"])
    {
        _nickName = @"暂无";
    }
    return _nickName;
}
- (NSString *)phone
{
    if (!_phone || [_phone isEqualToString:@"(null)"])
    {
        _phone = @"暂无";
    }
    return _phone;
}
- (NSString *)address
{
    if (!_address || [_address isEqualToString:@"(null)"])
    {
        _address = @"暂无";
    }
    return _address;
}
- (NSString *)avatarPath
{
    if (!_avatarPath || [_avatarPath isEqualToString:@"(null)"])
    {
        _avatarPath = @"暂无";
    }
    return _avatarPath;
}
//- (ABSex)sex
//{
//    if (!_sex || _sex == 0)
//    {
//        
//    }
//    return _sex;
//}
//- (NSInteger)sectionNumber
//{
//
//}




@end
