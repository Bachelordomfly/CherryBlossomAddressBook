//
//  LoginViewController.m
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "LoginVC.h"
#import "RegisteVC.h"
#import "PersonalCollectVC.h"

@interface LoginVC ()

/**
 *  背景视图
 */
@property (nonatomic, strong) UIImageView *backGroundImageView;
/**
 *  账号框
 */
@property (nonatomic, strong) SPTextFieldView *userName;
/**
 *  密码框
 */
@property (nonatomic, strong) SPTextFieldView *passWd;
/**
 *  登录按钮
 */
@property (nonatomic, strong) JJButton *loginButton;
/**
 *  注册按钮
 */
@property (nonatomic, strong) JJButton *registerButton;

@end

@implementation LoginVC

#pragma mark - life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addAllSubViews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - private method

/**
 *  添加所有子控件
 */
-(void)addAllSubViews
{
    [self.view addSubview:self.backGroundImageView];
    [self.backGroundImageView addSubview:self.userName];
    [self.backGroundImageView addSubview:self.passWd];
    [self.backGroundImageView addSubview:self.loginButton];
    [self.backGroundImageView addSubview:self.registerButton];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //背景图片
    [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //账号
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundImageView).offset(5*IMAGE_WIDTH);
        make.left.equalTo(self.backGroundImageView).offset(IMAGE_WIDTH);
        make.right.equalTo(self.backGroundImageView).offset(-IMAGE_WIDTH);
        make.height.mas_equalTo(45);
    }];
    
    //密码
    [self.passWd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.right.equalTo(self.userName);
        make.top.equalTo(self.userName.mas_bottom).offset(0.5*IMAGE_WIDTH);
    }];
    
    //登录
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(self.passWd);
        make.top.mas_equalTo(self.passWd.mas_bottom).offset(2*IMAGE_WIDTH);
    }];
    
    //注册
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(0.5*IMAGE_WIDTH);
    }];
}

#pragma mark - getter

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView)
    {
        _backGroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
        _backGroundImageView.backgroundColor = [UIColor whiteColor];
        _backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backGroundImageView.layer.masksToBounds = YES;
        _backGroundImageView.userInteractionEnabled = YES;
    }
    return _backGroundImageView;
}
-(SPTextFieldView *)userName{
    
    if (!_userName) {
        _userName = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageLeft];
        _userName.textField.placeholder = @"请输入用户名";
        _userName.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_userName.imageBtn setImage:[UIImage imageNamed:@"login_id_icon"] forState:UIControlStateNormal];
        _userName.textField.tag = Account;
    }
    return _userName;
}

-(SPTextFieldView *)passWd{
    
    if (!_passWd) {
        _passWd = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageLeft];
        _passWd.textField.placeholder = @"请输入密码";
        _passWd.textField.secureTextEntry = YES;
        _passWd.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_passWd.imageBtn setImage:[UIImage imageNamed:@"login_password_icon"] forState:UIControlStateNormal];
        _passWd.textField.tag = Password;
        
    }
    return _passWd;
}
- (JJButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [[JJButton alloc]initWithFrame:CGRectMake(30, 230, 260, 50) buttonStyle:HTPressableButtonStyleRounded];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(didClickLogin:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _loginButton;
}
- (JJButton *)registerButton
{
    if (!_registerButton)
    {
        _registerButton = [[JJButton alloc]initWithFrame:CGRectMake(30, 230, 260, 50) buttonStyle:HTPressableButtonStyleRounded];
        [_registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(didClickRegister:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerButton;
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

/**
 *  点击登录
 *
 */
- (void)didClickLogin:(JJButton *)sender
{
//    if (self.userName.textField.text.length == 0)
//    {
//        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
//        return ;
//    }
//    if (self.passWd.textField.text.length == 0)
//    {
//        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
//        return ;
//    }
    
    //查询数据库

}
/**
 *  点击注册
 */
- (void)didClickRegister:(JJButton *)sender
{
    RegisteVC *registeVC = [[RegisteVC alloc] init];
    [self.navigationController pushViewController:registeVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 键盘事件处理
//键盘出现
- (void)keyboardAppear:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if(keyboardFrame.origin.y > CGRectGetMaxY(self.loginButton.frame)+8)
    {
        return ;
    }
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    
    
    if (firstResponder.tag == Account)
    {
        CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.loginButton.frame);
        self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
    }
    else if (firstResponder.tag == Password)
    {
        CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.registerButton.frame);
        self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
    }
}
- (void)keyboardChange:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)keyboardDisappear:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}





@end
