//
//  JJButton.m
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "JJButton.h"

@implementation JJButton

-(instancetype)initWithFrame:(CGRect)frame buttonStyle:(HTPressableButtonStyle)style
{
    if (self =[super initWithFrame:frame buttonStyle:style]) {
        self.shadowColor = UIColorFromRGB_0x(0xf291e7);
        self.buttonColor = UIColorFromRGB_0x(0xeda5e5);
        [self.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

@end
