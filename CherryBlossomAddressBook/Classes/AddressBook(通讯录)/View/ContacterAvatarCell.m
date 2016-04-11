//
//  UserProfileHeaderCell.m
//  Penkr
//
//  Created by RenSihao on 15/12/10.
//  Copyright © 2015年 ShopEX. All rights reserved.
//

#import "ContacterAvatarCell.h"
#import "ContacterModel.h"

@interface ContacterAvatarCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UIImageView *detailIV;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIView *line;
@end


@implementation ContacterAvatarCell

#pragma mark -

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //设置背景色为白色
        self.backgroundColor = kColorBgMain;
        //添加子控件
        [self addAllSubViews];
    }
    return self;
}

#pragma mark - public method

+ (CGFloat) cellHeight{
    return 87.5f;
}
- (void)updateWithUserModel:(ContacterModel *)userModel
{
    _contacterModel = userModel;
    
    //头像
    if(_contacterModel.avatarPath.length > 0)
    {
        [self.detailIV sd_setImageWithURL:[NSURL URLWithString:_contacterModel.avatarPath]];
    }
    else
    {
        if (_contacterModel.sex != ABSexMan)
        {
            
            [self.detailIV setImage:[UIImage imageNamed:@"default_head_woman"]];
        }
        else
        {
            
            [self.detailIV setImage:[UIImage imageNamed:@"default_head_man"]];
        }
    }
}


#pragma mark - private method

- (void)didClickAvatar
{
    //放大
    if ([self.delegate respondsToSelector:@selector(didClickAvatarImageView:)])
    {
        [self.delegate didClickAvatarImageView:self.detailIV];
    }
}



#pragma mark - 子控件

/**
 *  添加所有子控件
 */
- (void)addAllSubViews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.subTitleLab];
    [self addSubview:self.detailIV];
    [self addSubview:self.detailBtn];
    [self addSubview:self.line];
}
/**
 *  子控件布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //标题
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).offset(25);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(25);
    }];
    
    //副标题
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(4);
    }];
    
    //详细图片
    [self.detailIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(([ContacterAvatarCell cellHeight]-60.f)/2.f);
        make.right.mas_equalTo(self.detailBtn.mas_left).offset(-16);
        make.width.height.mas_equalTo(60.f);
    }];
    
    //详细按钮
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-17);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    //分割线
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - lazyload

- (UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:16.0];
        _titleLab.textColor = kColorTextMain;
        _titleLab.text = @"头像";
        [_titleLab sizeToFit];
    }
    return _titleLab;
}
- (UILabel *)subTitleLab
{
    if(!_subTitleLab)
    {
        _subTitleLab = [[UILabel alloc] init];
        _subTitleLab.font = [UIFont systemFontOfSize:14.f];
        _subTitleLab.textColor = UIColorFromRGB_0x(0x666666);
        _subTitleLab.text = @"点击修改";
        [_subTitleLab sizeToFit];
    }
    return _subTitleLab;
}
- (UIImageView *)detailIV
{
    if(!_detailIV)
    {
        _detailIV = [[UIImageView alloc] init];
        _detailIV.contentMode = UIViewContentModeScaleAspectFill;
        [_detailIV.layer setMasksToBounds:YES];
        [_detailIV.layer setCornerRadius:4.f];
        [_detailIV setBackgroundColor:kColorBgSub];
        
        //添加手势
        _detailIV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAvatar)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_detailIV addGestureRecognizer:tap];
    }
    return _detailIV;
}
- (UIButton *)detailBtn
{
    if(!_detailBtn)
    {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setBackgroundImage:[UIImage imageNamed:@"Arrow_Right"] forState:UIControlStateNormal];
    }
    return _detailBtn;
}

- (UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor grayColor];
        _line.alpha = 0.3f;
    }
    return _line;
}





@end


