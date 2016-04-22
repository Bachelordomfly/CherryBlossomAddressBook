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

@interface DialVC ()

@property (nonatomic, strong) UITextField *headerTF;

@property (nonatomic, strong) NSMutableArray *btnArray;
@end

@implementation DialVC

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"拨号";
    
    //添加头部隐藏视图（特殊）
//    [self.view addSubview:self.headerTF];
    
    //添加数字按钮
    [self addDigitalButtons];
    
    //添加拨号按钮
    [self addDialButton];
    
    
}


#pragma mark - lazyload
- (UITextField *)headerTF
{
    if(!_headerTF)
    {
        _headerTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 50)];
        _headerTF.textAlignment = NSTextAlignmentCenter;
        _headerTF.backgroundColor = kColorAppMain;
        _headerTF.placeholder = @"输入号码";
    }
    return _headerTF;
}

#pragma mark - 自定义方法
- (void)addDigitalButtons
{
    UIView *bkview = [[UIView alloc]init];
    [self.view addSubview:bkview];
    [bkview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(400);
        make.center.equalTo(self.view);
    }];
    
    int totalloc=3;
    CGFloat appvieww=100;
    CGFloat appviewh=100;
    CGFloat margin=0;
    int count=12;
    
    
    for (int i=0; i<count; i++) {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row;
        
        
        //创建uiview控件
        UIButton *numberBtn=[[UIButton alloc]initWithFrame:CGRectMake(appviewx, appviewy, appvieww, appviewh)];

        //[appview setBackgroundColor:[UIColor purpleColor]];
        [bkview addSubview:numberBtn];
        [numberBtn setTitle:@"3" forState:UIControlStateNormal];

        [bkview addSubview:numberBtn];
        [numberBtn setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        [numberBtn setBackgroundColor: [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]];
        
    }
    
}
- (void)addDialButton
{

    UIButton *dialBtn = [[UIButton alloc]init];
    [dialBtn setBackgroundImage:[UIImage imageNamed:@"dial_bg"] forState:UIControlStateNormal];
    [self.view addSubview:dialBtn];
    [dialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
        make.height.width.mas_equalTo(100);
    }];
    
}













@end
