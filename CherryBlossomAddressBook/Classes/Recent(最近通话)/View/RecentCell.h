//
//  RecentCell.h
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "BaseSimpleCell.h"
@class ContacterModel;

@interface RecentCell : BaseTableViewCell
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 *  性别
 */
//@property (nonatomic, strong) UIImageView *sexImageView;

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

//- (void)configureCellWithContacterModel:(ContacterModel *)contacterModel;
@end
