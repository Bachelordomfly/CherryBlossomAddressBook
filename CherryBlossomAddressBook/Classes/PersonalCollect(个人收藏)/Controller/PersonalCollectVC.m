//
//  PersonalCollectVC.m
//  AddressBook2.0
//
//  Created by XuJiajia on 15/11/3.
//  Copyright © 2015年 XuJiajia. All rights reserved.
//

#import "PersonalCollectVC.h"
#import "LoginVC.h"
#import "AddPersonVC.h"

@interface PersonalCollectVC ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) LoginVC *loginViewController;
@property (nonatomic, assign) BOOL isEditable;

@end

@implementation PersonalCollectVC

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"个人收藏";
    
    self.loginViewController = [[LoginVC alloc]init];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemAction:)];
}




#pragma mark - 自定义方法
/**
 加载数据源
 */
- (NSMutableArray *)data
{
    if(!_data)
    {
        _data = [NSMutableArray array];
        [_data addObject:@"jiajia"];
        [_data addObject:@"jiajia"];
        [_data addObject:@"jiajia"];
        [_data addObject:@"jiajia"];
        [_data addObject:@"jiajia"];
        
    }
    return _data;
}


#pragma mark - leftBarButtomItem
-(void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButtonItem
{
    UIAlertController *alterView = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"确定注销吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //清空本地登录信息
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserSecurityAccount];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserSecurityPassword];
        
        //退出登录 - 发布通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidLogout object:nil];
    }]];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alterView animated:YES completion:nil];
    
    
}

-(void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButtonItem
{
    
    AddPersonVC *addPersonVC = [[AddPersonVC alloc]init];
    [self.navigationController pushViewController:addPersonVC animated:YES];
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
    PersonalCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[PersonalCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UITableViewDelegate


- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end

@interface PersonalCollectCell()
@property (nonatomic, strong) UIImageView   *avatorImageView;
@property (nonatomic, strong) UILabel       *nameLable;
@property (nonatomic, strong) UILabel       *areaLable;
@property (nonatomic, strong) UIButton      *checkButton;
@end

@implementation PersonalCollectCell

-(UIImageView *)avatorImageView{
    
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc]init];
        _avatorImageView.image = [UIImage imageNamed:@"overlookCall"];
    }
    return _avatorImageView;
}

-(UILabel *)nameLable{
    
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.font = [UIFont systemFontOfSize:24];
        _nameLable.text = @"jiajia";
    }
    return _nameLable;
}

-(UIButton *)checkButton{
    
    if (!_checkButton) {
        _checkButton = [[UIButton alloc]init];
        [_checkButton setBackgroundImage:[UIImage imageNamed:@"login_show_icon"] forState:UIControlStateNormal];
    }
    return _checkButton;
}

-(UILabel *)areaLable{
    
    if (!_areaLable) {
        _areaLable = [[UILabel alloc]init];
        _areaLable.font = [UIFont systemFontOfSize:15];
        [_areaLable setTextColor:[UIColor grayColor]];
        _areaLable.text = @"住宅";
    }
    return _areaLable;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kColorAppMain;
        UIView *fixView =[self.contentView addShadowTanView];
        
        //头像
        
        [fixView addSubview:self.avatorImageView];
        [self.avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(50);
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
        }];
        
        //姓名
        
        [fixView addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatorImageView.mas_right).offset(10);
            make.bottom.equalTo(self.avatorImageView);
        }];
        
        //
        [fixView addSubview:self.checkButton];
        [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(fixView.mas_right).offset(-20);
            make.size.mas_equalTo(25);
            make.centerY.equalTo(fixView);
        }];
        
        [fixView addSubview:self.areaLable];
        [self.areaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.checkButton.mas_left).offset(-10);
            make.centerY.equalTo(self.checkButton);
        }];
        
//        [fixView coloredSubviews];
    }
    return self;
}

@end

