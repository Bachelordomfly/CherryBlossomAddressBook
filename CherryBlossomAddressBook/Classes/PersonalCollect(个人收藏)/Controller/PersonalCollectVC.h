
//  AddressBook2.0
//
//  Created by xujiajia on 15/11/3.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "BaseTableVC.h"

@interface PersonalCollectVC : BaseTableVC

@end

@interface PersonalCollectCell : UITableViewCell
@property (nonatomic, strong) UIImageView   *avatorImageView;
@property (nonatomic, strong) UILabel       *nameLable;
@property (nonatomic, strong) UILabel       *areaLable;
@property (nonatomic, strong) UIButton      *checkButton;


@end