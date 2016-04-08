//
//  UserProfileHeaderCell.h
//  Penkr
//
//  Created by RenSihao on 15/12/10.
//  Copyright © 2015年 ShopEX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContacterModel;

@protocol ContacterAvatarCellDelegate <NSObject>

- (void)didClickAvatarImageView:(UIImageView *)avatarImageView;

@end

@interface ContacterAvatarCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) ContacterModel *contacterModel;
@property (nonatomic, weak) id<ContacterAvatarCellDelegate> delegate;

+ (CGFloat) cellHeight;

- (void)updateWithUserModel:(ContacterModel *)userModel;

@end
