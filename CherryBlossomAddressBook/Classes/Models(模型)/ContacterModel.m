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
        _name = [dict objectForKey:@"name"];
    }
    return self;
}

@end
