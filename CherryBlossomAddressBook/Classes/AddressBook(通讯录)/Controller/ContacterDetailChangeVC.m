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

@end

@implementation ContacterDetailChangeVC

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
    _originalInfo = oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = oldInfo;
}
//昵称
- (void)prepareCellTitle:(NSString *)title
         CellContentInfo:(NSString *)oldInfo
ContacterDetailChangeNickNameBlock:(ContacterDetailChangeNickNameBlock)contacterDetailChangeNickNameBlock
{
    _changeType = ContacterDetailChangeNickName;
    _nickNameBlock = contacterDetailChangeNickNameBlock;
    _originalInfo = oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = oldInfo;
}

//电话号
- (void)prepareCellTitle:(NSString *)title
         CellContentInfo:(NSString *)oldInfo
ContacterDetailChangePhoneBlock:(ContacterDetailChangePhoneBlock)contacterDetailChangePhoneBlock
{
    _changeType = ContacterDetailChangePhone;
    _phoneBlock = contacterDetailChangePhoneBlock;
    _originalInfo = oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = oldInfo;
}
//地址
- (void)prepareCellTitle:(NSString *)title CellContentInfo:(NSString *)oldInfo ContacterDetailChangeAddressBlock:(ContacterDetailChangeAddressBlock)contacterDetailChangeAddressBlock
{
    _changeType = ContacterDetailChangeAddress;
    _addressBlock = contacterDetailChangeAddressBlock;
    _originalInfo = oldInfo;
    self.title = [NSString stringWithFormat:@"%@编辑", title];
    self.editView.text = oldInfo;
}

#pragma mark - 监听事件

- (void)saveItemDidClick
{
//    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
    //判断是否修改
    if(![_originalInfo isEqualToString:self.editView.text])
    {
        //辨认修改哪些信息，然后向服务器发起相应请求（服务器接受修改并成功返回新信息，然后发布通知，告诉各个页面从而更新数据）
        weakSelf(self);
        switch (_changeType) {
            case ContacterDetailChangeName:
            {
//                [[UserManager shareInstance] requestInfoManagerWithName:weakSelf.editView.text nickName:nil sex:nil weXinNumber:nil storeName:nil];
            }
                break;
            case ContacterDetailChangeNickName:
            {
//                [[UserManager shareInstance] requestInfoManagerWithName:nil nickName:weakSelf.editView.text sex:nil weXinNumber:nil storeName:nil];
            }
                break;
            case ContacterDetailChangePhone:
            {
//                [[UserManager shareInstance] requestInfoManagerWithName:nil nickName:nil sex:nil weXinNumber:weakSelf.editView.text storeName:nil];
            }
                break;
            case ContacterDetailChangeAddress:
            {
//                [[UserManager shareInstance] requestInfoManagerWithName:nil nickName:nil sex:nil weXinNumber:nil storeName:self.editView.text];
            }
                break;
                
            default:
                break;
        }

    }
    
    [self didClickBack:nil];
}

@end


