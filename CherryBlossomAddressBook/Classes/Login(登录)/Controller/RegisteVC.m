//
//  RegisteVC.m
//  樱花通讯录
//
//  Created by RenSihao on 16/3/30.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "RegisteVC.h"

@interface RegisteVC () <UITextFieldDelegate>

/**
 *  账户标签
 */
@property (nonatomic, strong) UILabel *accountCheck;
/**
 *  账号输入框
 */
@property (nonatomic, strong) SPTextFieldView *accountTF;
/**
 *  密码标签
 */
@property (nonatomic, strong) UILabel *passwordCheck;
/**
 *  密码输入框
 */
@property (nonatomic, strong) SPTextFieldView *passwordTF;
/**
 *  再次输入密码标签
 */
@property (nonatomic, strong) UILabel *repeatPasswordCheck;
/**
 *  再次输入密码框
 */
@property (nonatomic, strong) SPTextFieldView *repeatPasswordTF;
/**
 *  确认按钮
 */
@property (nonatomic, strong) UIButton *confirmBtn;
/**
 *  账户名字符串
 */
@property (nonatomic, copy) NSString *account;
/**
 *  密码字符串
 */
@property (nonatomic, copy) NSString *password;
/**
 *  重复密码字符串
 */
@property (nonatomic, copy) NSString *repeatPassword;

@end

@implementation RegisteVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self addAllSubViews];
}

#pragma mark -
#pragma mark - 子控件

/**
 *  添加所有子控件
 */
