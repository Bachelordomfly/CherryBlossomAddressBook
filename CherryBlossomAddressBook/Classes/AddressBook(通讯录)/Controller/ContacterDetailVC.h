//
//  ContacterDetailVC.h
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "BaseTableVC.h"

/**
 *  联系人详情列表分组
 */
typedef NS_OPTIONS(NSUInteger, ContacterSectionType) {
    /**
     *  头像、姓名
     */
    ContacterSectionTypeTop,
    /**
     *  备注名、ContacterDetailChangeNickName
     */
    ContacterSectionTypeMid,
    /**
     *  电话、地址
     */
    ContacterSectionTypeBottom
};


@interface ContacterDetailVC : BaseTableVC

- (instancetype)initWithContacterModel:(ContacterModel *)model;
@end


/**
 *  地址cell
 */
@interface ContacterAddressCell : BaseTableViewCell

@property (nonatomic, strong) UITextView *remarkTV;

+ (CGFloat)cellHeight;
- (void)updateWithContact:(ContacterModel *)contact;
@end