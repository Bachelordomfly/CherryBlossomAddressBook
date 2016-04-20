//
//  UITextField+Category.h
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTag.h"

@interface UITextField (Category)

@property (nonatomic, strong) UIColor *placeholderColor;
@end

@interface SKTag (Util)

- (void)setSelected:(BOOL)selected;

@end