//
//  LoginViewController.m
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "LoginVC.h"
#import "LoginPersonCollect.h"

@interface LoginVC ()

/**
 *  背景
 */
@property (nonatomic, strong) UIImageView *backGroundImageView;
/**
 *  账号
 */
@property (nonatomic, strong) SPTextFieldView *userName;
/**
 *  密码
 */
@property (nonatomic, strong) SPTextFieldView *passWd;
/**
 *  登录
 */
@property (nonatomic, strong) JJButton *loginButton;
/**
 *  注册
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
    
    
    
//    
//    
//    
//    UIView *contentView = self.view;
//    contentView.backgroundColor = [UIColor whiteColor];
//    UIImageView *baseImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
//    baseImageView.userInteractionEnabled = YES;
//    [contentView addSubview:baseImageView];
//    [baseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(contentView);
//    }];
//    contentView = baseImageView;
//    
//    UIView *view;
//    UIView *preView;
//    
//    view = self.userName;
//    [contentView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(contentView).offset(3*IMAGE_WIDTH);
//        make.left.equalTo(contentView).offset(IMAGE_WIDTH);
//        make.right.equalTo(contentView).offset(-IMAGE_WIDTH);
//        make.height.mas_equalTo(45);
//        
//    }];
//    preView = view;
//    
//    view = self.passWd;
//    [contentView addSubview:_passWd];
//    [_passWd mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.right.equalTo(preView);
//        make.top.equalTo(preView.mas_bottom).offset(0.5*IMAGE_WIDTH);
//    }];
//    preView = view;
//    
//    JJButton *newBtn = [[JJButton alloc]initWithFrame:CGRectMake(30, 230, 260, 50) buttonStyle:HTPressableButtonStyleRounded];
//    [newBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [newBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
//    view = newBtn;
//    [contentView addSubview:newBtn];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.left.equalTo(preView);
//        make.bottom.equalTo(contentView).offset(-2*IMAGE_WIDTH);
//    }];
//    preView = view;
//    
//    JJButton *loginBtn = [[JJButton alloc]initWithFrame:CGRectMake(30, 230, 260, 50) buttonStyle:HTPressableButtonStyleRounded];
//    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
//    view = loginBtn;
//    [contentView addSubview:loginBtn];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.left.equalTo(preView);
//        make.bottom.equalTo(preView.mas_top).offset(-0.5*IMAGE_WIDTH);
//    }];
//    preView = view;
    
    
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
        make.top.equalTo(self.backGroundImageView).offset(3*IMAGE_WIDTH);
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
        make.top.mas_equalTo(self.passWd.mas_bottom).offset(3*IMAGE_WIDTH);
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
    }
    return _backGroundImageView;
}
-(SPTextFieldView *)userName{
    
    if (!_userName) {
        _userName = [[SPTextFieldView alloc]initWithSPTextFieldImageType:SPTextFieldImageLeft];
        _userName.textField.placeholder = @"请输入用户名";
        _userName.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_userName.imageBtn setImage:[UIImage imageNamed:@"login_id_icon"] forState:UIControlStateNormal];
        _userName.textField.tag = 1;
    }
    return _userName;
}

-(SPTextFieldView *)passWd{
    
    if (!_passWd) {
        _passWd = [[SPTextFieldView alloc]initWithSPTextFieldImageType:SPTextFieldImageLeft];
        _passWd.textField.placeholder = @"请输入密码";
        _passWd.textField.secureTextEntry = YES;
        _passWd.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_passWd.imageBtn setImage:[UIImage imageNamed:@"login_password_icon"] forState:UIControlStateNormal];
        _passWd.textField.tag = 1;
        
    }
    return _passWd;
}
- (JJButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [[JJButton alloc]initWithFrame:CGRectMake(30, 230, 260, 50) buttonStyle:HTPressableButtonStyleRounded];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(didClickLogin:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _loginButton;
}
- (JJButton *)registerButton
{
    if (!_registerButton)
    {
        _registerButton = [[JJButton alloc]initWithFrame:CGRectMake(30, 230, 260, 50) buttonStyle:HTPressableButtonStyleRounded];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerButton;
}


#pragma mark - addBtAction

-(void)addAction:(UIButton *)addBt
{
//    FMDatabase *db = [LoginPersonCollect sharedDatabaseUser];
//    NSString *sql_1 = [NSString stringWithFormat:@"SELECT COUNT(*) as count FROM t_adressBook where name=:name"];
//    NSDictionary *dic_1 = @{@"name": self.userName.textField.text};
//    FMResultSet *set = [db executeQuery:sql_1 withParameterDictionary:dic_1];
//    NSInteger count = 0;
//    
//    if (set.next) {
//        count = [set intForColumn:@"count"];
//    }
//    
//    if (count > 0) {
//        AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"注册失败" andText:@"用户名已存在" andCancelButton:YES forAlertType:AlertFailure];
//        [alert show];
//    } else{
//        BOOL result = [db executeUpdate:@"insert into t_adressBook(name,passwd) values(?,?);", self.userName.textField.text,self.passWd.textField.text];
//        if(result)
//        {
//            //            NSLog(@"插入数据成功");
//            AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"注册成功" andText:nil andCancelButton:YES forAlertType:AlertSuccess];
//            [alert show];
//        }
//        else {
//            //            NSLog(@"插入数据失败");
//        }
//    }
//    
//    [set close];
    
}

#pragma mark - 监听点击事件

/**
 *  点击登录
 *
 */
- (void)didClickLogin:(JJButton *)sender
{
    
}
/**
 *  点击注册
 */
- (void)didClickRegister:(JJButton *)sender
{
    
}


-(void)loginAction:(UIButton *)loginBt
{
//    FMDatabase *db = [LoginPersonCollect sharedDatabaseUser];
//    NSString *sql = @"select * from t_adressBook;";
//    FMResultSet *set = [db executeQuery:sql];
//    
//    while ([set next]) {
//        NSString *name = [set stringForColumn:@"name"];
//        NSString *passwd = [set stringForColumn:@"passwd"];
//        
//        if ([self.userName.textField.text isEqualToString:name]) {
//            if (![self.passWd.textField.text isEqualToString:passwd]) {
//                AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"登录失败" andText:@"密码错误" andCancelButton:YES forAlertType:AlertFailure];
//                [alert show];
//                return;
//            }
//            else
//            {
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.mode = MBProgressHUDModeAnnularDeterminate;
//                hud.labelText = @"Loading";
//                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                    [self presentViewController:self.abTabBarController animated:YES completion:^{
//                    }];
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                });
//                return;
//            }
//        }
//        else {
//            continue;
//        }
//        
//    }
//    AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"登录失败" andText:@"用户名错误" andCancelButton:YES forAlertType:AlertFailure];
//    [alert show];
//    return;
}




@end
