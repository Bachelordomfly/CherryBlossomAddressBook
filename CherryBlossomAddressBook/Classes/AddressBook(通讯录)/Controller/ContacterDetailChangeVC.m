//
//  ContacterDetailChangeVC.m
//  Penkr
//
//  Created by RenSihao on 15/12/14.
//  Copyright © 2015年 ShopEX. All rights reserved.
//

#import "ContacterDetailChangeVC.h"

@interface ContacterDetailChangeVC ()

//原始信息
@property (nonatomic, copy) NSString *originalInfo;
//编辑输入框
@property (nonatomic, strong) UITextView *editView;

@property (nonatomic, strong) ContacterModel *contacterModel;
@end

@implementation ContacterDetailChangeVC

#pragma mark - init

- (instancetype)initWithContacterModel:(ContacterModel *)contacter
{
    if (self = [super init])
    {
        _contacterModel = contacter;
    }
    return self;
}

#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加新信息编辑框
    [self.view addSubview:self.editView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.editView becomeFirstResponder];
}

#pragma mark - NaviBar

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemDidClick)];
    self.navigationItem.rightBarButtonItem = saveItem;
}

#pragma mark - 子控件

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.mas_equalTo(self.view);
    }];
}

#pragma mark - lazyload

- (UITextView *)editView
{
    if(!_editView)
    {
        _editView = [[UITextView alloc] init];
        _editView.backgroundColor = kColorBgMain;
        _editView.textColor = kColorTextMain;
        _editView.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:16.f];
        _editView.textContainerInset = UIEdgeInsetsMake(16, 20, 0, 20);
        _editView.autocorrectionType = UITextAutocorrectionTypeNo;
        _editView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _editView;
}

#pragma mark - Block

/**
 *  修改用户姓名
 *
 *  @param title
 *  @param oldInfo
 *  @param ContacterDetailChangeNameBlock
 */
- (void)prepareCellTitle:(NSString *)title
         CellContentInfo:(NSString *)oldInfo
ContacterDetailChangeNameBlock:(ContacterDetailChangeNameBlock)contacterDetailChangeNameBlock
{
    _changeType = ContacterDetailChangeName;
    _nameBlock = contacterDetailChangeNameBlock;
    _originalInfo = ([oldInfo isEqualToString:@"暂无"]? @"" : oldInfo);
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = _originalInfo;
}
//昵称
- (void)prepareCellTitle:(NSString *)title
         CellContentInfo:(NSString *)oldInfo
ContacterDetailChangeNickNameBlock:(ContacterDetailChangeNickNameBlock)contacterDetailChangeNickNameBlock
{
    _changeType = ContacterDetailChangeNickName;
    _nickNameBlock = contacterDetailChangeNickNameBlock;
    _originalInfo = [oldInfo isEqualToString:@"暂无"] ? @"" : oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = _originalInfo;
}

//电话号
- (void)prepareCellTitle:(NSString *)title
         CellContentInfo:(NSString *)oldInfo
ContacterDetailChangePhoneBlock:(ContacterDetailChangePhoneBlock)contacterDetailChangePhoneBlock
{
    _changeType = ContacterDetailChangePhone;
    _phoneBlock = contacterDetailChangePhoneBlock;
    _originalInfo = [oldInfo isEqualToString:@"暂无"] ? @"" : oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = _originalInfo;
}
//地址
- (void)prepareCellTitle:(NSString *)title CellContentInfo:(NSString *)oldInfo ContacterDetailChangeAddressBlock:(ContacterDetailChangeAddressBlock)contacterDetailChangeAddressBlock
{
    _changeType = ContacterDetailChangeAddress;
    _addressBlock = contacterDetailChangeAddressBlock;
    _originalInfo = [oldInfo isEqualToString:@"暂无"] ? @"" : oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = _originalInfo;
}

#pragma mark - 监听事件

- (void)saveItemDidClick
{
    //判断是否修改
    if(![_originalInfo isEqualToString:self.editView.text] &&
       [[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
    {
        //记录修改的联系人模型
        switch (_changeType) {
            case ContacterDetailChangeName:
            {
                _contacterModel.name = self.editView.text;
            }
                break;
            case ContacterDetailChangeNickName:
            {
                _contacterModel.nickName = self.editView.text;
            }
                break;
            case ContacterDetailChangePhone:
            {
                _contacterModel.phone = self.editView.text;
            }
                break;
            case ContacterDetailChangeAddress:
            {
                _contacterModel.address = self.editView.text;
            }
                break;
                
            default:
                break;
        }
        
        //更新 - 修改联系人数据库
        if ([[DataBaseManager shareInstanceDataBase] successUpdateContacterModle:_contacterModel])
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            weakSelf(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [weakSelf didClickBack:nil];
            });
            
            //修改联系人 - 发布通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationContacterChange object:nil];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"原信息和新信息不能一样"];
    }
    
    
    
    
    
}

@end


