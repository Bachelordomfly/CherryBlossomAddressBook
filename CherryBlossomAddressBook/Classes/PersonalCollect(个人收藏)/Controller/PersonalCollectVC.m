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
@end

@implementation PersonalCollectVC

#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    self.navigationItem.title = @"个人收藏";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemAction:)];
    self.loginViewController = [[LoginVC alloc]init];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    //self.tableView.tableHeaderView.hidden = YES;
}

#pragma mark - 自定义方法
/**
 加载数据源
 */
//- (NSMutableArray *)data
//{
//    if(!_data)
//    {
//        _data = [PersonCollectInfo dataFromPlist];
//    }
//    return _data;
//}


#pragma mark-leftBarButtomItem
-(void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButtonItem
{
    UIAlertController *alterView = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"确定注销吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alterView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [self presentViewController:self.loginViewController animated:NO completion:nil]; 
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
    return self.data.count;
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
    cell.avatorImageView.image = [UIImage imageNamed:@"branddefulthead"];
    cell.nameLable.text = @"deavin";
    cell.areaLable.text = @"住宅";
//    cell.accessoryType = UITableViewCellAccessoryDetailButton;
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

@end

@implementation PersonalCollectCell
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        self.backgroundColor = UIColorFromRGB(0xececec);
//        
//        UIView *fixView =[self.contentView addShadowTanView];
//        
//        UIView *view;
//        UIView *preView;
//        
//        _avatorImageView = [[UIImageView alloc]init];
//        [fixView addSubview:_avatorImageView];
//        view = _avatorImageView;
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(self.imageView);
//            make.left.equalTo(self).offset(20);
//            make.centerY.equalTo(self);
//        }];
//        preView = view;
//        
//        _nameLable = [[UILabel alloc]init];
//        _nameLable.font = [UIFont systemFontOfSize:24];
//        [fixView addSubview:_nameLable];
//        view = _nameLable;
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(self.textLabel);
//            make.left.equalTo(preView.mas_right).offset(10);
//            make.top.centerY.equalTo(preView);
//        }];
//        
//        _checkButton = [[UIButton alloc]init];
//        [_checkButton setBackgroundImage:[UIImage imageNamed:@"login_show_icon"] forState:UIControlStateNormal];
//        [fixView addSubview:_checkButton];
//        view = _checkButton;
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(fixView.mas_right).offset(-20);
//            make.size.mas_equalTo(25);
//            make.centerY.equalTo(fixView);
//        }];
//        preView = view;
//        
//        _areaLable = [[UILabel alloc]init];
//        _areaLable.font = [UIFont systemFontOfSize:15];
//        [fixView addSubview:_areaLable];
//        view = _areaLable;
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(preView.mas_left).offset(-10);
//            make.centerY.equalTo(preView);
//        }];
//
//    }
//    return self;
//}

@end
