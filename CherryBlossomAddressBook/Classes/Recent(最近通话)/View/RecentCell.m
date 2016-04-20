//
//  RecentCell.m
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "RecentCell.h"
#import "ContacterModel.h"

@interface RecentCell ()

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 *  性别
 */
<<<<<<< HEAD
@property (nonatomic, strong) UIImageView *sexImageView;
=======
//@property (nonatomic, strong) UIImageView *sexImageView;
>>>>>>> Bachelordomfly/master

/**
 *  备注
 */
@property (nonatomic, strong) UILabel *nameLab;

/**
 *  电话
 */
@property (nonatomic, strong) UILabel *phoneLab;

/**
 *  时间
 */
@property (nonatomic, strong) UILabel *timeLab;

/**
 *  联系人模型
 */
<<<<<<< HEAD
@property (nonatomic, strong) ContacterModel *contacterModel;
=======
//@property (nonatomic, strong) ContacterModel *contacterModel;
>>>>>>> Bachelordomfly/master

@end

@implementation RecentCell

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
<<<<<<< HEAD
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.sexImageView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.phoneLab];
        [self.contentView addSubview:self.timeLab];
=======
        self.backgroundColor = kColorAppMain;
        UIView *fixView =[self.contentView addShadowTanView];
        
        [fixView addSubview:self.avatarImageView];
        [fixView addSubview:self.nameLab];
        [fixView addSubview:self.phoneLab];
        [fixView addSubview:self.timeLab];
>>>>>>> Bachelordomfly/master
    }
    return self;
}

<<<<<<< HEAD
#pragma mark - 

- (void)configureCellWithContacterModel:(ContacterModel *)contacterModel
{
    _contacterModel = contacterModel;
    
    //头像
    if (_contacterModel.avatarPath.length > 0)
    {
        self.avatarImageView.image = [UIImage imageNamed:_contacterModel.avatarPath];
    }
    else
    {
        
    }
    
    //性别
    if (_contacterModel.sex == ABSexMan)
    {
        self.sexImageView.image = [UIImage imageNamed:@"man_manager_icon"];
    }
    else if ((_contacterModel.sex == ABSexWomen))
    {
        self.sexImageView.image = [UIImage imageNamed:@"woman_manager_icon"];
    }
    else
    {
        
    }
    
    
    
    
}
=======
>>>>>>> Bachelordomfly/master

- (void)layoutSubviews
{
    [super layoutSubviews];
<<<<<<< HEAD
    
    CGFloat margin = 5.f;
    
    //头像
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(margin);
        make.width.mas_equalTo(kSimpleCellHeight - 2*margin);
    }];
    
    //性别
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
=======
    //头像
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
>>>>>>> Bachelordomfly/master
    }];
    
    //姓名
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
<<<<<<< HEAD
        
=======
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        make.bottom.equalTo(self.avatarImageView);
>>>>>>> Bachelordomfly/master
    }];
    
    //电话
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
<<<<<<< HEAD
        
=======
        make.left.equalTo(self.nameLab.mas_right).offset(5);
        make.bottom.mas_equalTo(self.nameLab);
>>>>>>> Bachelordomfly/master
    }];
    
    //时间
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
<<<<<<< HEAD
        
=======
        make.bottom.equalTo(self.nameLab);
        make.right.equalTo(self.contentView).offset(-20);
>>>>>>> Bachelordomfly/master
    }];
}

#pragma mark - lazy load

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView)
    {
<<<<<<< HEAD
        
    }
    return _avatarImageView;
}
- (UIImageView *)sexImageView
{
    if (!_sexImageView)
    {
        
    }
    return _sexImageView;
}
=======
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.image = [UIImage imageNamed:@"overlookCall"];
    }
    return _avatarImageView;
}

>>>>>>> Bachelordomfly/master
- (UILabel *)nameLab
{
    if (!_nameLab)
    {
<<<<<<< HEAD
        
=======
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = [UIFont systemFontOfSize:24];
        _nameLab.text = @"jiajia";
>>>>>>> Bachelordomfly/master
    }
    return _nameLab;
}
- (UILabel *)phoneLab
{
    if (!_phoneLab)
    {
<<<<<<< HEAD
        
=======
        _phoneLab = [[UILabel alloc]init];
        _phoneLab.font = [UIFont systemFontOfSize:14];
        [_phoneLab setTextColor:[UIColor grayColor]];
        _phoneLab.text = @"13162558525";
>>>>>>> Bachelordomfly/master
    }
    return _phoneLab;
}
- (UILabel *)timeLab
{
    if (!_timeLab)
    {
<<<<<<< HEAD
        
=======
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:14];
        [_timeLab setTextColor:[UIColor grayColor]];
        _timeLab.text = @"2016-4-19";
>>>>>>> Bachelordomfly/master
    }
    return _timeLab;
}










@end