- (void)addAllSubViews
{
    [self.view addSubview:self.accountCheck];
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.passwordCheck];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.repeatPasswordCheck];
    [self.view addSubview:self.repeatPasswordTF];
    [self.view addSubview:self.confirmBtn];
}
/**
 *  设置所有子控件约束（系统自动调用该方法）
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //账号标签
    [self.accountCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(46);
        make.left.mas_equalTo(self.view.mas_left).offset(33);
    }];
    
    
    //账号输入框
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(68);
        make.left.mas_equalTo(self.view.mas_left).offset(23);
        make.right.mas_equalTo(self.view.mas_right).offset(-23);
        make.height.mas_equalTo(44);
    }];
    
    
    //新密码标签
    [self.passwordCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountTF.mas_bottom).offset(17);
        make.left.mas_equalTo(self.accountCheck);
    }];
    
    //新密码输入框
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordCheck.mas_bottom).offset(7);
        make.left.height.right.mas_equalTo(self.accountTF);
    }];
    
    //确认新密码标签
    [self.repeatPasswordCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(17);
        make.left.mas_equalTo(self.passwordCheck);
    }];
    
    //确认新密码输入框
    [self.repeatPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.repeatPasswordCheck.mas_bottom).offset(7);
        make.size.left.mas_equalTo(self.passwordTF);
    }];
    
    
    //确认按钮
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.repeatPasswordTF.mas_bottom).offset(63);
        make.left.right.height.mas_equalTo(self.accountTF);
    }];
}

#pragma mark - getter

- (UILabel *)accountCheck
{
    if(!_accountCheck)
    {
        _accountCheck = [[UILabel alloc] init];
        _accountCheck.text = @"账号";
        _accountCheck.textColor = UIColorFromRGB_0x(0x666666);
        _accountCheck.font = [UIFont systemFontOfSize:13.f];
        [_accountCheck sizeToFit];
    }
    return _accountCheck;
}
- (SPTextFieldView *)accountTF
{
    if(!_accountTF)
    {
        _accountTF = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageNone];
        _accountTF.textField.placeholder = @"输入新的账户名";
        _accountTF.textField.keyboardType = UIKeyboardTypeDefault;
        _accountTF.textField.delegate = self;
        _accountTF.textField.tag = Account;
    }
    return _accountTF;
}
- (UILabel *)passwordCheck
{
    if (!_passwordCheck)
    {
        _passwordCheck = [[UILabel alloc] init];
        _passwordCheck.text = @"新密码";
        _passwordCheck.textColor = UIColorFromRGB_0x(0x666666);
        _passwordCheck.font = [UIFont systemFontOfSize:13.f];
        [_passwordCheck sizeToFit];
  
    }
    return _passwordCheck;
}
- (SPTextFieldView *)passwordTF
{
    if(!_passwordTF)
    {
        _passwordTF = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageRight];
        [_passwordTF.imageBtn setImage:[UIImage imageNamed:@"login_hide_icon"] forState:UIControlStateNormal];
        [_passwordTF.imageBtn setImage:[UIImage imageNamed:@"login_show_icon"] forState:UIControlStateSelected];
        _passwordTF.textField.secureTextEntry = YES;
        _passwordTF.textField.placeholder = @"输入新的密码";
        _passwordTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _passwordTF.textField.delegate = self;
        _passwordTF.textField.tag = Password;
    }
    return _passwordTF;
}

- (UILabel *)repeatPasswordCheck
{
    if (!_repeatPasswordCheck)
    {
        _repeatPasswordCheck = [[UILabel alloc] init];
        _repeatPasswordCheck.text = @"确认新密码";
        _repeatPasswordCheck.textColor = UIColorFromRGB_0x(0x666666);
        _repeatPasswordCheck.font = [UIFont systemFontOfSize:13.f];
        [_repeatPasswordCheck sizeToFit];
    }
    return _repeatPasswordCheck;
}
- (SPTextFieldView *)repeatPasswordTF
{
    if (!_repeatPasswordTF)
    {
        _repeatPasswordTF = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageRight];
        [_repeatPasswordTF.imageBtn setImage:[UIImage imageNamed:@"login_hide_icon"] forState:UIControlStateNormal];
        [_repeatPasswordTF.imageBtn setImage:[UIImage imageNamed:@"login_show_icon"] forState:UIControlStateSelected];
        _repeatPasswordTF.textField.secureTextEntry = YES;
        _repeatPasswordTF.textField.placeholder = @"重复输入新密码";
        _repeatPasswordTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _repeatPasswordTF.textField.delegate = self;
        _repeatPasswordTF.textField.tag = RepeatPassword;
    }
    return _repeatPasswordTF;
}
- (UIButton *)confirmBtn
{
    if(!_confirmBtn)
    {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = kColorAppMain;
        [_confirmBtn setTitle:@"确  认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:kColorBgMain forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
        [_confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_confirmBtn.layer setCornerRadius:2.f];
        [_confirmBtn.layer setMasksToBounds:YES];
        [_confirmBtn addTarget:self action:@selector(confirmBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - 通知相关

- (void)addNotificationObservers
{
    [super addNotificationObservers];
    
    //键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeNotificationObservers
{
    [super removeNotificationObservers];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听点击事件

- (void)confirmBtnDidClick
{
    self.account = self.accountTF.textField.text;
    self.password = self.passwordTF.textField.text;
    self.repeatPassword = self.repeatPasswordTF.textField.text;
    if (![self.repeatPassword isEqualToString:self.password])
    {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致，请重新输入"];
        return;
    }
    if (self.account.length < 3)
    {
        [SVProgressHUD showErrorWithStatus:@"账号不得少于3位"];
        return;
    }
    if (self.password.length < 6)
    {
        [SVProgressHUD showErrorWithStatus:@"密码不得少于6位"];
        return;
    }
    
    UserModel *newUser = [UserModel new];
    newUser.account = self.account;
    newUser.password = self.password;
    
    //打开数据库
    if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:UserDataBase])
    {
        //查询数据库
        if ([[DataBaseManager shareInstanceDataBase] isExistsOfUserModel:newUser])
        {
            [SVProgressHUD showErrorWithStatus:@"该账号已存在！"];
            return ;
        }
        else
        {
            //写入数据库
            
            if ([[DataBaseManager shareInstanceDataBase] isSuccessRegisterOfUserModel:newUser])
            {
                [SVProgressHUD showSuccessWithStatus:@"注册新用户成功！"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self didClickBack:nil];
                });
                return ;
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"注册新用户失败！"];
                return ;
            }
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"无法打开用户数据库"];
        return ;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击空白结束编辑
    [self.view endEditing:YES];
}

#pragma mark - 键盘事件处理

- (void)keyboardAppear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    
    CGFloat offset = 0.0f;
    if (firstResponder.tag == Account)
    {
        if(keyboardFrame.origin.y > CGRectGetMaxY(self.passwordTF.frame)+8)
        {
            return ;
        }
        offset = keyboardFrame.origin.y - CGRectGetMaxY(self.passwordTF.frame);
    }
    else if (firstResponder.tag == Password)
    {
        if(keyboardFrame.origin.y > CGRectGetMaxY(self.repeatPasswordTF.frame)+8)
        {
            return ;
        }
        offset = keyboardFrame.origin.y - CGRectGetMaxY(self.repeatPasswordTF.frame);
    }
    else if (firstResponder.tag == RepeatPassword)
    {
        if(keyboardFrame.origin.y > CGRectGetMaxY(self.confirmBtn.frame)+8)
        {
            return ;
        }
        offset = keyboardFrame.origin.y - CGRectGetMaxY(self.confirmBtn.frame);
    }
    
    self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
}
- (void)keyboardChange:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)keyboardDisappear:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
}


@end
