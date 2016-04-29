//
//  UserProfileSexPopView.m
//  Penkr
//
//  Created by RenSihao on 15/12/18.
//  Copyright © 2015年 ShopEX. All rights reserved.
//

#import "ContacterSexPopView.h"
#import "Masonry.h"
#import "UserManager.h"

@interface ContacterSexPopView ()

@property (nonatomic, strong) UIView *maskView;      //蒙版
@property (nonatomic, strong) UIView *popView;       //中间浮窗
@property (nonatomic, strong) UIButton *manBtn;      //男性按钮
@property (nonatomic, strong) UIButton *womenBtn;    //女性按钮
@property (nonatomic, strong) UIImageView *selectIV; //对勾
@property (nonatomic, strong) UIButton *selectBtn;   //记录当前勾选的按钮
@property (nonatomic, assign) ABSex originSex;       //原始性别
@property (nonatomic, strong) ContacterModel *model;
@end

@implementation ContacterSexPopView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame withContacterModel:(ContacterModel *)model
{
    if(self = [super initWithFrame:frame])
    {
        _model = model;
        _originSex = model.sex;
        
        [self addAllSubViews];
        
        //默认状态
        if(_originSex == ABSexMan)
        {
            _selectBtn = self.manBtn;
            _selectBtn.selected = YES;
        }
        else if (_originSex == ABSexWomen)
        {
            _selectBtn = self.womenBtn;
            _selectBtn.selected = YES;
        }
        else
        {
            _selectBtn = [UIButton new];
        }
        
    }
    return self;
}

#pragma mark - 子控件

/**
 *  添加所有子控件
 */
- (void)addAllSubViews
{
    [self addSubview:self.maskView];
    [self addSubview:self.popView];
    [self addSubview:self.manBtn];
    [self addSubview:self.womenBtn];
    [self addSubview:self.selectIV];
}
/**
 *  子控件布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //maskView
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.mas_equalTo(self);
    }];
    
    //中间浮窗pop
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(60);
        make.right.mas_equalTo(self.mas_right).offset(-60);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-40);
        make.height.mas_equalTo(167);
    }];
    
    //男性按钮
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.popView.mas_top).offset(37.5);
        make.centerX.mas_equalTo(self).offset(-50);
        make.width.height.mas_equalTo(58);
    }];
    
    //女性按钮
    [self.womenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(50);
        make.top.height.width.mas_equalTo(self.manBtn);
    }];
    
    //对勾
    if(_originSex == ABSexMan)
    {
        [self.selectIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.manBtn);
            make.top.mas_equalTo(self.manBtn.mas_bottom).offset(16);
            make.width.mas_equalTo(26);
            make.height.mas_equalTo(18);
        }];
    }
    else if(_originSex == ABSexWomen)
    {
        [self.selectIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.womenBtn);
            make.top.mas_equalTo(self.womenBtn.mas_bottom).offset(16);
            make.width.mas_equalTo(26);
            make.height.mas_equalTo(18);
        }];
    }
    else
    {
        //性别未知的情况下，勾选在女性下方，但是自身隐藏看不到
        [self.selectIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.womenBtn);
            make.top.mas_equalTo(self.womenBtn.mas_bottom).offset(16);
            make.width.mas_equalTo(26);
            make.height.mas_equalTo(18);
        }];
        self.selectIV.hidden = YES;
    }
}

#pragma mark - lazylaod

- (UIView *)maskView
{
    if(!_maskView)
    {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.3f;
        _maskView.userInteractionEnabled = YES;
        //添加单击手势
        UITapGestureRecognizer *tapGset = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDidClickmaskView:)];
        tapGset.numberOfTapsRequired = 1;
        tapGset.numberOfTouchesRequired = 1;
        [_maskView addGestureRecognizer:tapGset];
    }
    return _maskView;
}
- (UIView *)popView
{
    if(!_popView)
    {
        _popView = [[UIView alloc] init];
        _popView.backgroundColor = kColorBgMain;
    }
    return _popView;
}
- (UIButton *)manBtn
{
    if(!_manBtn)
    {
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _manBtn.tag = ABSexMan;
        [_manBtn setImage:[UIImage imageNamed:@"personal_man_icon"] forState:UIControlStateNormal];
        [_manBtn setImage:[UIImage imageNamed:@"personal_man_icon"] forState:UIControlStateHighlighted];
        [_manBtn setImage:[UIImage imageNamed:@"personal_man_icon_active"] forState:UIControlStateSelected];
        [_manBtn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _manBtn;
}
- (UIButton *)womenBtn
{
    if(!_womenBtn)
    {
        _womenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _womenBtn.tag = ABSexWomen;
        [_womenBtn setImage:[UIImage imageNamed:@"personal_woman_icon"] forState:UIControlStateNormal];
        [_womenBtn setImage:[UIImage imageNamed:@"personal_woman_icon"] forState:UIControlStateHighlighted];
        [_womenBtn setImage:[UIImage imageNamed:@"personal_woman_icon_active"] forState:UIControlStateSelected];
        [_womenBtn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _womenBtn;
}
- (UIImageView *)selectIV
{
    if(!_selectIV)
    {
        _selectIV = [[UIImageView alloc] init];
        _selectIV.contentMode = UIViewContentModeScaleAspectFill;
        _selectIV.layer.masksToBounds = YES;
        _selectIV.image = [UIImage imageNamed:@"personal_yes_icon"];
        _selectIV.userInteractionEnabled = NO;
    }
    return _selectIV;
}

#pragma mark - 监听点击事件

- (void)btnDidClick:(UIButton *)sender
{
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.selectBtn.selected = YES;
    
    //平移对勾
    CGPoint center = self.selectIV.center;
    center.x = sender.centerX;
    self.selectIV.center = center;
    self.selectIV.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self handleDidClickmaskView:nil];
    });
    
}
//点击空白区域隐藏maskView
- (void)handleDidClickmaskView:(UITapGestureRecognizer *)tapGest
{
    NSLog(@"%@", tapGest.view);
    
    //判断是否修改性别
    if(_originSex != self.selectBtn.tag)
    {
        
        _model.sex = self.selectBtn.tag;
        if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
        {
            if ([[DataBaseManager shareInstanceDataBase] successUpdateContacterModle:_model])
            {
                //发布通知 - 修改联系人
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationContacterChange object:nil];
            }
        }
    }
    
    self.hidden = YES;
}


@end
