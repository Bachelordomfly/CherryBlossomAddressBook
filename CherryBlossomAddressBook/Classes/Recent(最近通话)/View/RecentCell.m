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
@property (nonatomic, strong) UIImageView *sexImageView;

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
@property (nonatomic, strong) ContacterModel *contacterModel;

@end

@implementation RecentCell

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.sexImageView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.phoneLab];
        [self.contentView addSubview:self.timeLab];
    }
    return self;
}

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5.f;
    
    //头像
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(margin);
        make.width.mas_equalTo(kSimpleCellHeight - 2*margin);
    }];
    
    //性别
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    //姓名
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    //电话
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    //时间
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

#pragma mark - lazy load

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView)
    {
        
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
- (UILabel *)nameLab
{
    if (!_nameLab)
    {
        
    }
    return _nameLab;
}
- (UILabel *)phoneLab
{
    if (!_phoneLab)
    {
        
    }
    return _phoneLab;
}
- (UILabel *)timeLab
{
    if (!_timeLab)
    {
        
    }
    return _timeLab;
}










@end
