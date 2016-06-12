//
//  DialVC.m
//  AddressBook2.0
//
//  Created by xujiajia on 15/11/3.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "DialVC.h"

#define ROW 4
#define COL 3
#define ButtonWidth 90.f

@interface DialVC () <UITextFieldDelegate>

/**
 *  电话数字框
 */
@property (nonatomic, strong) UILabel *displayLab;

/**
 *  删除按钮
 */
@property (nonatomic, strong) UIButton *deleteBtn;

/**
 *  拨号按钮
 */
@property (nonatomic, strong) UIButton *dialBtn;

/**
 *  当前输入
 */
@property (nonatomic, copy) NSString *currentPhone;

/**
 *  所有数字按钮 包括 *键 #键
 */
@property (nonatomic, strong) NSMutableArray *numberBtnArray;
@end

@implementation DialVC

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"拨号";
    
    [self addAllSubViews];
}

#pragma mark - private method

- (void)addAllSubViews
{
    CGFloat margin = 5;
    
    //添加号码框
    [self.view addSubview:self.displayLab];
    [self.displayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(margin);
        make.left.mas_equalTo(self.view).offset(margin*10);
        make.right.mas_equalTo(self.view).offset(-margin*10);
        make.height.mas_equalTo(60);
    }];
    
    //添加删除按钮
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.displayLab.mas_right);
        make.centerY.mas_equalTo(self.displayLab);
        make.width.height.mas_equalTo(30);
    }];

    //添加数字按钮(九宫格大法)
    [self addDigitalButtons];
    
    //添加拨号按钮
    [self.view addSubview:self.dialBtn];
    [self.dialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-55);
        make.height.width.mas_equalTo(ButtonWidth);
    }];
    
}

- (void)addDigitalButtons
{
    //数字按钮背景图
    UIView *bgView = [[UIView alloc]init];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(88*3+10*4);
        make.height.mas_equalTo(88*4+10*4);
        make.top.mas_equalTo(self.displayLab.mas_bottom);
        make.centerX.mas_equalTo(self.view);
    }];
    
    CGFloat width = 88;
    CGFloat height = 88;
    CGFloat margin = 10;
    
    //九宫格创建数字按钮
    for (int i=0; i<ROW*COL; i++)
    {
        int row = i/COL;//行号
        int loc = i%COL;//列号
        
        CGFloat x = margin+(margin+width)*loc;
        CGFloat y = margin+(margin+height)*row;
        
        
        UIButton *numberBtn=[[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        if (i <= 8)
        {
            [numberBtn setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        }
        else if (i == 9)
        {
            [numberBtn setTitle:@"*" forState:UIControlStateNormal];
        }
        else if (i == 10)
        {
            [numberBtn setTitle:@"0" forState:UIControlStateNormal];
        }
        else
        {
            [numberBtn setTitle:@"#" forState:UIControlStateNormal];
        }
        numberBtn.tag = i;
        numberBtn.layer.cornerRadius = 88 / 2;
        numberBtn.layer.masksToBounds = YES;
        [numberBtn addTarget:self action:@selector(didClickNumber:) forControlEvents:UIControlEventTouchUpInside];
        [numberBtn setBackgroundImage:[UIImage imageWithColor:kColorMain cornerRadius:0] forState:UIControlStateNormal];
        [numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [numberBtn.titleLabel setFont:[UIFont fontWithName:kDefaultRegularFontFamilyName size:40]];
        [bgView addSubview:numberBtn];
        [self.numberBtnArray addObject:numberBtn];
    }
}


#pragma mark - lazy load
- (NSMutableArray *)numberBtnArray
{
    if (!_numberBtnArray)
    {
        _numberBtnArray = [NSMutableArray arrayWithCapacity:ROW*COL];
    }
    return _numberBtnArray;
}

- (UILabel *)displayLab
{
    if(!_displayLab)
    {
        _displayLab = [UILabel new];
        _displayLab.textColor = [UIColor blackColor];
        _displayLab.textAlignment = NSTextAlignmentCenter;
        _displayLab.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:35];
    }
    return _displayLab;
}
- (UIButton *)deleteBtn
{
    if (!_deleteBtn)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.hidden = YES;
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
- (UIButton *)dialBtn
{
    if (!_dialBtn)
    {
        _dialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dialBtn.layer.cornerRadius = ButtonWidth / 2;
        _dialBtn.layer.masksToBounds = YES;
        _dialBtn.layer.borderWidth = 5;
        _dialBtn.layer.borderColor = [kColorMain CGColor];
        _dialBtn.titleLabel.font = [UIFont fontWithName:kDefaultBoldFontFamilyName size:23];
        [_dialBtn setTitle:@"Call" forState:UIControlStateNormal];
        [_dialBtn setTitleColor:kColorMain forState:UIControlStateNormal];
        [_dialBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:0] forState:UIControlStateNormal];
        [_dialBtn addTarget:self action:@selector(dial:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dialBtn;
}

#pragma mark - 点击事件

- (void)didClickNumber:(UIButton *)sender
{
    NSString *currentPhoneStr = self.displayLab.text ?: @"";
    if (currentPhoneStr.length == 11)
    {
        return ;
    }
    self.deleteBtn.hidden = NO;
    self.displayLab.text = [currentPhoneStr stringByAppendingString:sender.currentTitle];
    
    //纯数字
    if (sender.tag <= 8 || sender.tag == 10)
    {
        
    }
    // * 键
    else if (sender.tag == 9)
    {
        
    }
    // # 键
    else if (sender.tag == 11)
    {
        
    }
    
}
- (void)delete:(UIButton *)sender
{
    NSString *currentPhoneStr = self.displayLab.text ?: @"";
    if (currentPhoneStr.length > 0)
    {
        NSString *resultPhoneStr = [currentPhoneStr substringToIndex:currentPhoneStr.length-1];
        self.displayLab.text = resultPhoneStr;
        if ([resultPhoneStr isEqualToString:@""])
        {
            self.deleteBtn.hidden = YES;
        }
    }
    else
    {
        return ;
    }
}

- (void)dial:(UIButton *)sender
{
    if ([[AppManager sharedInstance] callPhoneWithPhoneNumber:self.displayLab.text])
    {
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"无效号码！"];
    }
}










@end
