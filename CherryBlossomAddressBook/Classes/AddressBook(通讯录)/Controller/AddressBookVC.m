//
//  AddressBookVC.m
//  AddressBook2.0
//
//  Created by xujiajia on 15/11/3.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "AddressBookVC.h"

@interface AddressBookVC ()

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation AddressBookVC

#pragma mark - init

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"所有联系人";
    [self initChilds];
}

-(void)initChilds{

    _searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.view addSubview:_searchBar];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.data.count;
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"PCVCcell";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



@end

@implementation AddressBookCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kColorAppMain;
        UIView *fixView =[self.contentView addShadowTanView];
        
        UIImageView *avatorImageView = [[UIImageView alloc]init];
        avatorImageView.image = [UIImage imageNamed:@"login_id_icon"];
        [fixView addSubview:avatorImageView];
        [avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.imageView);
            make.left.equalTo(self).offset(20);
            make.centerY.equalTo(self);
        }];
        
        UILabel *nameLable = [[UILabel alloc]init];
        nameLable.text = @"jiajia";
        nameLable.font = [UIFont systemFontOfSize:25];
        [fixView addSubview:nameLable];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.textLabel);
            make.left.equalTo(avatorImageView.mas_right).offset(10);
            make.centerY.equalTo(avatorImageView);
        }];
        
        
        
    }
    return self;
}


@end
