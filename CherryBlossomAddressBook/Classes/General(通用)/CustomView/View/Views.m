//
//  Views.m
//  AdressBook
//
//  Created by XuJiajia on 16/3/22.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "Views.h"

@interface RecentTitleView ()

@property (nonatomic, strong) UISegmentedControl *midSC;
@end

@implementation RecentTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.midSC];
        
    }
    return self;
}

- (UISegmentedControl *)midSC
{
    if(!_midSC)
    {
        _midSC = [[UISegmentedControl alloc] initWithItems:@[@"所有通话", @"未接来电"]];
        _midSC.frame = self.frame;
        _midSC.selectedSegmentIndex = 0;
        
    }
    return _midSC;
}

@end






