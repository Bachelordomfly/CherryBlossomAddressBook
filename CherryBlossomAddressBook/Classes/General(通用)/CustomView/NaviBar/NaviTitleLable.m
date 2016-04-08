//
//  NaviTitleLable.m
//  MZBook
//
//  Created by hanqing on 14-5-13.
//
//

#import "NaviTitleLable.h"

@implementation NaviTitleLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *) title{
    self = [super init];
    if (self) {
        // Initialization code
        UIFont *titleFont = [UIFont boldSystemFontOfSize:17.0];
        self.frame = CGRectMake(0, floorf((44-titleFont.lineHeight)*0.5), 120, titleFont.lineHeight);
        self.text = title;
        self.font = titleFont;
        self.textColor = kColorBgMain;
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
