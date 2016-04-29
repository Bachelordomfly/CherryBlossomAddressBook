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
- (NSString *)tagStr
{
    if (!_tagStr || [_tagStr isEqualToString:@"(null)"])
    {
        _tagStr = @"暂无标签";
    }
    return _tagStr;
}



@end
