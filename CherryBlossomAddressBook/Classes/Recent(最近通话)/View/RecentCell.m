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
 *  联系人模型
 */
//@property (nonatomic, strong) ContacterModel *contacterModel;

@end

@implementation RecentCell

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = kColorAppMain;
        UIView *fixView =[self.contentView addShadowTanView];
        
        [fixView addSubview:self.avatarImageView];
        [fixView addSubview:self.nameLab];
        [fixView addSubview:self.phoneLab];
        [fixView addSubview:self.timeLab];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //头像
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    //姓名
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        make.bottom.equalTo(self.avatarImageView);
    }];
    
    //电话
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).offset(5);
        make.bottom.mas_equalTo(self.nameLab);
    }];
    
    //时间
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLab);
        make.right.equalTo(self.contentView).offset(-20);
    }];
}

#pragma mark - lazy load

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView)
    {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.image = [UIImage imageNamed:@"overlookCall"];
    }
    return _avatarImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab)
    {
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = [UIFont systemFontOfSize:24];
//        _nameLab.text = @"jiajia";
    }
    return _nameLab;
}
- (UILabel *)phoneLab
{
    if (!_phoneLab)
    {
        _phoneLab = [[UILabel alloc]init];
        _phoneLab.font = [UIFont systemFontOfSize:14];
        [_phoneLab setTextColor:[UIColor grayColor]];
        _phoneLab.text = @"13162558525";
    }
    return _phoneLab;
}
- (UILabel *)timeLab
{
    if (!_timeLab)
    {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:14];
        [_timeLab setTextColor:[UIColor grayColor]];
        _timeLab.text = @"2016-4-19";
    }
    return _timeLab;
}










@end
